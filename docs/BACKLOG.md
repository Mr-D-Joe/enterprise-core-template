# BACKLOG — <PROJECT_NAME>

Status: Closed

## Metadata (machine-generated, mandatory)
- generated_at_utc=2026-03-12T18:55:15Z
- source_commit_sha=9f26c9170697ae0f0ac8d4289e2ec1af3a756f55
- planning_sync_state=clean_desk
- active_package_id=none
- next_package_id=none
- next_after_next_package_id=none

## Active package board
| package_id | req_ids | status | owner | evidence_paths | updated_at_utc |
|---|---|---|---|---|---|
| none | none | archived | PO | none | 2026-03-12T18:55:15Z |

## Ordered pending package queue
| sequence | package_id | req_ids | status | owner | evidence_paths | updated_at_utc |
|---|---|---|---|---|---|
| TPL-RESTRUCTURE-20260312-01 | TPL-GOV-100,TPL-GOV-101,TPL-GOV-102,TPL-GOV-103,TPL-GOV-104 | closed | PO | changes/CHG-20260312-template-restructure.md;system_reports/gates/* | 2026-03-12T18:55:15Z |
| none | none | archived | PO | none | 2026-03-12T18:55:15Z |

## Compact closed package ledger
| package_id | req_ids | status | owner | evidence_paths | updated_at_utc |
|---|---|---|---|---|---|
| TPL-RESTRUCTURE-20260312-01 | TPL-GOV-100,TPL-GOV-101,TPL-GOV-102,TPL-GOV-103,TPL-GOV-104 | closed | PO | changes/CHG-20260312-template-restructure.md;system_reports/gates/* | 2026-03-12T18:55:15Z |
| GOV-HARDEN-20260312 | DES-GOV-41,DES-GOV-42,DES-GOV-43,DES-GOV-44,DES-GOV-45,DES-GOV-46,DES-GOV-47 | closed | PO | system_reports/gates/* | 2026-03-12T07:50:21Z |

## Rules
1. Exactly one package may be active at a time.
2. Backlog metadata must be refreshed before each DEV start.
3. Manual estimate fields are forbidden in active backlog state.
4. Every active package row must include evidence paths.
5. `docs/BACKLOG.md` is authoritative portfolio overview and is never default execution context.
6. Before DEV or AUDIT starts, PO must derive the active package backlog slice into the active `changes/CHG-*.md`.
7. Older completed-package detail must be compacted or archived under `docs/archive/backlog/` when repository policy thresholds are exceeded.
8. Backlog must expose `active_package_id`, `next_package_id`, and `next_after_next_package_id`.
9. If open work exists, the next executable package must be visible in machine-readable metadata and queue order.
