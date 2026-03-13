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
TEMPLATE_SOURCE_SHA="$(git -C "$TEMPLATE_ROOT" rev-parse HEAD 2>/dev/null || echo "unknown")"

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

# Refresh machine-generated planning metadata for the new project copy.
for planning_file in "$TARGET_DIR/LASTENHEFT.md" "$TARGET_DIR/docs/BACKLOG.md"; do
  if [[ -f "$planning_file" ]]; then
    sed -E \
      -e "s|^(- generated_at_utc=).*|\\1$NOW_UTC_TS|" \
      -e "s|^(- source_commit_sha=).*|\\1$TEMPLATE_SOURCE_SHA|" \
      "$planning_file" > "${planning_file}.tmp"
    mv "${planning_file}.tmp" "$planning_file"
  fi
done

# Reset copied template history so a new project starts in a neutral state.
rm -f "$TARGET_DIR/changes"/CHG-*.md

cat > "$TARGET_DIR/changes/CHG-TEMPLATE.md" <<'EOF'
# CHG-TEMPLATE

```yaml
chg_id: CHG-YYYY-XXXX
package_id: PKG-YYYY-XXXX
status: DRAFT
req_ids:
  - REQ-PLACEHOLDER
mod_ids:
  - MOD-PLACEHOLDER
included_sources:
  - AGENTS.md
  - PROMPTS.md
  - DESIGN.md
  - ARCHITECTURE.md
  - STACK.md
  - CONTRIBUTING.md
excluded_sources:
  - docs/BACKLOG.md
  - CHANGELOG.md
  - LASTENHEFT.md
created_at_utc: 2026-03-12T00:00:00Z
updated_at_utc: 2026-03-12T00:00:00Z
```

## Goal
- 

## Affected MOD_IDs
- 

## Included source documents
- `AGENTS.md`: canonical role constitution
- `PROMPTS.md`: runtime execution contract

## Excluded source documents
- `docs/BACKLOG.md`: source only, not default execution context
- `CHANGELOG.md`: source only, not default execution context
- `LASTENHEFT.md`: excluded unless explicit trigger applies

## Inclusion reason per included non-root source
- `<path>`: `<reason>`

## Backlog extraction
- Active package_id:
- Active package row:
- Scope slice:

## Changelog extraction
- Required history:
- Why relevant:

## Lastenheft inclusion decision
- Included: yes/no
- Trigger:
- Relevant excerpt:

## ADR inclusion decision
- Included: yes/no
- Governing ADRs:
- Why required:

## Non-goals
- 

## Contracts affected
- yes/no:

## Data model affected
- yes/no:

## Security and privacy impact
- 

## Neighbor-module inclusion reason
- `<module/path>`: `<direct dependency reason>`

## Pass / fail criteria
- 

## Relevant tests and checks
- 

## Explicitly excluded paths / modules
- 
EOF

cat > "$TARGET_DIR/docs/BACKLOG.md" <<EOF
# BACKLOG — $PROJECT_NAME

Status: Active

## Metadata (machine-generated, mandatory)
- generated_at_utc=$NOW_UTC_TS
- source_commit_sha=$TEMPLATE_SOURCE_SHA
- planning_sync_state=ready_for_first_package
- active_package_id=none
- next_package_id=none
- next_after_next_package_id=none

## Active package board
| package_id | req_ids | status | owner | evidence_paths | updated_at_utc |
|---|---|---|---|---|---|
| none | none | archived | PO | none | $NOW_UTC_TS |

## Ordered pending package queue
| sequence | package_id | req_ids | status | owner | evidence_paths | updated_at_utc |
|---|---|---|---|---|---|
| none | none | none | archived | PO | none | $NOW_UTC_TS |

## Compact closed package ledger
| package_id | req_ids | status | owner | evidence_paths | updated_at_utc |
|---|---|---|---|---|---|
| none | none | archived | PO | none | $NOW_UTC_TS |

