# STARTUP CHECKLIST — <PROJECT_NAME>

## Governance baseline
- [ ] Confirm canonical docs: `AGENTS.md`, `DESIGN.md`, `ARCHITECTURE.md`, `STACK.md`, `CONTRIBUTING.md`, `PROMPTS.md`, `LASTENHEFT.md`, `docs/BACKLOG.md`.
- [ ] Confirm governance support docs: `docs/governance/FOUR_EYES_GATING.md`, `CHANGELOG.md`.
- [ ] Confirm no redundant active prompt contracts exist (`QA-Test-Prompt.md`, `docs/PROMPTS.md`, `docs/prompts/*`).
- [ ] Confirm one active package maximum.
- [ ] Confirm `changes/CHG-TEMPLATE.md` and `docs/templates/module-docs/` exist in canonical paths.

## Planning metadata
- [ ] Update `docs/BACKLOG.md` metadata (`generated_at_utc`, `source_commit_sha`, `planning_sync_state`).
- [ ] Update `LASTENHEFT.md` metadata (`generated_at_utc`, `source_commit_sha`).
- [ ] Confirm backlog/package status is current.
- [ ] Confirm `docs/BACKLOG.md` exposes `active_package_id`, `next_package_id`, and `next_after_next_package_id`.
- [ ] Confirm the next executable package is visible when open work exists.
- [ ] Create or update the active `changes/CHG-*.md` before concrete implementation work starts.
- [ ] Confirm exactly one active `changes/CHG-*.md` exists.
- [ ] Confirm active CHG YAML frontmatter is valid and contains required keys.
- [ ] Confirm active CHG `package_id` matches backlog `active_package_id`.
- [ ] Confirm active CHG declares included and excluded source documents.
- [ ] Confirm backlog extraction exists in the active CHG document.
- [ ] Confirm only declared and allowed source documents are loaded into execution context.
- [ ] Confirm `CHANGELOG.md` is release-history only and contains no planning-control structures.

## Test and quality baseline
- [ ] Confirm Python editor/runtime bootstrap files when Python scope is active:
  - `.vscode/settings.json`
  - `pyrightconfig.json`
  - `.venv/bin/pyright`
- [ ] Verify secure runtime defaults (for example CSP not null/disabled).
- [ ] Verify error-contract boundary (no raw internal exception leaks to clients).
- [ ] Verify no silent error masking as success-shaped return values.
- [ ] Verify runtime-contract consistency (port/interpreter/start command/env keys).
- [ ] Verify dependency/supply-chain and vulnerability evidence for release scope.
- [ ] Verify persistence migration strategy for schema-affecting changes.
- [ ] Verify version-source consistency across manifest/build/release.
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
- [ ] Confirm gate and evidence artifacts bind to the active `chg_id`.
- [ ] If DEV gate artifacts exist, confirm `system_reports/gates/current_dev_gate.env` names the authoritative current DEV artifact.
- [ ] If AUDIT gate artifacts exist, confirm `system_reports/gates/current_audit_gate.env` names the authoritative current AUDIT artifact.
- [ ] Confirm no operator workflow relies on undocumented `latest file wins` artifact selection.
- [ ] Confirm final package reporting distinguishes earlier observed state from repaired and final verified state when same-turn edits occurred after an earlier assessment.

## Performance and structure gates
- [ ] Record performance budget evidence with p95 result.
- [ ] Confirm no Python module exceeds 900 LOC without active waiver.
- [ ] Confirm waiver artifacts (if any) are machine-readable, PO-approved, and unexpired.
