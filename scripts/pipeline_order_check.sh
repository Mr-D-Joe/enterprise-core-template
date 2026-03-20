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
  "$BASE_DIR/scripts/artifact_truth_check.sh"
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

check_contains "$BASE_DIR/AGENTS.md" "PO is the only role allowed to initiate DEV and AUDIT runs for a package." "AGENTS restricts initiation to PO"
check_contains "$BASE_DIR/CONTRIBUTING.md" "No step may be skipped or reordered." "CONTRIBUTING enforces no-skip sequence"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Merge must not proceed unless the active package completed required enforcement steps and no hard blocker remains open." "CONTRIBUTING binds merge to enforcement completion"
check_contains "$BASE_DIR/PROMPTS.md" "PO must execute this ordered chain:" "PROMPTS contains ordered PO preparation chain"
check_contains "$BASE_DIR/PROMPTS.md" 'The active CHG document is the single operative package execution context for DEV and AUDIT.' "PROMPTS binds execution to active CHG"
check_contains "$BASE_DIR/PROMPTS.md" "starting a new package while a previous package is still open" "PROMPTS prevents overlapping package flow"
check_contains "$BASE_DIR/PROMPTS.md" "misleading final runtime summary that hides same-turn repair edits." "PROMPTS fails misleading final summaries"
check_contains "$BASE_DIR/DESIGN.md" '`docs/BACKLOG.md`: compact, human-readable package control.' "DESIGN defines backlog as package control"
check_contains "$BASE_DIR/DESIGN.md" '`CHANGELOG.md`: release history only.' "DESIGN defines changelog as release history"
check_contains "$BASE_DIR/DESIGN.md" "Alternative parallel active locations for the same responsibility are forbidden." "DESIGN forbids parallel artifact paths"
check_contains "$BASE_DIR/README.md" '`changes/CHG-TEMPLATE.md`' "README points to bounded change briefs"
check_contains "$BASE_DIR/ARCHITECTURE.md" "The preferred default architecture is a modular monolith unless justified constraints require a different structure." "ARCHITECTURE sets modular-monolith default"
check_contains "$BASE_DIR/STACK.md" "Tooling must start with one profile selection before implementation." "STACK enforces profile-first tooling"
check_contains "$BASE_DIR/STACK.md" "## Python typing and editor policy" "STACK defines Python typing/editor policy"
check_contains "$BASE_DIR/STACK.md" 'installed `.venv/bin/pyright`.' "STACK requires installed root pyright"
check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" '`changes/CHG-TEMPLATE.md`' "STARTUP checklist points to change-brief flow"
check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" 'Confirm exactly one active `changes/CHG-*.md` exists.' "STARTUP checklist enforces single active CHG"
check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" 'Confirm active CHG `package_id` matches backlog `active_package_id`.' "STARTUP checklist enforces backlog/CHG binding"
check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" '`pyrightconfig.json`' "STARTUP checklist references pyright config"
check_contains "$BASE_DIR/docs/governance/DELIVERY_PIPELINE_PROTOCOL.md" "PO executes official PR merge path." "Delivery protocol retains PO merge authority"
check_contains "$BASE_DIR/docs/governance/DELIVERY_PIPELINE_PROTOCOL.md" "current_dev_gate.env" "Delivery protocol references current DEV gate pointer"
check_contains "$BASE_DIR/docs/governance/DELIVERY_PIPELINE_PROTOCOL.md" "current_audit_gate.env" "Delivery protocol references current AUDIT gate pointer"
check_contains "$BASE_DIR/docs/governance/GITHUB_RELEASE_PROTOCOL.md" 'Merge execution is performed by PO identity after `AUDIT=APPROVE`.' "Release protocol retains audit-gated merge"
check_contains "$BASE_DIR/docs/governance/GITHUB_RELEASE_PROTOCOL.md" "Current authoritative truth is declared only by:" "Release protocol defines authoritative truth"
check_contains "$BASE_DIR/docs/governance/FOUR_EYES_GATING.md" "scripts/gates/dev_gate.sh" "Four-eyes gating references DEV gate"
check_contains "$BASE_DIR/docs/governance/FOUR_EYES_GATING.md" "scripts/gates/audit_gate.sh" "Four-eyes gating references AUDIT gate"
check_contains "$BASE_DIR/docs/governance/FOUR_EYES_GATING.md" "current_dev_gate.env" "Four-eyes gating references current DEV gate pointer"
check_contains "$BASE_DIR/docs/governance/FOUR_EYES_GATING.md" "current_audit_gate.env" "Four-eyes gating references current AUDIT gate pointer"

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
