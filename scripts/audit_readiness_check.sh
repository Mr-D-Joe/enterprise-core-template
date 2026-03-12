#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EXIT_CODE=0

req_file() {
  local file="$1"
  if [[ -f "$file" ]]; then
    echo "OK   $file"
  else
    echo "FAIL missing required file: $file"
    EXIT_CODE=1
  fi
}

req_exec() {
  local file="$1"
  if [[ -x "$file" ]]; then
    echo "OK   executable $file"
  else
    echo "FAIL required executable missing or not executable: $file"
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

check_metadata_value() {
  local file="$1"
  local key="$2"
  local value
  value="$(grep -E "^- ${key}=" "$file" | head -n1 | sed -E "s/^- ${key}=//" || true)"
  if [[ -n "$value" ]]; then
    echo "OK   $file contains $key"
  else
    echo "FAIL $file missing $key"
    EXIT_CODE=1
  fi
}

echo "Running independent audit readiness check..."

req_file "$BASE_DIR/AGENTS.md"
req_file "$BASE_DIR/DESIGN.md"
req_file "$BASE_DIR/ARCHITECTURE.md"
req_file "$BASE_DIR/STACK.md"
req_file "$BASE_DIR/CONTRIBUTING.md"
req_file "$BASE_DIR/PROMPTS.md"
req_file "$BASE_DIR/LASTENHEFT.md"
req_file "$BASE_DIR/README.md"
req_file "$BASE_DIR/CHANGELOG.md"
req_file "$BASE_DIR/docs/BACKLOG.md"
req_file "$BASE_DIR/docs/STARTUP_CHECKLIST.md"
req_file "$BASE_DIR/changes/CHG-TEMPLATE.md"
req_file "$BASE_DIR/docs/modules/index.md"
req_file "$BASE_DIR/docs/templates/module-docs/README.md"
req_file "$BASE_DIR/docs/templates/module-docs/ARCHITECTURE.md"
req_file "$BASE_DIR/docs/templates/module-docs/TESTING.md"
req_file "$BASE_DIR/docs/templates/module-docs/DECISIONS.md"
req_file "$BASE_DIR/docs/governance/INDEPENDENT_AUDIT_POLICY.md"
req_file "$BASE_DIR/docs/governance/ISO_CONTROL_MATRIX_TEMPLATE.md"
req_file "$BASE_DIR/docs/governance/AUDIT_REPORT_TEMPLATE.md"
req_file "$BASE_DIR/docs/governance/TRACEABILITY_MATRIX_TEMPLATE.md"
req_file "$BASE_DIR/docs/governance/DELIVERY_PIPELINE_PROTOCOL.md"
req_file "$BASE_DIR/docs/governance/GITHUB_RELEASE_PROTOCOL.md"
req_file "$BASE_DIR/docs/governance/FOUR_EYES_GATING.md"
req_file "$BASE_DIR/scripts/spec_lint.sh"
req_file "$BASE_DIR/scripts/prompt_firewall_check.sh"
req_file "$BASE_DIR/scripts/pipeline_order_check.sh"
req_file "$BASE_DIR/scripts/gates/dev_gate.sh"
req_file "$BASE_DIR/scripts/gates/audit_gate.sh"
req_exec "$BASE_DIR/scripts/spec_lint.sh"
req_exec "$BASE_DIR/scripts/prompt_firewall_check.sh"
req_exec "$BASE_DIR/scripts/pipeline_order_check.sh"
req_exec "$BASE_DIR/scripts/gates/dev_gate.sh"
req_exec "$BASE_DIR/scripts/gates/audit_gate.sh"

check_contains "$BASE_DIR/DESIGN.md" "## Canonical ownership" "DESIGN canonical ownership section present"
check_contains "$BASE_DIR/DESIGN.md" "## Canonical paths" "DESIGN canonical paths section present"
check_contains "$BASE_DIR/DESIGN.md" "## Structural-truth rule" "DESIGN structural-truth section present"
check_contains "$BASE_DIR/DESIGN.md" "## Legacy structure migration" "DESIGN legacy-migration section present"

check_contains "$BASE_DIR/ARCHITECTURE.md" "## Architecture stance" "ARCHITECTURE stance section present"
check_contains "$BASE_DIR/ARCHITECTURE.md" "## Module model" "ARCHITECTURE module-model section present"
check_contains "$BASE_DIR/ARCHITECTURE.md" "## Boundary rules" "ARCHITECTURE boundary section present"
check_contains "$BASE_DIR/ARCHITECTURE.md" "## Layering rules" "ARCHITECTURE layering section present"
check_contains "$BASE_DIR/ARCHITECTURE.md" "## Contract-first rules" "ARCHITECTURE contract-first section present"
check_contains "$BASE_DIR/ARCHITECTURE.md" "## Security and privacy architecture" "ARCHITECTURE security/privacy section present"
check_contains "$BASE_DIR/ARCHITECTURE.md" "## Observability architecture" "ARCHITECTURE observability section present"
check_contains "$BASE_DIR/ARCHITECTURE.md" "## Architecture fitness functions" "ARCHITECTURE fitness-functions section present"

check_contains "$BASE_DIR/STACK.md" "## Technology profile matrix" "STACK profile matrix present"
check_contains "$BASE_DIR/STACK.md" "## Tool selection policy" "STACK tool-selection section present"
check_contains "$BASE_DIR/STACK.md" "## Canonical tooling decision packet" "STACK tooling-decision schema present"
check_contains "$BASE_DIR/STACK.md" "TOOLING_SOURCE_MAX_AGE_DAYS=90" "STACK tooling-source age policy present"

check_contains "$BASE_DIR/README.md" '`ARCHITECTURE.md`' "README references ARCHITECTURE"
check_contains "$BASE_DIR/README.md" '`STACK.md`' "README references STACK"
check_contains "$BASE_DIR/README.md" '`changes/CHG-TEMPLATE.md`' "README references change-brief template"
check_contains "$BASE_DIR/README.md" '`docs/templates/module-docs/`' "README references module-doc scaffold"

check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" '`ARCHITECTURE.md`' "STARTUP checklist references ARCHITECTURE"
check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" '`STACK.md`' "STARTUP checklist references STACK"
check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" '`changes/CHG-TEMPLATE.md`' "STARTUP checklist references change-brief template"

check_contains "$BASE_DIR/changes/CHG-TEMPLATE.md" "# CHG-TEMPLATE" "Change-brief template title present"
check_contains "$BASE_DIR/changes/CHG-TEMPLATE.md" "## Goal" "Change-brief template goal section present"
check_contains "$BASE_DIR/changes/CHG-TEMPLATE.md" "## Affected MOD_IDs" "Change-brief template MOD_ID section present"
check_contains "$BASE_DIR/docs/modules/index.md" "| MOD_ID |" "Modules index table present"
check_contains "$BASE_DIR/docs/templates/module-docs/README.md" "## Purpose" "Module README scaffold purpose section present"
check_contains "$BASE_DIR/docs/templates/module-docs/ARCHITECTURE.md" "## MOD_ID" "Module ARCHITECTURE scaffold MOD_ID section present"
check_contains "$BASE_DIR/docs/templates/module-docs/TESTING.md" "## Positive tests" "Module TESTING scaffold positive-tests section present"
check_contains "$BASE_DIR/docs/templates/module-docs/DECISIONS.md" "## Decision log" "Module DECISIONS scaffold decision-log section present"

check_metadata_value "$BASE_DIR/LASTENHEFT.md" "generated_at_utc"
check_metadata_value "$BASE_DIR/LASTENHEFT.md" "source_commit_sha"
check_metadata_value "$BASE_DIR/LASTENHEFT.md" "metrics_generation_mode"
check_metadata_value "$BASE_DIR/docs/BACKLOG.md" "generated_at_utc"
check_metadata_value "$BASE_DIR/docs/BACKLOG.md" "source_commit_sha"
check_metadata_value "$BASE_DIR/docs/BACKLOG.md" "planning_sync_state"
check_metadata_value "$BASE_DIR/docs/BACKLOG.md" "active_package_id"

if find "$BASE_DIR/docs/specs" -type f -name "*.md" 2>/dev/null | grep -q .; then
  echo "FAIL legacy docs/specs/*.md files still exist as parallel artifacts"
  EXIT_CODE=1
else
  echo "OK   no active legacy docs/specs/*.md files"
fi

if grep -R -n -F "REQUEST_CHANGES" "$BASE_DIR/docs/governance" "$BASE_DIR/PROMPTS.md" >/dev/null 2>&1; then
  echo "FAIL non-binary decision term REQUEST_CHANGES found in prompt/governance templates"
  EXIT_CODE=1
else
  echo "OK   binary decision vocabulary enforced in prompt/governance templates"
fi

if [[ "$EXIT_CODE" -eq 0 ]]; then
  echo "PASS audit-readiness-check"
else
  echo "FAIL audit-readiness-check"
fi

exit "$EXIT_CODE"
