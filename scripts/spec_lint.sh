#!/usr/bin/env bash
set -euo pipefail

STRICT_MODE="false"

if [[ "${1:-}" == "--strict" ]]; then
  STRICT_MODE="true"
fi

EXIT_CODE=0

require_file() {
  local file="$1"
  if [[ ! -f "$file" ]]; then
    echo "FAIL missing required scaffold: $file"
    EXIT_CODE=1
  fi
}

require_heading() {
  local file="$1"
  local heading="$2"
  if ! grep -Fq "$heading" "$file"; then
    echo "FAIL $file missing heading: $heading"
    EXIT_CODE=1
  fi
}

check_template_placeholders() {
  local file="$1"
  if [[ "$STRICT_MODE" != "true" ]]; then
    return 0
  fi

  if grep -nE "\b(TBD|TODO|XXX)\b" "$file" >/dev/null; then
    echo "FAIL $file unresolved planning token found (TBD/TODO/XXX)"
    EXIT_CODE=1
  fi
}

require_file "changes/CHG-TEMPLATE.md"
require_file "docs/modules/index.md"
require_file "docs/templates/module-docs/README.md"
require_file "docs/templates/module-docs/ARCHITECTURE.md"
require_file "docs/templates/module-docs/TESTING.md"
require_file "docs/templates/module-docs/DECISIONS.md"

require_heading "changes/CHG-TEMPLATE.md" "# CHG-TEMPLATE"
require_heading "changes/CHG-TEMPLATE.md" "## Goal"
require_heading "changes/CHG-TEMPLATE.md" "## Affected MOD_IDs"
require_heading "changes/CHG-TEMPLATE.md" "## Pass / fail criteria"

require_heading "docs/modules/index.md" "# Modules Index"
require_heading "docs/modules/index.md" "| MOD_ID |"

require_heading "docs/templates/module-docs/README.md" "# Module README Template"
require_heading "docs/templates/module-docs/ARCHITECTURE.md" "# Module ARCHITECTURE Template"
require_heading "docs/templates/module-docs/TESTING.md" "# Module TESTING Template"
require_heading "docs/templates/module-docs/DECISIONS.md" "# Module DECISIONS Template"

while IFS= read -r file; do
  check_template_placeholders "$file"
done < <(find changes docs/modules docs/templates/module-docs -type f -name "*.md" | sort)

if [[ "$EXIT_CODE" -eq 0 ]]; then
  echo "PASS spec-lint"
else
  echo "FAIL spec-lint"
fi
exit "$EXIT_CODE"
