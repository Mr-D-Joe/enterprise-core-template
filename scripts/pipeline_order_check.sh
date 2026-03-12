#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EXIT_CODE=0

required_docs=(
  "$BASE_DIR/AGENTS.md"
  "$BASE_DIR/DESIGN.md"
  "$BASE_DIR/ARCHITECTURE.md"
  "$BASE_DIR/STACK.md"
  "$BASE_DIR/CONTRIBUTING.md"
  "$BASE_DIR/PROMPTS.md"
  "$BASE_DIR/LASTENHEFT.md"
  "$BASE_DIR/CHANGELOG.md"
  "$BASE_DIR/docs/BACKLOG.md"
  "$BASE_DIR/docs/STARTUP_CHECKLIST.md"
  "$BASE_DIR/changes/CHG-TEMPLATE.md"
  "$BASE_DIR/docs/modules/index.md"
  "$BASE_DIR/docs/templates/module-docs/README.md"
  "$BASE_DIR/docs/templates/module-docs/ARCHITECTURE.md"
  "$BASE_DIR/docs/templates/module-docs/TESTING.md"
  "$BASE_DIR/docs/templates/module-docs/DECISIONS.md"
  "$BASE_DIR/scripts/prompt_firewall_check.sh"
  "$BASE_DIR/scripts/spec_lint.sh"
  "$BASE_DIR/scripts/gates/dev_gate.sh"
  "$BASE_DIR/scripts/gates/audit_gate.sh"
  "$BASE_DIR/docs/governance/DELIVERY_PIPELINE_PROTOCOL.md"
  "$BASE_DIR/docs/governance/GITHUB_RELEASE_PROTOCOL.md"
  "$BASE_DIR/docs/governance/FOUR_EYES_GATING.md"
)

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

echo "Running delivery pipeline protocol check..."

for f in "${required_docs[@]}"; do
  if [[ -f "$f" ]]; then
    echo "OK   $f"
  else
    echo "FAIL missing required file: $f"
    EXIT_CODE=1
  fi
done

check_contains "$BASE_DIR/AGENTS.md" "Requirement -> DEV -> AUDIT -> PR -> Merge -> Version -> Clean Desk" "AGENTS contains full delivery chain"
check_contains "$BASE_DIR/CONTRIBUTING.md" "No step may be skipped or reordered." "CONTRIBUTING enforces no-skip sequence"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Merge authorization (PO based on AUDIT APPROVE)" "CONTRIBUTING binds merge to audit approval"
check_contains "$BASE_DIR/PROMPTS.md" "PO must autonomously drive the full package through:" "PROMPTS contains full-package orchestration rule"
check_contains "$BASE_DIR/PROMPTS.md" "Requirement -> DEV -> AUDIT -> PR -> Merge -> Version -> Clean Desk." "PROMPTS contains full package chain"
check_contains "$BASE_DIR/PROMPTS.md" 'The active `changes/CHG-*.md` is the single operative package document for DEV and AUDIT.' "PROMPTS binds execution to active CHG"
check_contains "$BASE_DIR/PROMPTS.md" "A package is only complete when all six closure steps are finished." "PROMPTS defines closure completion"
check_contains "$BASE_DIR/README.md" '`changes/CHG-TEMPLATE.md`' "README points to bounded change briefs"
check_contains "$BASE_DIR/DESIGN.md" "Alternative parallel locations for the same artifact type are forbidden." "DESIGN forbids parallel artifact paths"
check_contains "$BASE_DIR/DESIGN.md" '`docs/specs/*.md` are legacy requirement artifacts.' "DESIGN marks docs/specs as legacy"
check_contains "$BASE_DIR/ARCHITECTURE.md" "Default architecture is a modular monolith." "ARCHITECTURE sets modular-monolith default"
check_contains "$BASE_DIR/STACK.md" "Tooling must start with one profile selection before implementation." "STACK enforces profile-first tooling"
check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" '`changes/CHG-TEMPLATE.md`' "STARTUP checklist points to change-brief flow"
check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" 'Confirm exactly one active `changes/CHG-*.md` exists.' "STARTUP checklist enforces single active CHG"
check_contains "$BASE_DIR/docs/governance/DELIVERY_PIPELINE_PROTOCOL.md" "PO executes official PR merge path." "Delivery protocol retains PO merge authority"
check_contains "$BASE_DIR/docs/governance/GITHUB_RELEASE_PROTOCOL.md" 'Merge execution is performed by PO identity after `AUDIT=APPROVE`.' "Release protocol retains audit-gated merge"
check_contains "$BASE_DIR/docs/governance/FOUR_EYES_GATING.md" "scripts/gates/dev_gate.sh" "Four-eyes gating references DEV gate"
check_contains "$BASE_DIR/docs/governance/FOUR_EYES_GATING.md" "scripts/gates/audit_gate.sh" "Four-eyes gating references AUDIT gate"

if find "$BASE_DIR/docs/specs" -type f -name "*.md" 2>/dev/null | grep -q .; then
  echo "FAIL legacy docs/specs/*.md files still exist as active artifacts"
  EXIT_CODE=1
else
  echo "OK   no active legacy docs/specs/*.md files"
fi

if grep -R -n -F "REQUEST_CHANGES" "$BASE_DIR/docs/governance" "$BASE_DIR/PROMPTS.md" >/dev/null 2>&1; then
  echo "FAIL non-binary decision term REQUEST_CHANGES found in prompt/governance templates"
  EXIT_CODE=1
else
  echo "OK   binary decision vocabulary enforced"
fi

if [[ "$EXIT_CODE" -eq 0 ]]; then
  echo "PASS pipeline-order-check"
else
  echo "FAIL pipeline-order-check"
fi

exit "$EXIT_CODE"
