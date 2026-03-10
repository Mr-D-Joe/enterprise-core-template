# STARTUP CHECKLIST — <PROJECT_NAME>

## Governance baseline
- [ ] Confirm canonical docs: `AGENTS.md`, `DESIGN.md`, `CONTRIBUTING.md`, `PROMPTS.md`, `LASTENHEFT.md`, `docs/BACKLOG.md`.
- [ ] Confirm governance support docs: `docs/governance/FOUR_EYES_GATING.md`, `CHANGELOG.md`.
- [ ] Confirm no redundant active prompt contracts exist (`QA-Test-Prompt.md`, `docs/PROMPTS.md`, `docs/prompts/*`).
- [ ] Confirm one active package maximum.

## Planning metadata
- [ ] Update `docs/BACKLOG.md` metadata (`generated_at_utc`, `source_commit_sha`, `planning_sync_state`).
- [ ] Update `LASTENHEFT.md` metadata (`generated_at_utc`, `source_commit_sha`).
- [ ] Confirm backlog/package status is current.

## Test and quality baseline
- [ ] Run split Python tests (when Python scope is active):
  - `pytest -m "not integration"`
  - `pytest -m integration`
- [ ] Run governance checks:
  - `./scripts/prompt_firewall_check.sh`
  - `./scripts/audit_readiness_check.sh`
  - `./scripts/pipeline_order_check.sh`
- [ ] Run gate scripts:
  - `./scripts/gates/dev_gate.sh`
  - `./scripts/gates/audit_gate.sh`

## Performance and structure gates
- [ ] Record performance budget evidence with p95 result.
- [ ] Confirm no Python module exceeds 900 LOC without active waiver.
- [ ] Confirm waiver artifacts (if any) are machine-readable, PO-approved, and unexpired.
