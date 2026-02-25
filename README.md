# LLM Spec Framework V2 (Best-of 5/5)

## Purpose
A production-ready, AI-agent-compatible specification framework with mandatory independent audit.

## Normative document set
1. `AGENTS.md` (role model and mandatory separation controls)
2. `DESIGN.md` (architecture and governance controls)
3. `CONTRIBUTING.md` (delivery workflow and hard blockers)
4. `PROMPTS.md` (single PO prompt contract with DEV/AUDIT execution modes)
5. `LASTENHEFT.md` (master index and project context)
6. `docs/specs/*.md` (modular requirements)

Supportive templates/checklists live in `docs/governance/*.md`.

## Non-negotiable principles
- Atomic requirements.
- Requirement-level context in every requirement.
- Module-level general context for overall understanding.
- Stable governance layer (design/rules/process first).
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
2. Fill `DESIGN.md`.
3. Fill `AGENTS.md` and `CONTRIBUTING.md`.
4. Fill `LASTENHEFT.md`.
5. Author requirements in `docs/specs/*.md`.
6. Maintain traceability matrix in `docs/governance/TRACEABILITY_MATRIX_TEMPLATE.md`.
7. Runtime bootstrap runs automatically (`.env`, optional `.venv`, `system_reports/gates/runtime_bootstrap.env`).
8. Tooling decision checkpoint starts with `system_reports/gates/tooling_decision_template.env` (agent-maintained):
   - set `application_profile` first,
   - then set stack choices + official source evidence.
9. Run quality checks:
   - `./scripts/spec_lint.sh --strict`
   - `./scripts/prompt_firewall_check.sh`
   - `./scripts/audit_readiness_check.sh`
   - `./scripts/pipeline_order_check.sh`
