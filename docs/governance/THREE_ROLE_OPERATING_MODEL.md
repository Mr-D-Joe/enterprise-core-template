# Three-Role Operating Model (Supportive Template: PO / DEV / AUDIT)

Purpose:
Define mandatory role separation for AI-assisted delivery.

## Role 1: PO (Product Owner / Customer Interface)
Responsibilities:
- Own requirement intake and prioritization.
- Convert changes into requirement packets with REQ IDs.
- Define sprint/iteration package boundaries.
- Approve release scope before DEV starts.

Mandatory outputs:
- Requirement packet with `REQ_IDS=`.
- Sprint/iteration task package.
- Acceptance scope and release intent.

## Role 2: DEV (Implementation)
Responsibilities:
- Implement only approved requirement packet scope.
- Maintain REQ -> Code -> Test traceability.
- Produce dev evidence and commit implementation changes.

Mandatory outputs:
- Updated code and tests.
- DEV gate report.
- Commit reference linked to REQ IDs.

## Role 3: AUDIT (Independent Release Auditor)
Responsibilities:
- Verify independently against normative artifacts.
- Validate traceability, quality gates, and policy compliance.
- Decide APPROVE / REJECT.
- On APPROVE: authorize PO to execute official PR closure path (merge per policy).

Mandatory outputs:
- AUDIT report with findings and decision.
- CAPA references for nonconformities.
- Release recommendation.
- Merge evidence (if APPROVE).

## Separation constraints
- PO, DEV, AUDIT identities must be distinct.
- AUDIT must not consume private DEV rationale.
- Release decision authority is outside DEV.
