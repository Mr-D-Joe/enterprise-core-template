# Delivery Pipeline Protocol (Supportive Template)

This protocol is supportive and becomes binding only when referenced by normative control docs.

## Sequence
1. Requirement definition (PO)
- Create/update requirement packet with REQ IDs.

2. Implementation (DEV)
- Implement exactly the approved requirement scope.
- Commit implementation changes.

3. Development gate (DEV)
- Run quality and traceability checks.
- Produce DEV report artifact.

4. Independent audit (AUDIT)
- Validate with approved inputs only.
- Produce AUDIT report and decision.

5. GitHub integration
- Open/update PR with requirement trace links.
- AUDIT performs final approval decision.

6. Merge and versioning
- If and only if AUDIT decision is APPROVE, PO executes official PR merge path.
- Create release version/tag and release notes.
- Archive evidence set.

## Gate rule
No step may be skipped or reordered.

## Required minimum evidence
- Requirement packet
- DEV report
- AUDIT report
- PR link
- Merge commit
- Version/tag reference
