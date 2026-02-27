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
- Execute and record per active REQ: >=1 positive test and >=1 negative test.
- Produce DEV report artifact.

4. Independent audit (AUDIT)
- Validate with approved inputs only.
- Validate per active REQ positive+negative executed tests and package test count > 0.
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
- Per-REQ test execution evidence (positive + negative)
- DEV report
- AUDIT report
- PR link
- Merge commit
- Version/tag reference
