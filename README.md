# Enterprise Core Template

## Purpose
A production-ready, AI-agent-safe enterprise template with modular governance, bounded change execution, and mandatory independent audit.

## Normative document set
1. `AGENTS.md` (role model and mandatory separation controls)
2. `DESIGN.md` (governance index and source-of-truth mapping)
3. `ARCHITECTURE.md` (architecture and module-boundary rules)
4. `STACK.md` (stack/runtime/tooling policy)
5. `CONTRIBUTING.md` (delivery workflow and hard blockers)
6. `PROMPTS.md` (single PO prompt contract with DEV/AUDIT execution modes)
7. `LASTENHEFT.md` (orientation-only project overview)
8. `docs/BACKLOG.md` (compact package control)

Supportive templates/checklists live in `docs/governance/*.md`, `docs/templates/*`, and `changes/*`.
Release history is tracked in `CHANGELOG.md`.

## Non-negotiable principles
- Stable governance layer with one canonical source per topic.
- Modular monolith as default architecture stance.
- Module-local documentation as the primary implementation context.
- Change briefs as the bounded working context for concrete implementation.
- Security-by-default and privacy-by-default controls in every requirement.
- ISO-conform audit with explicit security/data PASS/FAIL verdicts.
- Independent audit required for release.
- Single customer interface via PO prompt control.
- PO -> DEV -> AUDIT role separation.
- Mandatory delivery sequence:
  - Requirement
  - Implementation
  - Audit
  - PR
  - Merge
  - Version

## Quick start
1. Create a new project from this template:
   - `./bootstrap_project.sh [target_parent_dir]`
   - Script asks only for project name.
2. Fill the root governance docs:
   - `AGENTS.md`
   - `DESIGN.md`
   - `ARCHITECTURE.md`
   - `STACK.md`
   - `CONTRIBUTING.md`
   - `PROMPTS.md`
3. Fill `LASTENHEFT.md` as orientation-only overview.
4. Keep `docs/BACKLOG.md` aligned with the active package/control state before each DEV start.
5. Use `changes/CHG-TEMPLATE.md` to create bounded change briefs under `changes/`.
6. Use `docs/templates/module-docs/` only as starter scaffolds; the active technical truth belongs in module-local documentation/specification near the code.
7. Runtime bootstrap runs automatically (`.env`, optional `.venv`, `.vscode/settings.json`, `pyrightconfig.json`, `system_reports/gates/runtime_bootstrap.env`).
8. Tooling decision checkpoint starts with `system_reports/gates/tooling_decision_template.env` (agent-maintained):
   - set `application_profile` first,
   - then set stack/runtime/compiler choices + official source evidence (latest stable only).
9. Maintain traceability matrix in `docs/governance/TRACEABILITY_MATRIX_TEMPLATE.md`.
    - for each active `REQ_ID`: at least one positive and one negative executed test with evidence.
10. Run quality checks:
   - `./scripts/spec_lint.sh --strict`
   - `./scripts/prompt_firewall_check.sh`
   - `./scripts/audit_readiness_check.sh`
   - `./scripts/pipeline_order_check.sh`
11. If Python scope is active, run split tests:
   - `pytest -m "not integration"`
   - `pytest -m integration`
12. Run gate scripts with the active PO role packet:
   - `./scripts/gates/dev_gate.sh`
   - `./scripts/gates/audit_gate.sh`
13. Treat timestamped gate artifacts as history only. Current gate truth is declared by:
   - `system_reports/gates/current_dev_gate.env`
   - `system_reports/gates/current_audit_gate.env`
14. Final repair/migration summaries must disclose same-turn additional edits and final-state rerun evidence when earlier assessments were corrected later in the turn.
