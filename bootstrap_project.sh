#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_ROOT="$SCRIPT_DIR"

usage() {
  cat <<'EOF'
Usage:
  ./bootstrap_project.sh [target_parent_dir]

Description:
  Creates a new project from this template.
  The script asks only for the project name.

Arguments:
  target_parent_dir   Optional parent directory for the new project folder.
                      Default: current working directory
EOF
}

set_env_value() {
  local key="$1"
  local value="$2"
  local file="$3"

  awk -v k="$key" -v v="$value" '
    BEGIN { updated=0 }
    index($0, k "=") == 1 { $0 = k "=" v; updated=1 }
    { print }
    END { if (updated == 0) print k "=" v }
  ' "$file" > "${file}.tmp"
  mv "${file}.tmp" "$file"
}

detect_bin() {
  local candidate
  for candidate in "$@"; do
    if command -v "$candidate" >/dev/null 2>&1; then
      echo "$candidate"
      return 0
    fi
  done
  return 1
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

# Create initial tooling decision packet template.
cat > "$TARGET_DIR/system_reports/gates/tooling_decision_template.env" <<EOF
decision_packet_id=TOOL-DECISION-001
decision_status=REQUIRED
scope_req_ids=
application_profile=PROFILE_WEB_DEFAULT
frontend_ui_choice=Next.js+React+TypeScript
backend_choice=FastAPI
data_choice=PostgreSQL
mobile_choice=none
stability_target=stable_or_lts
official_source_1=
official_source_2=
official_source_3=
source_verified_utc=
source_age_days=
tooling_source_max_age_days=90
selection_rationale=
tradeoffs=
fallback_option=
created_at_utc=$NOW_UTC_TS
EOF

# Create a neutral runtime/toolchain environment template.
cat > "$TARGET_DIR/.env.template" <<'EOF'
# ------------------------------------------------------------------
# Generic runtime/toolchain template (fill per project stack).
# Do not store secrets in this file.
# ------------------------------------------------------------------
APP_ENV=development
RUNTIME_PROFILE=python

# Python
PYTHON_BIN=python3
PYTHON_VENV_DIR=.venv
PYTHONPATH=

# Node.js
NODE_ENV=development
NODE_VERSION=20

# .NET
DOTNET_ENVIRONMENT=Development
DOTNET_VERSION=8.0

# Native C/C++
CC=clang
CXX=clang++
CMAKE_BUILD_TYPE=Debug

# Optional native/lib paths
PKG_CONFIG_PATH=
LD_LIBRARY_PATH=
DYLD_LIBRARY_PATH=
EOF

# Default ignore rules for common local/runtime artifacts.
cat > "$TARGET_DIR/.gitignore" <<'EOF'
.venv/
venv/
__pycache__/
.mypy_cache/
.pytest_cache/
node_modules/
bin/
obj/
build/
dist/
.env
.env.local
EOF

# Auto-bootstrap runtime environment so customers do not need manual setup.
cp "$TARGET_DIR/.env.template" "$TARGET_DIR/.env"

python_bin="$(detect_bin python3 python || true)"
node_bin="$(detect_bin node || true)"
dotnet_bin="$(detect_bin dotnet || true)"
cc_bin="$(detect_bin clang gcc cc || true)"
cxx_bin="$(detect_bin clang++ g++ c++ || true)"

python_venv_status="SKIPPED"
runtime_bootstrap_status="PASS"

if [[ -n "$python_bin" ]]; then
  set_env_value "PYTHON_BIN" "$python_bin" "$TARGET_DIR/.env"
  if "$python_bin" -m venv "$TARGET_DIR/.venv" >/dev/null 2>&1; then
    python_venv_status="CREATED"
  else
    python_venv_status="FAILED"
    runtime_bootstrap_status="BEST_EFFORT"
  fi
fi

if [[ -n "$cc_bin" ]]; then
  set_env_value "CC" "$cc_bin" "$TARGET_DIR/.env"
fi
if [[ -n "$cxx_bin" ]]; then
  set_env_value "CXX" "$cxx_bin" "$TARGET_DIR/.env"
fi
if [[ -n "$node_bin" ]]; then
  set_env_value "NODE_VERSION" "$("$node_bin" --version | sed 's/^v//')" "$TARGET_DIR/.env"
fi
if [[ -n "$dotnet_bin" ]]; then
  set_env_value "DOTNET_VERSION" "$("$dotnet_bin" --version)" "$TARGET_DIR/.env"
fi

cat > "$TARGET_DIR/system_reports/gates/runtime_bootstrap.env" <<EOF
runtime_bootstrap_status=$runtime_bootstrap_status
runtime_bootstrap_utc=$NOW_UTC_TS
customer_manual_steps_required=false
env_template_created=true
env_file_created=true
python_bin=${python_bin:-missing}
python_venv_status=$python_venv_status
node_bin=${node_bin:-missing}
dotnet_bin=${dotnet_bin:-missing}
cc_bin=${cc_bin:-missing}
cxx_bin=${cxx_bin:-missing}
EOF

echo "Project created: $TARGET_DIR"
echo "Next steps:"
echo "1) cd \"$TARGET_DIR\""
echo "2) Review AGENTS.md, DESIGN.md, CONTRIBUTING.md, PROMPTS.md"
echo "3) Runtime bootstrap already executed (.env + optional .venv + runtime_bootstrap.env)"
echo "4) Tooling decision template is ready (set application_profile first in system_reports/gates/tooling_decision_template.env)"
echo "5) Start your first PO packet with system_reports/gates/po_role_packet_template.env"