## Rules
1. Exactly one package may be active at a time.
2. Backlog metadata must be refreshed before each DEV start.
3. Manual estimate fields are forbidden in active backlog state.
4. Every active package row must include evidence paths.
5. \`docs/BACKLOG.md\` is authoritative portfolio overview and is never default execution context.
6. Before DEV or AUDIT starts, PO must derive the active package backlog slice into the active \`changes/CHG-*.md\`.
7. Older completed-package detail must be compacted or archived under \`docs/archive/backlog/\` when repository policy thresholds are exceeded.
8. Backlog must expose \`active_package_id\`, \`next_package_id\`, and \`next_after_next_package_id\`.
9. If open work exists, the next executable package must be visible in machine-readable metadata and queue order.
EOF

cat > "$TARGET_DIR/LASTENHEFT.md" <<EOF
# LASTENHEFT — $PROJECT_NAME

This document is normative.
It is the orientation-only project overview for humans and AI.
It is not the default coding context and must not become an operational implementation container.
It may enter active execution context only when the active package changes scope/non-scope, key business terms, capability/module map, product-level functional intent, or high-level quality goals, and then only as a bounded excerpt derived into the active \`changes/CHG-*.md\`.

Version: 1.0.0
Date: $TODAY_UTC
Status: Active

## Planning metadata (machine-generated, mandatory)
- generated_at_utc=$NOW_UTC_TS
- source_commit_sha=$TEMPLATE_SOURCE_SHA
- metrics_generation_mode=machine_only
- last_closed_package_id=none

## Purpose
- Project goal:
- Target users:
- Platform target:

## Scope
- In scope:
- Out of scope:

## Key terms
- Primary business terms:
- Critical domain concepts:

## Capability and module map
| Capability | MOD_ID | Primary path | Public interfaces | Notes |
|---|---|---|---|---|
| Governance root | MOD-GOV-ROOT | \`AGENTS.md\`, \`DESIGN.md\`, \`ARCHITECTURE.md\`, \`STACK.md\`, \`CONTRIBUTING.md\`, \`PROMPTS.md\` | root governance docs | canonical repository governance |
| Template scaffolds | MOD-GOV-TEMPLATE | \`docs/templates/\`, \`changes/\`, \`bootstrap_project.sh\` | bootstrap and scaffolds | reusable neutral template assets |
| Gates and audits | MOD-GOV-GATES | \`scripts/\`, \`docs/governance/\` | gate scripts, CI, audit artifacts | enforcement and evidence support |

## High-level quality goals
- Atomic requirements and bounded change packages.
- Independent audit before release.
- Security-by-default and privacy-by-design.
- Token-efficient AI working context.
- Structural alignment between code, documentation, and contracts.

## Orientation rules
- Detailed implementation guidance belongs in module-local documentation.
- Concrete change execution belongs in \`changes/CHG-*.md\`.
- Release history belongs in \`CHANGELOG.md\`.
- Active package control belongs in \`docs/BACKLOG.md\`.
EOF

cat > "$TARGET_DIR/CHANGELOG.md" <<EOF
# CHANGELOG — $PROJECT_NAME

All notable changes to this project are documented in this file.
\`CHANGELOG.md\` is authoritative release history and is never default DEV or AUDIT execution context.
Only the minimal package-relevant changelog slice may be derived into the active \`changes/CHG-*.md\` when history is materially relevant.
Older release detail must be compacted or archived under \`docs/archive/changelog/\` when repository policy thresholds are exceeded.
\`CHANGELOG.md\` is release-history only and must not be used for planning control, queue semantics, or next-step steering.

## [Unreleased]
### Added
- Initial project created from Enterprise Core Template $TEMPLATE_SOURCE_SHA.

## [0.1.0] - $TODAY_UTC
### Added
- Initial governance baseline from enterprise core template.
- Mandatory PO -> DEV -> AUDIT -> PR -> Merge -> Version -> Clean Desk sequence.
- Independent audit controls and machine-readable gate artifacts.
EOF

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
python_version_choice=auto_latest_stable
node_version_choice=auto_latest_stable
dotnet_version_choice=auto_latest_stable
cc_choice=auto_latest_stable
cxx_choice=auto_latest_stable
python_venv_path=.venv
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
# Fixed policy: Python venv is project-root .venv only.
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
runtime_version_policy=latest_stable_required
env_template_created=true
env_file_created=true
python_bin=${python_bin:-missing}
python_venv_status=$python_venv_status
python_venv_path=.venv
python_venv_root_only=true
node_bin=${node_bin:-missing}
dotnet_bin=${dotnet_bin:-missing}
cc_bin=${cc_bin:-missing}
cxx_bin=${cxx_bin:-missing}
EOF

echo "Project created: $TARGET_DIR"
echo "Next steps:"
echo "1) cd \"$TARGET_DIR\""
echo "2) Review AGENTS.md, DESIGN.md, ARCHITECTURE.md, STACK.md, CONTRIBUTING.md, PROMPTS.md"
echo "3) Keep LASTENHEFT.md orientation-only and docs/BACKLOG.md package metadata current"
echo "4) Use changes/CHG-TEMPLATE.md for your first bounded change brief"
echo "5) Use docs/templates/module-docs/ for module-local documentation scaffolding"
echo "6) Runtime bootstrap already executed (.env + optional .venv + runtime_bootstrap.env)"
echo "7) Tooling decision template is ready (set application_profile first in system_reports/gates/tooling_decision_template.env)"
echo "8) Start your first PO packet with system_reports/gates/po_role_packet_template.env"
echo "9) Run gate chain: ./scripts/gates/dev_gate.sh then ./scripts/gates/audit_gate.sh"
