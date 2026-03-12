#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BOOTSTRAP_SCRIPT="$SCRIPT_DIR/bootstrap_project.sh"

if [[ ! -x "$BOOTSTRAP_SCRIPT" ]]; then
  echo "ERROR: bootstrap script not found or not executable: $BOOTSTRAP_SCRIPT" >&2
  exit 1
fi

project_name="$(osascript <<'EOF'
text returned of (display dialog "Projektname fuer das neue Projekt:" default answer "" buttons {"Abbrechen", "OK"} default button "OK")
EOF
)"

project_name="$(printf '%s' "$project_name" | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//')"
if [[ -z "$project_name" ]]; then
  echo "ERROR: project name must not be empty." >&2
  exit 1
fi

target_parent="$(osascript <<'EOF'
POSIX path of (choose folder with prompt "Waehle den Zielordner fuer das neue Projekt:")
EOF
)"

if [[ -z "$target_parent" || ! -d "$target_parent" ]]; then
  echo "ERROR: no valid target folder selected." >&2
  exit 1
fi

printf '%s\n' "$project_name" | "$BOOTSTRAP_SCRIPT" "$target_parent"
