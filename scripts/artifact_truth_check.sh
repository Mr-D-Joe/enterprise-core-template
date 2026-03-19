#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GATE_DIR="$BASE_DIR/system_reports/gates"
EXIT_CODE=0

log_ok() {
  echo "OK   $1"
}

log_fail() {
  echo "FAIL $1"
  EXIT_CODE=1
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

validate_pointer() {
  local pointer_file="$1"
  local glob_pattern="$2"
  local expected_gate_type="$3"
  local label="$4"
  local artifact_count=0
  local authoritative_path=""
  local pointer_gate_type=""
  local artifact_gate_type=""

  if [[ -d "$GATE_DIR" ]]; then
    artifact_count="$(find "$GATE_DIR" -maxdepth 1 -type f -name "$glob_pattern" | wc -l | tr -d ' ')"
  fi

  if [[ "$artifact_count" -eq 0 ]]; then
    log_ok "$label has no historical artifacts; pointer not required"
    return
  fi

  if [[ ! -f "$pointer_file" ]]; then
    log_fail "$label missing authoritative pointer: $pointer_file"
    return
  fi

  authoritative_path="$(read_env_value authoritative_artifact_path "$pointer_file")"
  pointer_gate_type="$(read_env_value gate_type "$pointer_file")"

  if [[ -z "$authoritative_path" ]]; then
    log_fail "$label pointer missing authoritative_artifact_path"
    return
  fi

  if [[ ! -f "$authoritative_path" ]]; then
    log_fail "$label pointer references missing artifact: $authoritative_path"
    return
  fi

  if [[ "$pointer_gate_type" != "$expected_gate_type" ]]; then
    log_fail "$label pointer gate_type mismatch: expected $expected_gate_type got ${pointer_gate_type:-missing}"
    return
  fi

  artifact_gate_type="$(read_env_value gate_type "$authoritative_path")"
  if [[ "$artifact_gate_type" != "$expected_gate_type" ]]; then
    log_fail "$label authoritative artifact gate_type mismatch: expected $expected_gate_type got ${artifact_gate_type:-missing}"
    return
  fi

  log_ok "$label authoritative pointer present and valid"
}

echo "Running artifact truth check..."

validate_pointer "$GATE_DIR/current_dev_gate.env" 'dev_gate_*.gate' "DEV" "DEV gate truth"
validate_pointer "$GATE_DIR/current_audit_gate.env" 'audit_gate_*.gate' "AUDIT" "AUDIT gate truth"

if [[ "$EXIT_CODE" -eq 0 ]]; then
  echo "PASS artifact-truth-check"
else
  echo "FAIL artifact-truth-check"
fi

exit "$EXIT_CODE"
