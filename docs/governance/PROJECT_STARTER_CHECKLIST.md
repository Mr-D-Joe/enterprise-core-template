# Project Starter Checklist (5/5 + Independent Audit)

## Governance setup
- [ ] Define normative hierarchy (AGENTS > DESIGN > CONTRIBUTING > PROMPTS > LASTENHEFT > specs).
- [ ] Define REQ-ID namespaces.
- [ ] Define PO/DEV/AUDIT role split.
- [ ] Define release authority and evidence set.

## Specification setup
- [ ] Fill `LASTENHEFT.md` project context.
- [ ] Fill module-level general context in each spec module.
- [ ] Use unified requirement block in all requirements.

## Quality enforcement
- [ ] Add/maintain traceability matrix.
- [ ] Run `scripts/spec_lint.sh --strict`.
- [ ] Run `scripts/audit_readiness_check.sh`.
- [ ] Run `scripts/pipeline_order_check.sh`.

## Independent audit setup
- [ ] Adopt `INDEPENDENT_AUDIT_POLICY.md`.
- [ ] Adopt `THREE_ROLE_OPERATING_MODEL.md`.
- [ ] Adopt `DELIVERY_PIPELINE_PROTOCOL.md`.
- [ ] Establish distinct DEV vs AUDIT identities.
- [ ] Enforce audit input allowlist.
- [ ] Define CAPA workflow for nonconformities.

## GitHub process setup
- [ ] Adopt `GITHUB_RELEASE_PROTOCOL.md`.
- [ ] Require PR traceability fields (REQ IDs, DEV/AUDIT evidence).
- [ ] Require independent AUDIT approval before merge.
- [ ] Require version/tag creation per merged release.

## ISO-aligned evidence setup
- [ ] Maintain `ISO_CONTROL_MATRIX_TEMPLATE.md`.
- [ ] Use `AUDIT_REPORT_TEMPLATE.md` for gate audits.
- [ ] Archive audit evidence per release.
