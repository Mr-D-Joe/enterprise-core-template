#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root_dir"

fail() {
  echo "[CONSISTENCY-FAIL] $1" >&2
  exit 1
}

get_version() {
  awk -F': ' '/^Version: / {gsub(/[[:space:]]+$/, "", $2); print $2; exit}' "$1"
}

get_date() {
  awk -F': ' '/^Datum: / {gsub(/[[:space:]]+$/, "", $2); print $2; exit}' "$1"
}

files=(
  DESIGN.md
  LASTENHEFT.md
  TECHNICAL_SPEC.md
  STYLEGUIDE.md
  PROMPTS.md
  SYSTEM_REPORT.md
  docs/RELEASE_CHECKLIST.md
  docs/GOVERNANCE_LINT_SPEC.md
  TEMPLATE_USAGE_GUIDE.md
)

base_version="$(get_version "${files[0]}")"
base_date="$(get_date "${files[0]}")"

if [ -z "$base_version" ] || [ -z "$base_date" ]; then
  fail "Missing Version/Datum in ${files[0]}"
fi

for file in "${files[@]}"; do
  version="$(get_version "$file")"
  date="$(get_date "$file")"
  if [ -z "$version" ] || [ -z "$date" ]; then
    fail "Missing Version/Datum in $file"
  fi
  if [ "$version" != "$base_version" ]; then
    fail "Version mismatch: $file has $version (expected $base_version)"
  fi
  if [ "$date" != "$base_date" ]; then
    fail "Date mismatch: $file has $date (expected $base_date)"
  fi
  echo "[CONSISTENCY] $file OK ($version / $date)"
  done

echo "[CONSISTENCY] All template doc versions/dates aligned."
