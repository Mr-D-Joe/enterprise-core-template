#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROMPTS_FILE="$BASE_DIR/PROMPTS.md"
EXIT_CODE=0

check_file() {
  local file="$1"
  if [[ -f "$file" ]]; then
    echo "OK   file exists: $file"
  else
    echo "FAIL missing file: $file"
    EXIT_CODE=1
  fi
}

check_contains() {
  local file="$1"
  local pattern="$2"
  local reason="$3"
  if grep -Fq -- "$pattern" "$file"; then
    echo "OK   $reason"
  else
    echo "FAIL $reason ($file)"
    EXIT_CODE=1
  fi
}

echo "Running prompt firewall check..."

check_file "$PROMPTS_FILE"

check_contains "$PROMPTS_FILE" "Single prompt model" "Single prompt model section present"
check_contains "$PROMPTS_FILE" "PO runtime prompt (customer-facing)" "PO runtime prompt section present"
check_contains "$PROMPTS_FILE" "DEV execution mode contract" "DEV execution mode section present"
check_contains "$PROMPTS_FILE" "run runtime bootstrap protocol before implementation" "DEV runtime bootstrap protocol present"
check_contains "$PROMPTS_FILE" "AUDIT execution mode contract" "AUDIT execution mode section present"
check_contains "$PROMPTS_FILE" "Allowed input set:" "AUDIT allowed input section present"
check_contains "$PROMPTS_FILE" "Forbidden input set:" "AUDIT forbidden input section present"
check_contains "$PROMPTS_FILE" "EXECUTION_MODE=DEV" "DEV execution mode token present"
check_contains "$PROMPTS_FILE" "EXECUTION_MODE=AUDIT" "AUDIT execution mode token present"
check_contains "$PROMPTS_FILE" "Role packet artifact (machine-readable, mandatory)" "Role packet artifact section present"
check_contains "$PROMPTS_FILE" "execution_mode" "Role packet key execution_mode present"
check_contains "$PROMPTS_FILE" "po_packet_id" "Role packet key po_packet_id present"
check_contains "$PROMPTS_FILE" "req_ids" "Role packet key req_ids present"
check_contains "$PROMPTS_FILE" "scope_allowlist" "Role packet key scope_allowlist present"
check_contains "$PROMPTS_FILE" "allowed_inputs_hash" "Role packet key allowed_inputs_hash present"
check_contains "$PROMPTS_FILE" "target_commit_sha" "Role packet key target_commit_sha present"
check_contains "$PROMPTS_FILE" "po_agent_id" "Role packet key po_agent_id present"
check_contains "$PROMPTS_FILE" "created_at_utc" "Role packet key created_at_utc present"
check_contains "$PROMPTS_FILE" '`APPROVE` or `REJECT`' "AUDIT decision contract present"
check_contains "$PROMPTS_FILE" "output secrets, keys, tokens, or personal data" "DEV leakage prohibition present"
check_contains "$PROMPTS_FILE" "ISO-conform security/data controls" "AUDIT ISO security/data scope present"
check_contains "$PROMPTS_FILE" "ask customer to run manual environment/setup commands" "No customer manual setup rule present"
check_contains "$PROMPTS_FILE" 'Missing runtime bootstrap evidence for active scope => `FINAL_STATUS=FAIL`' "Runtime bootstrap fail semantics present"
check_contains "$PROMPTS_FILE" 'select `application_profile` from `DESIGN.md` section 1.1 before selecting tools' "Application profile selection rule present"
check_contains "$PROMPTS_FILE" "keep production choices on stable/LTS channels unless PO-approved exception exists" "Stable/LTS tooling rule present"
check_contains "$PROMPTS_FILE" 'Missing `application_profile` in tooling decision evidence => `FINAL_STATUS=FAIL`.' "Application profile fail semantics present"
check_contains "$PROMPTS_FILE" 'enforce Python venv path at project root `.venv` only' "Root-only Python venv rule present"
check_contains "$PROMPTS_FILE" "target latest stable runtime/compiler versions unless PO-approved exception exists" "Latest-stable runtime/compiler rule present"
check_contains "$PROMPTS_FILE" 'Missing runtime/compiler version evidence for active scope => `FINAL_STATUS=FAIL`.' "Runtime/compiler fail semantics present"

if grep -Eiq "chain-of-thought|chat history|private rationale" "$PROMPTS_FILE"; then
  echo "OK   Prompt contract forbids DEV-private context for AUDIT mode"
else
  echo "FAIL prompt contract missing DEV-private context firewall terms"
  EXIT_CODE=1
fi

if [[ -f "$BASE_DIR/prompts/DEV_PROMPT.md" || -f "$BASE_DIR/prompts/AUDIT_PROMPT.md" ]]; then
  echo "FAIL legacy split prompt files detected under prompts/"
  EXIT_CODE=1
else
  echo "OK   no legacy split prompt files detected"
fi

if grep -Fq "REQUEST_CHANGES" "$PROMPTS_FILE"; then
  echo "FAIL prompt contract contains non-binary decision term REQUEST_CHANGES"
  EXIT_CODE=1
else
  echo "OK   prompt contract uses binary decision vocabulary"
fi

if [[ "$EXIT_CODE" -eq 0 ]]; then
  echo "PASS prompt-firewall-check"
else
  echo "FAIL prompt-firewall-check"
fi

exit "$EXIT_CODE"
