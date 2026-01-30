#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root_dir"

fail() {
  echo "[GOV-LINT-FAIL] $1" >&2
  exit 1
}

require_line() {
  local file="$1"; shift
  local line="$1"; shift
  grep -Fxq -- "$line" "$file" || fail "Missing exact line in $file: $line"
}

require_file() {
  local file="$1"
  [ -f "$file" ] || fail "Missing required file: $file"
}

require_file "DESIGN.md"
require_file "LASTENHEFT.md"
require_file "docs/GOVERNANCE_LINT_SPEC.md"
require_file "docs/RELEASE_CHECKLIST.md"
require_file "docs/artifact_index.md"
require_file ".github/PULL_REQUEST_TEMPLATE.md"
require_file "CONTRIBUTING.md"

init_status="$(grep -E '^INIT_STATUS:' TEMPLATE_USAGE_GUIDE.md | awk '{print $2}')"
if [ -z "$init_status" ]; then
  fail "INIT_STATUS not found in TEMPLATE_USAGE_GUIDE.md"
fi

derived=false
if [ "$init_status" = "COMPLETE" ]; then
  derived=true
fi

# GOV-LINT-16 header block
expected_header=(
  "# Artifact Index"
  "Status: TEMPLATE"
  "ORDER LOCKED"
  ""
  "IMMUTABLE HEADER BLOCK (LINES 1–3) — DO NOT EDIT"
)
actual_header=()
while IFS= read -r line; do
  actual_header+=("$line")
done < <(sed -n '1,5p' docs/artifact_index.md)
for i in "${!expected_header[@]}"; do
  if [ "${actual_header[$i]-}" != "${expected_header[$i]}" ]; then
    fail "docs/artifact_index.md header block mismatch at line $((i+1))"
  fi
done

# GOV-LINT-15 protocol lines
protocol_lines=(
  "1. Add new DOC-IDs"
  "2. Update the source artifact file"
  "3. Keep order locked"
  "4. Update TECHNICAL_SPEC.md"
  "5. Update CHANGELOG.md"
)
found_protocol=()
while IFS= read -r line; do
  found_protocol+=("$line")
