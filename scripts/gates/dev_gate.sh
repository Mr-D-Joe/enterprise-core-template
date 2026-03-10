#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
GATE_DIR="$BASE_DIR/system_reports/gates"
REPORTS_DIR="$BASE_DIR/reports/tests"
TRACE_FILE="$BASE_DIR/docs/governance/TRACEABILITY_MATRIX_TEMPLATE.md"

mkdir -p "$GATE_DIR" "$REPORTS_DIR"

TIMESTAMP="$(date -u +%Y%m%dT%H%M%SZ)"
GATE_UTC="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
TARGET_SHA="$(git -C "$BASE_DIR" rev-parse HEAD 2>/dev/null || echo unknown)"
SHORT_SHA="$(git -C "$BASE_DIR" rev-parse --short=8 HEAD 2>/dev/null || echo nosha)"
GATE_FILE="$GATE_DIR/dev_gate_${TIMESTAMP}_${SHORT_SHA}.gate"

EXIT_CODE=0
PROMPT_FIREWALL_STATUS="FAIL"
AUDIT_READINESS_STATUS="FAIL"
PIPELINE_ORDER_STATUS="FAIL"
PYTHON_TESTS_IN_SCOPE="false"
UNIT_TEST_EXIT_CODE="0"
INTEGRATION_TEST_EXIT_CODE="0"
UNIT_TEST_STATUS="SKIPPED"
INTEGRATION_TEST_STATUS="SKIPPED"
PER_REQ_COVERAGE_STATUS="FAIL"
EXECUTED_POSITIVE_TEST_COUNT=0
EXECUTED_NEGATIVE_TEST_COUNT=0
TOTAL_EXECUTED_TEST_COUNT=0

log_ok() {
  echo "OK   $1"
}

log_fail() {
  echo "FAIL $1"
  EXIT_CODE=1
}

trim() {
  local value="$1"
  value="${value#${value%%[![:space:]]*}}"
  value="${value%${value##*[![:space:]]}}"
  printf '%s' "$value"
}

read_env_value() {
  local key="$1"
  local file="$2"
  local raw
  raw="$(grep -E "^${key}=" "$file" | tail -n1 || true)"
  if [[ -n "$raw" ]]; then
    printf '%s' "${raw#*=}"
  fi
}

run_check() {
  local script_path="$1"
  local label="$2"
  local status_var="$3"
  if [[ ! -x "$script_path" ]]; then
    printf -v "$status_var" '%s' "FAIL"
    log_fail "$label script missing or not executable: $script_path"
    return
  fi
  if "$script_path"; then
    printf -v "$status_var" '%s' "PASS"
    log_ok "$label"
  else
    printf -v "$status_var" '%s' "FAIL"
    log_fail "$label"
  fi
}

run_req_coverage_check() {
  local req_ids_csv="$1"
  local req_id=""
  local req_matched=0
  local req_pos=0
  local req_neg=0
  local row
  local req_trimmed=""
  local pos_total=0
  local neg_total=0
  local req_fail=0

  if [[ ! -f "$TRACE_FILE" ]]; then
    log_fail "Traceability matrix missing: $TRACE_FILE"
    return
  fi

  IFS=',' read -r -a req_array <<< "$req_ids_csv"
  for req_id in "${req_array[@]}"; do
    req_trimmed="$(trim "$req_id")"
    if [[ -z "$req_trimmed" ]]; then
      continue
    fi

    row="$(awk -F'|' -v req="$req_trimmed" '
      function trim(s) { gsub(/^[ \t]+|[ \t]+$/, "", s); return s }
      $0 ~ /^\|/ {
        req_id = trim($2)
        pos = trim($8)
        neg = trim($11)
        if (req_id == req) {
          matched = 1
          if (pos == "PASS") { pos_pass += 1 }
          if (neg == "PASS") { neg_pass += 1 }
        }
      }
      END {
        printf "%d %d %d", matched + 0, pos_pass + 0, neg_pass + 0
      }
    ' "$TRACE_FILE")"

    req_matched="${row%% *}"
    row="${row#* }"
    req_pos="${row%% *}"
    req_neg="${row#* }"

    if [[ "$req_matched" -eq 0 ]]; then
      log_fail "REQ_ID without traceability row: $req_trimmed"
      req_fail=1
      continue
    fi
    if [[ "$req_pos" -eq 0 ]]; then
      log_fail "REQ_ID without executed positive PASS evidence: $req_trimmed"
      req_fail=1
    fi
    if [[ "$req_neg" -eq 0 ]]; then
      log_fail "REQ_ID without executed negative PASS evidence: $req_trimmed"
      req_fail=1
    fi

    pos_total=$((pos_total + req_pos))
    neg_total=$((neg_total + req_neg))
  done

  EXECUTED_POSITIVE_TEST_COUNT="$pos_total"
  EXECUTED_NEGATIVE_TEST_COUNT="$neg_total"
  TOTAL_EXECUTED_TEST_COUNT=$((pos_total + neg_total))

  if [[ "$TOTAL_EXECUTED_TEST_COUNT" -eq 0 ]]; then
    log_fail "Total executed test count is zero"
    req_fail=1
  fi
  if [[ "$EXECUTED_POSITIVE_TEST_COUNT" -eq 0 ]]; then
    log_fail "Executed positive test count is zero"
    req_fail=1
  fi
  if [[ "$EXECUTED_NEGATIVE_TEST_COUNT" -eq 0 ]]; then
    log_fail "Executed negative test count is zero"
    req_fail=1
  fi

  if [[ "$req_fail" -eq 0 ]]; then
    PER_REQ_COVERAGE_STATUS="PASS"
    log_ok "Per-REQ positive/negative coverage"
  else
    PER_REQ_COVERAGE_STATUS="FAIL"
    EXIT_CODE=1
  fi
}

