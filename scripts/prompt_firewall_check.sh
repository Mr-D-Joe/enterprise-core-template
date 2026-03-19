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

check_contains "$PROMPTS_FILE" "Scope note:" "Prompt scope note present"
check_contains "$PROMPTS_FILE" '`DESIGN.md` defines document hierarchy and governance index rules.' "Prompt references DESIGN governance index scope"
check_contains "$PROMPTS_FILE" '`ARCHITECTURE.md` defines architecture and module-boundary rules.' "Prompt references ARCHITECTURE scope"
check_contains "$PROMPTS_FILE" '`STACK.md` defines stack/runtime/tooling policy.' "Prompt references STACK scope"
check_contains "$PROMPTS_FILE" '`PROMPTS.md` defines runtime execution controls for PO/DEV/AUDIT only.' "Prompt runtime-only scope rule present"
check_contains "$PROMPTS_FILE" "Default operating role (mandatory)" "Default operating role section present"
check_contains "$PROMPTS_FILE" 'The default role under this single-prompt contract is `PO`.' "Default PO role rule present"
check_contains "$PROMPTS_FILE" "Single prompt model" "Single prompt model section present"
check_contains "$PROMPTS_FILE" "Only one active change package is allowed at any time." "Single active package rule present"
check_contains "$PROMPTS_FILE" "### 1.2 Active change brief artifact (machine-readable, mandatory)" "Active CHG artifact section present"
check_contains "$PROMPTS_FILE" 'Exactly one CHG document with `status=ACTIVE` may exist for the active package.' "Single active CHG rule present"
check_contains "$PROMPTS_FILE" '`package_id`' "CHG package_id key present"
check_contains "$PROMPTS_FILE" "PO runtime prompt (customer-facing)" "PO runtime section present"
check_contains "$PROMPTS_FILE" "## 2.2 Derived execution context (mandatory)" "Derived execution context section present"
check_contains "$PROMPTS_FILE" "## 2.3 Reporting truth model (mandatory)" "Reporting truth section present"
check_contains "$PROMPTS_FILE" "DEV execution mode contract" "DEV mode section present"
check_contains "$PROMPTS_FILE" "AUDIT execution mode contract" "AUDIT mode section present"
check_contains "$PROMPTS_FILE" "Required gate semantics (no escape path)" "No-escape gate semantics section present"
check_contains "$PROMPTS_FILE" "Mandatory package closure" "Mandatory package closure section present"
check_contains "$PROMPTS_FILE" "EXECUTION_MODE=DEV" "DEV execution token present"
check_contains "$PROMPTS_FILE" "EXECUTION_MODE=AUDIT" "AUDIT execution token present"
check_contains "$PROMPTS_FILE" "run runtime bootstrap protocol before implementation" "Runtime bootstrap protocol present"
check_contains "$PROMPTS_FILE" 'create `.vscode/settings.json` when Python runtime is required,' "VS Code Python settings bootstrap rule present"
check_contains "$PROMPTS_FILE" 'create `pyrightconfig.json` when Python runtime is required,' "Pyright config bootstrap rule present"
check_contains "$PROMPTS_FILE" 'install `pyright` into root `.venv` when Python runtime is required,' "Pyright install bootstrap rule present"
check_contains "$PROMPTS_FILE" 'select `application_profile` from `STACK.md` before selecting tools,' "Application-profile selection rule present"
check_contains "$PROMPTS_FILE" 'execute separated test partitions for Python scope: unit (`pytest -m "not integration"`) and integration (`pytest -m integration`);' "Split Python test rule present"
check_contains "$PROMPTS_FILE" 'provide at least one executed positive and one executed negative test per active `REQ_ID`;' "Per-REQ positive/negative rule present"
check_contains "$PROMPTS_FILE" "must never output secrets, keys, tokens, or personal data" "Secret and personal-data leakage rule present"
check_contains "$PROMPTS_FILE" '`AGENTS.md`, `DESIGN.md`, `ARCHITECTURE.md`, `STACK.md`, `CONTRIBUTING.md`, `PROMPTS.md`, `LASTENHEFT.md`;' "AUDIT allowed canonical docs set present"
check_contains "$PROMPTS_FILE" "active change brief and relevant module-local docs;" "AUDIT allowed change/module docs set present"
check_contains "$PROMPTS_FILE" "Any source document used in DEV or AUDIT but not declared in the active CHG document is forbidden input." "Undeclared source usage rule present"
check_contains "$PROMPTS_FILE" "If additional edits were made after an earlier assessment in the same turn, the final summary must disclose that chronology explicitly." "Same-turn chronology disclosure rule present"
check_contains "$PROMPTS_FILE" '`No additional changes were required` is forbidden after same-turn repository edits beyond the referenced assessment point.' "No-additional-changes restriction present"
check_contains "$PROMPTS_FILE" '`ACCURATE`' "Accuracy classification vocabulary present"
check_contains "$PROMPTS_FILE" 'Missing runtime bootstrap evidence for active scope => `FINAL_STATUS=FAIL`.' "Runtime bootstrap fail semantics present"
check_contains "$PROMPTS_FILE" 'Missing `.vscode/settings.json` for Python scope => `FINAL_STATUS=FAIL`.' "VS Code settings fail semantics present"
check_contains "$PROMPTS_FILE" 'Missing `pyrightconfig.json` for Python scope => `FINAL_STATUS=FAIL`.' "Pyright config fail semantics present"
check_contains "$PROMPTS_FILE" 'Missing installed root `.venv` `pyright` for Python scope => `FINAL_STATUS=FAIL`.' "Pyright install fail semantics present"
check_contains "$PROMPTS_FILE" 'Missing runtime/compiler version evidence for active scope => `FINAL_STATUS=FAIL`.' "Runtime/compiler fail semantics present"
check_contains "$PROMPTS_FILE" 'More than one active package => `FINAL_STATUS=FAIL`.' "Multiple package fail semantics present"
check_contains "$PROMPTS_FILE" 'Missing active CHG document => `FINAL_STATUS=FAIL`.' "Missing active CHG fail semantics present"
check_contains "$PROMPTS_FILE" 'Active CHG `package_id` mismatch with backlog `active_package_id` => `FINAL_STATUS=FAIL`.' "Backlog/CHG mismatch fail semantics present"
check_contains "$PROMPTS_FILE" 'Missing artifact binding to active `chg_id` => `FINAL_STATUS=FAIL`.' "Active chg_id binding fail semantics present"
check_contains "$PROMPTS_FILE" 'Misleading final summary that hides same-turn repair edits => `FINAL_STATUS=FAIL`.' "Misleading-summary fail semantics present"
check_contains "$PROMPTS_FILE" 'Using `No additional changes were required` after same-turn repository edits => `FINAL_STATUS=FAIL`.' "No-additional-changes fail semantics present"
check_contains "$PROMPTS_FILE" 'Missing final-state residue check or final-state rerun evidence for contradiction repair / migration / governance hardening => `FINAL_STATUS=FAIL`.' "Final-state proof fail semantics present"
check_contains "$PROMPTS_FILE" 'Missing split unit/integration test execution evidence where Python tests are in scope => `FINAL_STATUS=FAIL`.' "Split-test fail semantics present"
check_contains "$PROMPTS_FILE" 'insecure runtime defaults => `FINAL_STATUS=FAIL`.' "Insecure runtime defaults fail semantics present"
check_contains "$PROMPTS_FILE" 'raw exception exposure => `FINAL_STATUS=FAIL`.' "Raw exception fail semantics present"
check_contains "$PROMPTS_FILE" 'silent masking => `FINAL_STATUS=FAIL`.' "Silent masking fail semantics present"
check_contains "$PROMPTS_FILE" 'version source mismatch => `FINAL_STATUS=FAIL`.' "Version-source fail semantics present"
check_contains "$PROMPTS_FILE" 'Stopping before `PR -> Merge -> Version -> Clean Desk` although all prior mandatory gates passed => `FINAL_STATUS=FAIL`.' "Premature stop fail semantics present"

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

for f in "${redundant_prompt_files[@]}"; do
  if [[ -f "$f" ]]; then
    echo "FAIL redundant active prompt contract detected: $f"
    EXIT_CODE=1
  fi
done

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
