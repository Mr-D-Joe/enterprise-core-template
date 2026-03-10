# LASTENHEFT — <PROJECT_NAME>
## Requirements Specification (Master Index)

This document is normative.
Detailed requirements are maintained in modular documents.

Version: 1.0.0
Date: <YYYY-MM-DD>
Status: Active

## Planning metadata (machine-generated, mandatory)
- generated_at_utc=2026-03-10T00:00:00Z
- source_commit_sha=5205b8f7e2fa18ace92529ab8c88eee766d9489a
- metrics_generation_mode=machine_only

## Document hierarchy
1. `AGENTS.md` (normative role and operation model)
2. `DESIGN.md` (normative architecture and governance)
3. `CONTRIBUTING.md` (normative delivery/release workflow)
4. `PROMPTS.md` (normative PO-controlled execution contract)
5. `LASTENHEFT.md` (normative master index)
6. `docs/specs/*.md` (normative modular requirements)
7. `docs/governance/*.md` (supportive templates and evidence aids)

## Modules
| Module | Path | Scope | ID prefix |
|---|---|---|---|
| UI | `docs/specs/ui.md` | frontend behavior | UI-REQ-* |
| Backend | `docs/specs/backend.md` | API and domain services | BE-REQ-* |
| Data | `docs/specs/data.md` | data and persistence | DB-REQ-* |
| NFR | `docs/specs/nfr.md` | quality constraints | NFR-REQ-* |

## Project context
- Project goal:
- Target users:
- Platform target:
- Operating constraints:

## Machine-generated planning metrics (no manual estimates)
- open_requirement_count=auto
- active_package_count=auto
- completed_package_count=auto
- blocked_item_count=auto
- last_release_tag=auto
- perf_budget_p95_status=auto

## Mandatory quality policy
- Requirements must be atomic.
- Every requirement must include requirement-level context.
- Every module must include module-level general context.
- Traceability and independent audit are mandatory for release.
