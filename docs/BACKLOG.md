# BACKLOG — <PROJECT_NAME>

Status: Active

## Metadata (machine-generated, mandatory)
- generated_at_utc=2026-03-12T11:59:26Z
- source_commit_sha=cdd149eb43ea95e139561a438274cd9b5b49aa28
- planning_sync_state=active_migration
- active_package_id=TPL-RESTRUCTURE-20260312-01

## Active package board
| package_id | req_ids | status | owner | evidence_paths | updated_at_utc |
|---|---|---|---|---|---|
| TPL-RESTRUCTURE-20260312-01 | TPL-GOV-100,TPL-GOV-101,TPL-GOV-102,TPL-GOV-103,TPL-GOV-104 | active | PO | changes/CHG-20260312-template-restructure.md;system_reports/gates/* | 2026-03-12T11:59:26Z |
| GOV-HARDEN-20260312 | DES-GOV-41,DES-GOV-42,DES-GOV-43,DES-GOV-44,DES-GOV-45,DES-GOV-46,DES-GOV-47 | closed | PO | system_reports/gates/* | 2026-03-12T07:50:21Z |

## Rules
1. Exactly one package may be active at a time.
2. Backlog metadata must be refreshed before each DEV start.
3. Manual estimate fields are forbidden in active backlog state.
4. Every active package row must include evidence paths.
5. `docs/BACKLOG.md` is authoritative portfolio overview and is never default execution context.
6. Before DEV or AUDIT starts, PO must derive the active package backlog slice into the active `changes/CHG-*.md`.
7. Older completed-package detail must be compacted or archived under `docs/archive/backlog/` when repository policy thresholds are exceeded.
