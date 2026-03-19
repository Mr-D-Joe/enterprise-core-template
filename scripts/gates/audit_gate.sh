#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
GATE_DIR="$BASE_DIR/system_reports/gates"
TRACE_FILE="$BASE_DIR/docs/governance/TRACEABILITY_MATRIX_TEMPLATE.md"

mkdir -p "$GATE_DIR"

TIMESTAMP="$(date -u +%Y%m%dT%H%M%SZ)"
GATE_UTC="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
TARGET_SHA="$(git -C "$BASE_DIR" rev-parse HEAD 2>/dev/null || echo unknown)"
SHORT_SHA="$(git -C "$BASE_DIR" rev-parse --short=8 HEAD 2>/dev/null || echo nosha)"
GATE_FILE="$GATE_DIR/audit_gate_${TIMESTAMP}_${SHORT_SHA}.gate"

EXIT_CODE=0
PROMPT_FIREWALL_STATUS="FAIL"
AUDIT_READINESS_STATUS="FAIL"
PIPELINE_ORDER_STATUS="FAIL"
DEV_GATE_STATUS="FAIL"
PER_REQ_COVERAGE_STATUS="FAIL"
EXECUTED_POSITIVE_TEST_COUNT=0
EXECUTED_NEGATIVE_TEST_COUNT=0
TOTAL_EXECUTED_TEST_COUNT=0
UNIT_TEST_EXIT_CODE="unknown"
INTEGRATION_TEST_EXIT_CODE="unknown"
ISO_SECURITY_DATA_CONTROLS_STATUS="FAIL"

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

find_active_chg_file() {
  local file=""
  local matches=()
  while IFS= read -r file; do
    if grep -Eq '^status:[[:space:]]*ACTIVE$' "$file"; then
      matches+=("$file")
    fi
  done < <(find "$BASE_DIR/changes" -maxdepth 1 -type f -name 'CHG-*.md' | sort)

  if [[ "${#matches[@]}" -eq 1 ]]; then
    printf '%s' "${matches[0]}"
  fi
}

