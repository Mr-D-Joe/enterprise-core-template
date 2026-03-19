# Delivery Pipeline Protocol (Supportive Template)

This protocol is supportive and becomes binding only when referenced by normative control docs.

## Sequence
1. Requirement definition (PO)
- Create/update requirement packet with REQ IDs.
- Sync `docs/BACKLOG.md`, package metadata, and `LASTENHEFT.md` machine metrics.

2. Implementation (DEV)
- Implement exactly the approved requirement scope.
- Commit implementation changes.

3. Development gate (DEV)
- Run quality and traceability checks.
- Execute and record per active REQ: >=1 positive test and >=1 negative test.
- Run separated Python tests when in scope:
  - `pytest -m "not integration"`
  - `pytest -m integration`
- Execute `scripts/gates/dev_gate.sh` and archive timestamped gate artifact.
- Refresh `system_reports/gates/current_dev_gate.env` as the authoritative DEV gate pointer.
- Produce DEV report artifact.

4. Independent audit (AUDIT)
- Validate with approved inputs only.
- Validate per active REQ positive+negative executed tests and package test count > 0.
- Validate performance budget evidence (minimum p95 verdict).
- Execute `scripts/gates/audit_gate.sh` and archive timestamped gate artifact.
- Refresh `system_reports/gates/current_audit_gate.env` as the authoritative AUDIT gate pointer.
- Produce AUDIT report and decision.

5. GitHub integration
- Open/update PR with requirement trace links.
- AUDIT performs final approval decision.

6. Merge and versioning
- If and only if AUDIT decision is APPROVE, PO executes official PR merge path.
- Create release version/tag and release notes.
- Archive evidence set.

7. Clean Desk
- Remove temporary gate artifacts and stale local package residues.
- Confirm no duplicate temporary workflow files remain active.
- Historical timestamped gate artifacts may remain as history.
- Current truth must be taken only from `current_dev_gate.env` and `current_audit_gate.env`, never from undocumented filename ordering.

## Gate rule
No step may be skipped or reordered.

## Required minimum evidence
- Requirement packet
- Per-REQ test execution evidence (positive + negative)
- Split Python test evidence (unit/integration), if Python scope
- Backlog metadata sync evidence
- Performance budget evidence (p95)
- DEV report
- AUDIT report
- authoritative DEV gate pointer
- authoritative AUDIT gate pointer
- PR link
- Merge commit
- Version/tag reference
- Clean-desk restoration evidence
