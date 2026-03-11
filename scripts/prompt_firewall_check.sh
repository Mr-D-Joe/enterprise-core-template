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

check_contains "$PROMPTS_FILE" "Default operating role (mandatory)" "Default operating role section present"
check_contains "$PROMPTS_FILE" 'The default role under this single-prompt contract is `PO`.' "Default PO role rule present"
check_contains "$PROMPTS_FILE" "Single prompt model" "Single prompt model section present"
check_contains "$PROMPTS_FILE" "Scope note:" "Prompt scope note present"
check_contains "$PROMPTS_FILE" '`DESIGN.md` defines fundamental governance/architecture rules.' "Prompt references DESIGN as fundamentals source"
check_contains "$PROMPTS_FILE" '`PROMPTS.md` defines runtime execution controls for PO/DEV/AUDIT only.' "Prompt runtime-only scope rule present"
check_contains "$PROMPTS_FILE" "PO runtime prompt (customer-facing)" "PO runtime prompt section present"
check_contains "$PROMPTS_FILE" "PO autonomy default (mandatory)" "PO autonomy default section present"
check_contains "$PROMPTS_FILE" "DEV execution mode contract" "DEV execution mode section present"
check_contains "$PROMPTS_FILE" "DEV completion expectation (mandatory)" "DEV completion expectation section present"
check_contains "$PROMPTS_FILE" "run runtime bootstrap protocol before implementation" "DEV runtime bootstrap protocol present"
check_contains "$PROMPTS_FILE" "AUDIT execution mode contract" "AUDIT execution mode section present"
check_contains "$PROMPTS_FILE" "AUDIT orchestration by PO" "AUDIT orchestration section present"
check_contains "$PROMPTS_FILE" "Mandatory package closure" "Mandatory package closure section present"
check_contains "$PROMPTS_FILE" "Allowed input set:" "AUDIT allowed input section present"
check_contains "$PROMPTS_FILE" "Forbidden input set:" "AUDIT forbidden input section present"
check_contains "$PROMPTS_FILE" "deterministic positive and negative test vectors and evidence paths." "PO test-vector pair requirement present"
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
check_contains "$PROMPTS_FILE" "Only one active change package is allowed at any time." "Single active package model present"
check_contains "$PROMPTS_FILE" "ensure no open package conflict exists before starting a new package;" "PO open-package lock check present"
check_contains "$PROMPTS_FILE" '`docs/BACKLOG.md`, active PO package plan, `LASTENHEFT.md` machine metrics' "PO backlog/package/LASTENHEFT freshness rule present"
check_contains "$PROMPTS_FILE" "Requirement -> DEV -> AUDIT -> PR -> Merge -> Version -> Clean Desk." "PO clean-desk delivery sequence present"
check_contains "$PROMPTS_FILE" "start a second package while the current package is not closed through AUDIT -> PR -> Merge -> Version -> Clean Desk." "DEV overlap prohibition present"
check_contains "$PROMPTS_FILE" 'provide at least one executed positive and one executed negative test per active `REQ_ID`;' "DEV per-REQ positive/negative test execution rule present"
check_contains "$PROMPTS_FILE" 'execute separated test partitions for Python scope: unit (`pytest -m "not integration"`) and integration (`pytest -m integration`);' "DEV split test execution rule present"
check_contains "$PROMPTS_FILE" "PO must trigger AUDIT immediately after successful committed-state DEV completion for the active package." "PO immediate AUDIT trigger rule present"
check_contains "$PROMPTS_FILE" "If DEV finds a package-internal blocker that can be fixed within approved scope, DEV must fix it and rerun required checks" "DEV rerun-after-fix rule present"
check_contains "$PROMPTS_FILE" 'verify for each active `REQ_ID`: at least one executed positive and one executed negative test with evidence references;' "AUDIT per-REQ positive/negative verification rule present"
check_contains "$PROMPTS_FILE" "verify total executed tests for active package is greater than zero;" "AUDIT non-zero test count verification rule present"
check_contains "$PROMPTS_FILE" "verify executed positive test count for active package is greater than zero;" "AUDIT positive test count verification rule present"
check_contains "$PROMPTS_FILE" "verify executed negative test count for active package is greater than zero;" "AUDIT negative test count verification rule present"
check_contains "$PROMPTS_FILE" "A package is only complete when all six closure steps are finished." "Mandatory package closure completion rule present"
check_contains "$PROMPTS_FILE" 'Missing per-REQ positive/negative execution evidence => `FINAL_STATUS=FAIL`.' "Per-REQ test coverage fail semantics present"
check_contains "$PROMPTS_FILE" 'Total executed tests for active package equals zero => `FINAL_STATUS=FAIL`.' "Zero-test fail semantics present"
check_contains "$PROMPTS_FILE" 'Executed positive test count for active package equals zero => `FINAL_STATUS=FAIL`.' "Zero-positive fail semantics present"
check_contains "$PROMPTS_FILE" 'Executed negative test count for active package equals zero => `FINAL_STATUS=FAIL`.' "Zero-negative fail semantics present"
check_contains "$PROMPTS_FILE" 'More than one active package => `FINAL_STATUS=FAIL`.' "Multiple active packages fail semantics present"
check_contains "$PROMPTS_FILE" 'Stale backlog/package metadata => `FINAL_STATUS=FAIL`.' "Stale backlog/package fail semantics present"
check_contains "$PROMPTS_FILE" 'Missing machine-generated metadata in planning docs (`generated_at_utc`, `source_commit_sha`) => `FINAL_STATUS=FAIL`.' "Planning metadata fail semantics present"
check_contains "$PROMPTS_FILE" 'Missing performance budget evidence (`p95`) => `FINAL_STATUS=FAIL`.' "Performance budget fail semantics present"
check_contains "$PROMPTS_FILE" 'Additional active prompt/governance contract files outside canonical set => `FINAL_STATUS=FAIL`.' "Redundant contract fail semantics present"
check_contains "$PROMPTS_FILE" 'Missing split unit/integration test execution evidence where Python tests are in scope => `FINAL_STATUS=FAIL`.' "Split test fail semantics present"
check_contains "$PROMPTS_FILE" 'Stopping before `PR -> Merge -> Version -> Clean Desk` although all prior mandatory gates passed => `FINAL_STATUS=FAIL`.' "Premature stop fail semantics present"
check_contains "$PROMPTS_FILE" 'Performing DEV or AUDIT only on uncommitted working-tree state for release path => `FINAL_STATUS=FAIL`.' "Uncommitted-state fail semantics present"
check_contains "$PROMPTS_FILE" 'Failing to rerun gates after fixing a package-internal blocker => `FINAL_STATUS=FAIL`.' "Rerun-after-fix fail semantics present"
check_contains "$PROMPTS_FILE" 'Leaving temporary gate artifacts, duplicate workflow files, or stale local package residues after merge/version => `FINAL_STATUS=FAIL`.' "Clean-desk residue fail semantics present"

if grep -Eiq "chain-of-thought|chat history|private rationale" "$PROMPTS_FILE"; then
  echo "OK   Prompt contract forbids DEV-private context for AUDIT mode"
else
  echo "FAIL prompt contract missing DEV-private context firewall terms"
  EXIT_CODE=1
fi

redundant_prompt_files=(
  "$BASE_DIR/prompts/DEV_PROMPT.md"
  "$BASE_DIR/prompts/AUDIT_PROMPT.md"
  "$BASE_DIR/QA-Test-Prompt.md"
  "$BASE_DIR/docs/PROMPTS.md"
  "$BASE_DIR/docs/prompts/DEV_PROMPT_ANNEX.md"
  "$BASE_DIR/docs/prompts/AUDIT_PROMPT_ANNEX.md"
)
redundant_found=0
for f in "${redundant_prompt_files[@]}"; do
  if [[ -f "$f" ]]; then
    echo "FAIL redundant active prompt contract detected: $f"
    EXIT_CODE=1
    redundant_found=1
  fi
done
if [[ "$redundant_found" -eq 0 ]]; then
  echo "OK   no redundant active prompt contract files detected"
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
