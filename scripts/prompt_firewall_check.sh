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

check_contains "$PROMPTS_FILE" "## Scope note" "Prompt scope note present"
check_contains "$PROMPTS_FILE" "It does not own document ownership" "Prompt references DESIGN governance boundary"
check_contains "$PROMPTS_FILE" "It does not own document ownership, architecture" "Prompt references ARCHITECTURE/STACK boundary"
check_contains "$PROMPTS_FILE" "This document owns runtime execution only." "Prompt runtime-only scope rule present"
check_contains "$PROMPTS_FILE" "## OnePrompt execution model" "OnePrompt execution model section present"
check_contains "$PROMPTS_FILE" '`PO` is the single customer interface for runtime execution.' "Default PO role rule present"
check_contains "$PROMPTS_FILE" "Exactly one package may be active at a time." "Single active package rule present"
check_contains "$PROMPTS_FILE" 'Exactly one `changes/CHG-*.md` document may be active at a time.' "Single active CHG rule present"
check_contains "$PROMPTS_FILE" '`package_id`' "CHG package_id key present"
check_contains "$PROMPTS_FILE" "## PO runtime contract" "PO runtime section present"
check_contains "$PROMPTS_FILE" "## Runtime reporting truth obligations" "Reporting truth section present"
check_contains "$PROMPTS_FILE" "DEV execution mode contract" "DEV mode section present"
check_contains "$PROMPTS_FILE" "AUDIT execution mode contract" "AUDIT mode section present"
check_contains "$PROMPTS_FILE" "## Role packet contract" "Role packet contract section present"
check_contains "$PROMPTS_FILE" "## Active package and CHG lock" "Active CHG artifact section present"
check_contains "$PROMPTS_FILE" 'When `execution_mode=DEV`' "DEV execution token present"
check_contains "$PROMPTS_FILE" 'When `execution_mode=AUDIT`' "AUDIT execution token present"
check_contains "$PROMPTS_FILE" 'execute separated Python unit and integration test runs when Python tests are in scope' "Split Python test rule present"
check_contains "$PROMPTS_FILE" 'execute positive and negative test evidence for each active requirement unless non-applicability is explicitly justified in package evidence and left for AUDIT verification' "Per-REQ positive/negative rule present"
check_contains "$PROMPTS_FILE" "use only approved audit inputs" "AUDIT allowed canonical docs set present"
check_contains "$PROMPTS_FILE" "treat affected module-local documentation/specification near the code as required execution preparation when technically affected" "Module-local documentation execution rule present"
check_contains "$PROMPTS_FILE" "Any undeclared source usage in DEV, AUDIT, or execution artifacts is forbidden." "Undeclared source usage rule present"
check_contains "$PROMPTS_FILE" "If additional edits occurred after an earlier assessment in the same turn, that chronology must be disclosed explicitly." "Same-turn chronology disclosure rule present"
check_contains "$PROMPTS_FILE" "A report must not imply that no further changes were required if same-turn repository changes did occur after the referenced assessment point." "No-additional-changes restriction present"
check_contains "$PROMPTS_FILE" "## Runtime fail semantics" "Runtime fail semantics section present"
check_contains "$PROMPTS_FILE" "more than one active package" "Multiple package fail semantics present"
check_contains "$PROMPTS_FILE" "missing active CHG document" "Missing active CHG fail semantics present"
check_contains "$PROMPTS_FILE" 'missing machine-readable evidence bound to the active `chg_id`' "Active chg_id binding fail semantics present"
check_contains "$PROMPTS_FILE" "misleading final runtime summary that hides same-turn repair edits" "Misleading-summary fail semantics present"
check_contains "$PROMPTS_FILE" "missing required positive and negative test evidence per active requirement without explicit package-evidence justification verified by AUDIT" "Per-REQ fail semantics present"
check_contains "$PROMPTS_FILE" "missing separated Python unit and integration evidence when Python tests are in scope" "Split-test fail semantics present"

if grep -Eiq "private reasoning|private rationale|DEV private reasoning" "$PROMPTS_FILE"; then
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
