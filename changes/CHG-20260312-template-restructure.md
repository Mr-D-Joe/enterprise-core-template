# CHG-20260312-template-restructure

Status: Active
Package_ID: TPL-RESTRUCTURE-20260312-01

## Goal
- Refactor the Enterprise Core Template to the new modular, token-efficient, root-delegating governance structure.

## Affected MOD_IDs
- MOD-GOV-ROOT
- MOD-GOV-TEMPLATE
- MOD-GOV-GATES

## Non-goals
- No fake business modules.
- No sample application implementation.
- No relaxation of existing governance controls.

## Contracts affected
- yes: root governance contracts, bootstrap output contracts, gate expectations

## Data model affected
- yes: planning/document metadata and scaffold structure

## Security and privacy impact
- Governance and audit controls remain strict or become stricter.
- No secrets or personal data may be introduced into template artifacts.

## Pass / fail criteria
- Root normative files are responsibility-separated and non-overlapping.
- `DESIGN.md` is reduced to a concise index.
- `ARCHITECTURE.md` and `STACK.md` exist as canonical root files.
- `LASTENHEFT.md` is orientation-only.
- `docs/specs/*.md` are no longer parallel operational specification sources.
- Change brief and module-doc scaffolds exist in canonical paths.
- Bootstrap, CI, and gate checks enforce the new structure where feasible.
- No broken references remain.

## Relevant tests and checks
- `./scripts/prompt_firewall_check.sh`
- `./scripts/audit_readiness_check.sh`
- `./scripts/pipeline_order_check.sh`
- `./scripts/spec_lint.sh --strict`

## Explicitly excluded paths / modules
- No production application modules.
- No external sample project content.
