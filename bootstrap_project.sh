#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_ROOT="$SCRIPT_DIR"

usage() {
  cat <<'EOF'
Usage:
  ./scripts/bootstrap_project.sh [target_parent_dir]

Description:
  Creates a new project from this template.
  The script asks only for the project name.

Arguments:
  target_parent_dir   Optional parent directory for the new project folder.
                      Default: current working directory
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

TARGET_PARENT="${1:-$PWD}"
if [[ ! -d "$TARGET_PARENT" ]]; then
  echo "ERROR: target parent directory does not exist: $TARGET_PARENT" >&2
  exit 1
fi

read -r -p "Projektname: " PROJECT_NAME
PROJECT_NAME="$(printf '%s' "$PROJECT_NAME" | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//')"
if [[ -z "$PROJECT_NAME" ]]; then
  echo "ERROR: project name must not be empty." >&2
  exit 1
fi

PROJECT_SLUG="$(printf '%s' "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//')"
if [[ -z "$PROJECT_SLUG" ]]; then
  PROJECT_SLUG="new-project"
fi

TARGET_DIR="${TARGET_PARENT%/}/$PROJECT_SLUG"
if [[ -e "$TARGET_DIR" ]]; then
  echo "ERROR: target already exists: $TARGET_DIR" >&2
  exit 1
fi

mkdir -p "$TARGET_DIR"

# Copy full template tree into the new project.
while IFS= read -r -d '' src; do
  cp -R "$src" "$TARGET_DIR/"
done < <(
  find "$TEMPLATE_ROOT" -mindepth 1 -maxdepth 1 \
    ! -name ".git" \
    ! -name ".DS_Store" \
    ! -name "prompts" \
    -print0
)

# Create runtime artifact folders for gate outputs.
mkdir -p \
  "$TARGET_DIR/system_reports/gates" \
  "$TARGET_DIR/system_reports/releases" \
  "$TARGET_DIR/system_reports/tasks" \
  "$TARGET_DIR/reports"

TODAY_UTC="$(date -u +%Y-%m-%d)"
NOW_UTC_TS="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

ESCAPED_PROJECT_NAME="$(printf '%s' "$PROJECT_NAME" | sed -e 's/[\/&]/\\&/g')"
ESCAPED_TODAY_UTC="$(printf '%s' "$TODAY_UTC" | sed -e 's/[\/&]/\\&/g')"

# Resolve template placeholders so the project can be used immediately.
while IFS= read -r -d '' file; do
  tmp_file="${file}.tmp"
  sed \
    -e "s/<PROJECT_NAME>/$ESCAPED_PROJECT_NAME/g" \
    -e "s/Template Project/$ESCAPED_PROJECT_NAME/g" \
    -e "s/<YYYY-MM-DD>/$ESCAPED_TODAY_UTC/g" \
    "$file" > "$tmp_file"
  mv "$tmp_file" "$file"
done < <(find "$TARGET_DIR" -type f \( -name "*.md" -o -name "*.txt" \) -print0)

# Create an initial machine-readable PO role packet skeleton.
cat > "$TARGET_DIR/system_reports/gates/po_role_packet_template.env" <<EOF
execution_mode=DEV
po_packet_id=PO-PACKET-001
req_ids=
scope_allowlist=
allowed_inputs_hash=
target_commit_sha=
po_agent_id=po-default
created_at_utc=$NOW_UTC_TS
EOF

echo "Project created: $TARGET_DIR"
echo "Next steps:"
echo "1) cd \"$TARGET_DIR\""
echo "2) Review AGENTS.md, DESIGN.md, CONTRIBUTING.md, PROMPTS.md"
echo "3) Start your first PO packet with system_reports/gates/po_role_packet_template.env"
