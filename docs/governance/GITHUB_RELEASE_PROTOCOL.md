# GitHub Release Protocol (Supportive Template)

## PR requirements
- PR description includes REQ IDs and traceability references.
- PR links to DEV and AUDIT evidence artifacts.

## Merge conditions
- Independent AUDIT decision = APPROVE.
- Mandatory checks green.
- No unresolved blocker findings.

## Merge authority
- DEV prepares implementation PR.
- AUDIT is the mandatory release gatekeeper with decision authority (`APPROVE` or `REJECT`).
- Merge execution is performed by PO identity after `AUDIT=APPROVE`.

## Versioning requirements
- Every merged release candidate receives a version/tag.
- `CHANGELOG.md` must be updated before publishing release.
- Release notes include:
  - scope summary,
  - REQ IDs,
  - audit decision reference,
  - evidence artifact references.

## Evidence truth requirements
- Timestamped gate artifacts are historical records.
- Current authoritative truth is declared only by:
  - `system_reports/gates/current_dev_gate.env`
  - `system_reports/gates/current_audit_gate.env`
- Release summaries and PR text must not rely on undocumented `latest file wins` artifact selection.
- If additional edits occurred after an earlier assessment in the same turn, the release-facing summary must disclose that chronology explicitly.

## Ownership
- PO owns business closure and customer-facing release communication.
- PO restores clean desk after release closure by removing temporary gate artifacts and stale local package residues.
