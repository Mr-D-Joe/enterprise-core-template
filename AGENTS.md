# AGENTS

This document is normative and binding.

## Purpose
`AGENTS.md` defines the role constitution for PO, DEV, and AUDIT.
It assigns role responsibilities, separation of duties, no-bypass role obligations, a concise audit-input firewall, and the single-active-package role constraint.
It must remain short, role-focused, operationally clear, and free of downstream detail.

## Role model
### PO (Product Owner)
- PO is the single customer-facing role.
- PO is the only role allowed to initiate DEV and AUDIT runs for a package.
- PO is responsible for translating approved work into bounded package execution.
- PO must complete the required planning/specification chain before issuing DEV.
- PO must not initiate a new package while another package is still active.

### DEV (Implementation)
- DEV implements only approved package scope.
- DEV must not start before the PO planning/specification chain is complete.
- DEV must work only within the active package context issued by PO.
- DEV must not approve, release, or audit its own implementation.

### AUDIT (Independent)
- AUDIT performs independent review of the active package.
- AUDIT must remain separate from DEV in identity and judgment.
- AUDIT must reject when required planning/specification artifacts were bypassed before DEV.
- AUDIT must not act as a continuation or proxy of DEV.

## Separation and identity controls
- PO, DEV, and AUDIT must use distinct identities.
- DEV and AUDIT must execute as separate runs with separate artifacts.
- No self-approval is allowed.
- The DEV identity must never issue final audit approval for its own implementation.

## Audit input firewall
AUDIT may use only approved audit inputs such as:
- canonical normative documents,
- the active package context,
- relevant approved module-local documentation/specification,
- committed change evidence,
- deterministic test and gate outputs.

AUDIT must not use:
- DEV private reasoning,
- informal chat rationale,
- undeclared execution inputs,
- undocumented assumptions outside approved artifacts.

## No-bypass role obligations
- No role may bypass the package chain by acting directly from user prose as if it were executable repository context.
- PO must not issue DEV until required planning/specification artifacts are complete.
- DEV must not start from incomplete or bypassed package preparation.
- AUDIT must reject work that entered execution through a bypassed preparation chain.

## Single-active-package obligation
- Only one change package may be active at a time.
- Only one active package may be under DEV or AUDIT execution at a time.
- Overlapping or parallel package initiation is forbidden.
- Role actions that create or continue overlapping active packages are invalid.
