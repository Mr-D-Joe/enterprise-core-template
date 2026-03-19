# FOUR EYES GATING — <PROJECT_NAME>

## Purpose
This document defines the mandatory four-eyes release control.

## Binding gate chain
1. PO defines and approves requirement packet (`REQ_IDS`).
2. DEV run executes implementation and `scripts/gates/dev_gate.sh`.
3. AUDIT run executes independent validation and `scripts/gates/audit_gate.sh`.
4. Only after `AUDIT` decision `APPROVE`: PR -> Merge -> Version -> Clean Desk.

No step may be skipped, reordered, or merged by DEV self-approval.

## Identity and separation rules
- PO, DEV, and AUDIT must be separate identities.
- DEV must not approve or merge own implementation.
- AUDIT must not use DEV private rationale/chat history.
- Missing role separation evidence is `FINAL_STATUS=FAIL`.

## Required artifacts
- PO role packet: `system_reports/gates/po_role_packet*.env`
- DEV gate artifact: `system_reports/gates/dev_gate_*.gate`
- AUDIT gate artifact: `system_reports/gates/audit_gate_*.gate`
- authoritative DEV gate pointer: `system_reports/gates/current_dev_gate.env`
- authoritative AUDIT gate pointer: `system_reports/gates/current_audit_gate.env`
- Traceability/test evidence linked per active `REQ_ID`

## Artifact truth rule
- Timestamped gate artifacts are historical records.
- Current truth must be read from the authoritative pointer files, not from implicit filename ordering.
- Mixed historical `FAIL` and `PASS` artifacts are allowed only when the authoritative pointer files are present and machine-discernible.

## Hard-fail conditions
- More than one active package.
- Missing role packet keys.
- Missing per-`REQ_ID` positive+negative executed test evidence.
- Total executed tests equals zero.
- Executed positive test count equals zero.
- Executed negative test count equals zero.
- Missing ISO security/data verdicts.
- Any unresolved blocker/major finding.

## PO merge authority
PO executes merge only after independent `AUDIT=APPROVE` and green mandatory checks.
PO closes the package only after versioning and clean-desk restoration are complete.