run_python_split_tests() {
  local has_python_tests=""
  has_python_tests="$(find "$BASE_DIR" -type f \( -name 'test_*.py' -o -name '*_test.py' \) ! -path '*/.venv/*' -print -quit)"
  if [[ -z "$has_python_tests" ]]; then
    PYTHON_TESTS_IN_SCOPE="false"
    UNIT_TEST_STATUS="SKIPPED"
    INTEGRATION_TEST_STATUS="SKIPPED"
    log_ok "No Python tests in scope; split pytest run skipped"
    return
  fi

  PYTHON_TESTS_IN_SCOPE="true"
  if ! command -v pytest >/dev/null 2>&1; then
    UNIT_TEST_STATUS="FAIL"
    INTEGRATION_TEST_STATUS="FAIL"
    UNIT_TEST_EXIT_CODE="127"
    INTEGRATION_TEST_EXIT_CODE="127"
    log_fail "pytest is required for Python test scope"
    return
  fi

  if pytest -m "not integration" > "$REPORTS_DIR/pytest_unit_${TIMESTAMP}.log" 2>&1; then
    UNIT_TEST_STATUS="PASS"
    UNIT_TEST_EXIT_CODE="0"
    log_ok "pytest -m \"not integration\""
  else
    UNIT_TEST_EXIT_CODE="$?"
    UNIT_TEST_STATUS="FAIL"
    log_fail "pytest -m \"not integration\""
  fi

  if pytest -m integration > "$REPORTS_DIR/pytest_integration_${TIMESTAMP}.log" 2>&1; then
    INTEGRATION_TEST_STATUS="PASS"
    INTEGRATION_TEST_EXIT_CODE="0"
    log_ok "pytest -m integration"
  else
    INTEGRATION_TEST_EXIT_CODE="$?"
    INTEGRATION_TEST_STATUS="FAIL"
    log_fail "pytest -m integration"
  fi
}

echo "Running DEV gate..."

ROLE_PACKET_PATH="${1:-}"
if [[ -z "$ROLE_PACKET_PATH" ]]; then
  ROLE_PACKET_PATH="$(find "$GATE_DIR" -maxdepth 1 -type f -name 'po_role_packet*.env' -print | sort | tail -n1 || true)"
fi

if [[ -z "$ROLE_PACKET_PATH" || ! -f "$ROLE_PACKET_PATH" ]]; then
  log_fail "Missing PO role packet (.env). Expected in $GATE_DIR"
fi

REQ_IDS=""
PO_PACKET_ID=""
EXECUTION_MODE=""
if [[ -n "$ROLE_PACKET_PATH" && -f "$ROLE_PACKET_PATH" ]]; then
  EXECUTION_MODE="$(read_env_value execution_mode "$ROLE_PACKET_PATH")"
  REQ_IDS="$(read_env_value req_ids "$ROLE_PACKET_PATH")"
  PO_PACKET_ID="$(read_env_value po_packet_id "$ROLE_PACKET_PATH")"

  if [[ "$EXECUTION_MODE" != "DEV" ]]; then
    log_fail "execution_mode must be DEV in role packet"
  else
    log_ok "Role packet execution_mode=DEV"
  fi

  if [[ -z "$(trim "$REQ_IDS")" ]]; then
    log_fail "role packet req_ids must not be empty"
  else
    log_ok "Role packet req_ids set"
  fi
fi

run_check "$BASE_DIR/scripts/prompt_firewall_check.sh" "prompt_firewall_check" PROMPT_FIREWALL_STATUS
run_check "$BASE_DIR/scripts/audit_readiness_check.sh" "audit_readiness_check" AUDIT_READINESS_STATUS
run_check "$BASE_DIR/scripts/pipeline_order_check.sh" "pipeline_order_check" PIPELINE_ORDER_STATUS

if [[ -n "$(trim "$REQ_IDS")" ]]; then
  run_req_coverage_check "$REQ_IDS"
fi

run_python_split_tests

FINAL_STATUS="PASS"
if [[ "$EXIT_CODE" -ne 0 ]]; then
  FINAL_STATUS="FAIL"
fi

cat > "$GATE_FILE" <<EOG
final_status=$FINAL_STATUS
gate_type=DEV
gate_utc=$GATE_UTC
target_commit_sha=$TARGET_SHA
po_packet_id=${PO_PACKET_ID:-unknown}
role_packet_path=${ROLE_PACKET_PATH:-missing}
execution_mode=${EXECUTION_MODE:-missing}
req_ids=${REQ_IDS:-}
prompt_firewall_status=$PROMPT_FIREWALL_STATUS
audit_readiness_status=$AUDIT_READINESS_STATUS
pipeline_order_status=$PIPELINE_ORDER_STATUS
per_req_coverage_status=$PER_REQ_COVERAGE_STATUS
total_executed_test_count=$TOTAL_EXECUTED_TEST_COUNT
executed_positive_test_count=$EXECUTED_POSITIVE_TEST_COUNT
executed_negative_test_count=$EXECUTED_NEGATIVE_TEST_COUNT
python_tests_in_scope=$PYTHON_TESTS_IN_SCOPE
unit_test_status=$UNIT_TEST_STATUS
unit_test_exit_code=$UNIT_TEST_EXIT_CODE
integration_test_status=$INTEGRATION_TEST_STATUS
integration_test_exit_code=$INTEGRATION_TEST_EXIT_CODE
EOG

echo "DEV gate artifact: $GATE_FILE"

if [[ "$FINAL_STATUS" == "PASS" ]]; then
  echo "PASS dev-gate"
else
  echo "FAIL dev-gate"
fi

exit "$EXIT_CODE"