done < <(awk '
  $0=="## Artifact Index Update Protocol" {in_section=1; next}
  in_section && /^[0-9]+\./ {print; if (++count==5) exit}
' docs/artifact_index.md)
if [ "${#found_protocol[@]}" -ne 5 ]; then
  fail "Artifact Index Update Protocol does not contain 5 numbered lines"
fi
for i in "${!protocol_lines[@]}"; do
  if [ "${found_protocol[$i]}" != "${protocol_lines[$i]}" ]; then
    fail "Artifact Index Update Protocol line mismatch: expected '${protocol_lines[$i]}'"
  fi
done

# PR template mandatory lines (GOV-LINT-18/21/24/25)
require_line ".github/PULL_REQUEST_TEMPLATE.md" "**This checklist is mandatory and must be completed before merge.**"
require_line ".github/PULL_REQUEST_TEMPLATE.md" "## PR Workflow Checklist (Mandatory) — IMMUTABLE SECTION"
require_line ".github/PULL_REQUEST_TEMPLATE.md" "- [ ] **Lint Signature completed**"
require_line ".github/PULL_REQUEST_TEMPLATE.md" "- [ ] DESIGN.md reviewed for compliance"
require_line ".github/PULL_REQUEST_TEMPLATE.md" "- [ ] LASTENHEFT.md updated (if functional change)"
require_line ".github/PULL_REQUEST_TEMPLATE.md" "- [ ] CHANGELOG.md updated (version + entry)"
require_line ".github/PULL_REQUEST_TEMPLATE.md" "- [ ] Lint Signature completed"
require_line ".github/PULL_REQUEST_TEMPLATE.md" "- [ ] PR template checklist completed (.github/PULL_REQUEST_TEMPLATE.md)"

# CONTRIBUTING checklist table header
require_line "CONTRIBUTING.md" "| Item | GOV-LINT ID | Required | Check Regex |"

# Release checklist mirror line and immutable markers
require_line "docs/RELEASE_CHECKLIST.md" "## 8. Release Gate (Must-Pass) — IMMUTABLE TABLE"
require_line "docs/RELEASE_CHECKLIST.md" "IMMUTABLE TABLE — DO NOT EDIT"
require_line "docs/RELEASE_CHECKLIST.md" '> **Mirror Rule (GOV-LINT-20):** This table must exactly mirror the Release Gate Map in `docs/GOVERNANCE_LINT_SPEC.md`.'

# Release gate table equality (GOV-LINT-20)
release_gate_checklist=()
while IFS= read -r line; do
  release_gate_checklist+=("$line")
done < <(awk '
  $0=="| GOV-LINT ID | Required |" {in_table=1; next}
  in_table && $0 ~ /^\| GOV-LINT-/ {print}
  in_table && $0=="" {exit}
' docs/RELEASE_CHECKLIST.md)
release_gate_spec=()
while IFS= read -r line; do
  release_gate_spec+=("$line")
done < <(awk '
  $0=="## Release Gate Map" {in_map=1; next}
  in_map && $0=="" && count==0 {next}
  in_map && $0 ~ /^\| GOV-LINT-/ {print; count++}
  in_map && $0=="" && count>0 {exit}
' docs/GOVERNANCE_LINT_SPEC.md)
if [ "${#release_gate_checklist[@]}" -ne "${#release_gate_spec[@]}" ]; then
  fail "Release Gate Map mismatch (row count)"
fi
for i in "${!release_gate_checklist[@]}"; do
  if [ "${release_gate_checklist[$i]}" != "${release_gate_spec[$i]}" ]; then
    fail "Release Gate Map mismatch at row $((i+1))"
  fi
done

if [ "$derived" = true ]; then
  # Placeholder resolution
  if command -v rg >/dev/null 2>&1; then
    if rg -n "\{\{[A-Z0-9_]+\}\}" . >/dev/null; then
      fail "Placeholders remain after INIT_STATUS: COMPLETE"
    fi
  else
    if grep -R -n -E "\{\{[A-Z0-9_]+\}\}" . >/dev/null; then
      fail "Placeholders remain after INIT_STATUS: COMPLETE"
    fi
  fi

  # Platform target must be set
  platform_target="$(awk '
    /^### 1\\.4 Zielplattform/ {in_section=1; next}
    in_section && NF {print; exit}
  ' LASTENHEFT.md | grep -E '^(Desktop|Web|API-only)$' || true)"
  if [ -z "$platform_target" ]; then
    fail "Target platform not set in LASTENHEFT.md"
  fi

  # Required artifact headings order
  declare -A artifacts
  artifacts["docs/api_spec.md"]=$'# API Specification\n## DOC-API-01 — Overview\n## DOC-API-02 — Endpoints\n## DOC-API-03 — Error Model\n## DOC-API-04 — Versioning'
  artifacts["shared/ipc_contracts.md"]=$'# IPC Contracts\n## DOC-IPC-01 — Message Types\n## DOC-IPC-02 — Error Objects\n## DOC-IPC-03 — Versioning'
  artifacts["desktop/runtime_config.md"]=$'# Desktop Runtime Configuration\n## DOC-DESK-01 — Runtime Choice\n## DOC-DESK-02 — IPC Bridge\n## DOC-DESK-03 — Local Storage\n## DOC-DESK-04 — Packaging Hooks'
  artifacts["desktop/packaging.md"]=$'# Desktop Packaging\n## DOC-PACK-01 — Build Targets\n## DOC-PACK-02 — Signing\n## DOC-PACK-03 — Distribution'
  artifacts["frontend/build_config.md"]=$'# Frontend Build Configuration\n## DOC-FE-01 — Build Tool\n## DOC-FE-02 — Environment Variables\n## DOC-FE-03 — Output Targets'
  artifacts["ai_service/runtime_config.md"]=$'# Service Runtime Configuration\n## DOC-BE-01 — Runtime\n## DOC-BE-02 — Dependencies\n## DOC-BE-03 — Environment Variables\n## DOC-BE-04 — Deployment'

  while IFS= read -r file; do
    [ -f "$file" ] || fail "Missing required artifact file: $file"
    expected="${artifacts[$file]}"
    IFS=$'\n' read -r -d '' -a expected_lines <<<"${expected}"$'\0'
    for line in "${expected_lines[@]}"; do
      grep -Fqx "$line" "$file" || fail "Missing heading in $file: $line"
    done
  done < <(printf '%s\n' "${!artifacts[@]}")
fi

echo "[GOV-LINT] OK"
