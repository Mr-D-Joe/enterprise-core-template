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
- Release notes include:
  - scope summary,
  - REQ IDs,
  - audit decision reference,
  - evidence artifact references.

## Ownership
- PO owns business closure and customer-facing release communication.