read_chg_value() {
  local key="$1"
  local file="$2"
  local raw
  raw="$(grep -E "^${key}:" "$file" | head -n1 || true)"
  if [[ -n "$raw" ]]; then
    raw="${raw#*:}"
    raw="${raw#"${raw%%[![:space:]]*}"}"
    raw="${raw%"${raw##*[![:space:]]}"}"
    printf '%s' "$raw"
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

check_latest_dev_gate() {
  local current_dev_pointer="$GATE_DIR/current_dev_gate.env"
  local latest_dev_gate=""
  if [[ ! -f "$current_dev_pointer" ]]; then
    DEV_GATE_STATUS="FAIL"
    log_fail "Missing authoritative DEV gate pointer (current_dev_gate.env)"
    return
  fi

  latest_dev_gate="$(read_env_value authoritative_artifact_path "$current_dev_pointer")"
  if [[ -z "$latest_dev_gate" || ! -f "$latest_dev_gate" ]]; then
    DEV_GATE_STATUS="FAIL"
    log_fail "Missing authoritative DEV gate artifact"
    return
  fi

  local dev_final
  dev_final="$(read_env_value final_status "$latest_dev_gate")"
  UNIT_TEST_EXIT_CODE="$(read_env_value unit_test_exit_code "$latest_dev_gate")"
  INTEGRATION_TEST_EXIT_CODE="$(read_env_value integration_test_exit_code "$latest_dev_gate")"

  if [[ "$dev_final" != "PASS" ]]; then
    DEV_GATE_STATUS="FAIL"
    log_fail "Latest DEV gate status is not PASS"
    return
  fi

  if [[ "$UNIT_TEST_EXIT_CODE" != "0" ]]; then
    DEV_GATE_STATUS="FAIL"
    log_fail "DEV gate unit test exit code is not 0"
    return
  fi

  if [[ "$INTEGRATION_TEST_EXIT_CODE" != "0" ]]; then
    DEV_GATE_STATUS="FAIL"
    log_fail "DEV gate integration test exit code is not 0"
    return
  fi

  DEV_GATE_STATUS="PASS"
  log_ok "Latest DEV gate artifact is PASS"
}

check_iso_template_controls() {
  local template_file="$BASE_DIR/docs/governance/AUDIT_REPORT_TEMPLATE.md"
  if [[ ! -f "$template_file" ]]; then
    ISO_SECURITY_DATA_CONTROLS_STATUS="FAIL"
    log_fail "Missing audit report template: $template_file"
    return
  fi

  if grep -Fq "ISO security/data control verdicts (mandatory)" "$template_file" \
    && grep -Fq "Secret/key/token management (no hardcoded secrets): PASS/FAIL" "$template_file" \
    && grep -Fq "Dependency risk/vulnerability review: PASS/FAIL" "$template_file"; then
    ISO_SECURITY_DATA_CONTROLS_STATUS="PASS"
    log_ok "ISO security/data control verdict template coverage"
  else
    ISO_SECURITY_DATA_CONTROLS_STATUS="FAIL"
    log_fail "ISO security/data control verdict template is incomplete"
  fi
}

echo "Running AUDIT gate..."

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
ACTIVE_CHG_PATH=""
ACTIVE_CHG_ID="missing"
ACTIVE_PACKAGE_ID="missing"
if [[ -n "$ROLE_PACKET_PATH" && -f "$ROLE_PACKET_PATH" ]]; then
  EXECUTION_MODE="$(read_env_value execution_mode "$ROLE_PACKET_PATH")"
  REQ_IDS="$(read_env_value req_ids "$ROLE_PACKET_PATH")"
  PO_PACKET_ID="$(read_env_value po_packet_id "$ROLE_PACKET_PATH")"

  if [[ "$EXECUTION_MODE" != "AUDIT" ]]; then
    log_fail "execution_mode must be AUDIT in role packet"
  else
    log_ok "Role packet execution_mode=AUDIT"
  fi

  if [[ -z "$(trim "$REQ_IDS")" ]]; then
    log_fail "role packet req_ids must not be empty"
  else
    log_ok "Role packet req_ids set"
  fi
fi

ACTIVE_CHG_PATH="$(find_active_chg_file || true)"
if [[ -n "$ACTIVE_CHG_PATH" && -f "$ACTIVE_CHG_PATH" ]]; then
  ACTIVE_CHG_ID="$(read_chg_value "chg_id" "$ACTIVE_CHG_PATH" || true)"
  ACTIVE_PACKAGE_ID="$(read_chg_value "package_id" "$ACTIVE_CHG_PATH" || true)"
  ACTIVE_CHG_ID="${ACTIVE_CHG_ID:-missing}"
  ACTIVE_PACKAGE_ID="${ACTIVE_PACKAGE_ID:-missing}"
fi

check_latest_dev_gate
run_check "$BASE_DIR/scripts/prompt_firewall_check.sh" "prompt_firewall_check" PROMPT_FIREWALL_STATUS
run_check "$BASE_DIR/scripts/audit_readiness_check.sh" "audit_readiness_check" AUDIT_READINESS_STATUS
run_check "$BASE_DIR/scripts/pipeline_order_check.sh" "pipeline_order_check" PIPELINE_ORDER_STATUS
check_iso_template_controls

if [[ -n "$(trim "$REQ_IDS")" ]]; then
  run_req_coverage_check "$REQ_IDS"
fi

FINAL_STATUS="PASS"
DECISION="APPROVE"
if [[ "$EXIT_CODE" -ne 0 ]]; then
  FINAL_STATUS="FAIL"
  DECISION="REJECT"
fi

cat > "$GATE_FILE" <<EOG
final_status=$FINAL_STATUS
decision=$DECISION
gate_type=AUDIT
gate_utc=$GATE_UTC
target_commit_sha=$TARGET_SHA
chg_id=${ACTIVE_CHG_ID:-missing}
package_id=${ACTIVE_PACKAGE_ID:-missing}
active_chg_path=${ACTIVE_CHG_PATH:-missing}
po_packet_id=${PO_PACKET_ID:-unknown}
role_packet_path=${ROLE_PACKET_PATH:-missing}
execution_mode=${EXECUTION_MODE:-missing}
req_ids=${REQ_IDS:-}
dev_gate_status=$DEV_GATE_STATUS
prompt_firewall_status=$PROMPT_FIREWALL_STATUS
audit_readiness_status=$AUDIT_READINESS_STATUS
pipeline_order_status=$PIPELINE_ORDER_STATUS
iso_security_data_controls_status=$ISO_SECURITY_DATA_CONTROLS_STATUS
per_req_coverage_status=$PER_REQ_COVERAGE_STATUS
total_executed_test_count=$TOTAL_EXECUTED_TEST_COUNT
executed_positive_test_count=$EXECUTED_POSITIVE_TEST_COUNT
executed_negative_test_count=$EXECUTED_NEGATIVE_TEST_COUNT
unit_test_exit_code=$UNIT_TEST_EXIT_CODE
integration_test_exit_code=$INTEGRATION_TEST_EXIT_CODE
EOG

cat > "$GATE_DIR/current_audit_gate.env" <<EOG
artifact_truth_model=current-plus-history
current_authoritative=true
gate_type=AUDIT
authoritative_artifact_path=$GATE_FILE
final_status=$FINAL_STATUS
decision=$DECISION
target_commit_sha=$TARGET_SHA
chg_id=${ACTIVE_CHG_ID:-missing}
package_id=${ACTIVE_PACKAGE_ID:-missing}
active_chg_path=${ACTIVE_CHG_PATH:-missing}
updated_at_utc=$GATE_UTC
EOG

echo "AUDIT gate artifact: $GATE_FILE"

if [[ "$FINAL_STATUS" == "PASS" ]]; then
  echo "PASS audit-gate"
else
  echo "FAIL audit-gate"
fi

exit "$EXIT_CODE"
