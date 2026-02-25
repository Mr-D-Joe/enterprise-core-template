# CONTRIBUTING — Delivery and Release Rules

This document is normative and binding.

## 1. Mandatory delivery sequence (no skip, no reorder)
1. Requirement definition and approval (PO)
2. Implementation on approved scope (DEV)
3. DEV gate evidence (DEV)
4. Independent Audit gate (AUDIT)
5. Pull request update/check
6. Merge authorization (PO based on AUDIT APPROVE)
7. Version/tag and release note

No step may be skipped or reordered.

## 2. Entry criteria per phase
- Requirement phase (PO):
  - work packet exists with `REQ_IDS`,
  - machine-readable PO role packet exists with required keys,
  - acceptance criteria and test vectors are explicit,
  - security/privacy impact is explicit (data class, secrets, retention, redaction).
- DEV phase:
  - changes are traceable to `REQ_IDS`,
  - deterministic tests executed and linked,
  - security/privacy checks executed and linked (secret scan, dependency risk check, privacy/logging tests).
- AUDIT phase:
  - independent identity and input firewall enforced,
  - explicit PO role packet used (`EXECUTION_MODE=AUDIT`),
  - findings include severity and evidence,
  - ISO-conform security/data control evidence is validated before decision,
  - security baseline freshness check is validated before decision.

## 3. Hard blockers (automatic FAIL)
- Missing `REQ_IDS` trace chain (REQ -> Design -> Code -> Test -> Gate).
- DEV identity attempts own audit approval or release approval.
- Audit not independent or based on forbidden DEV-private context.
- Missing or wrong `EXECUTION_MODE` role packet for active phase.
- Missing required role packet keys (`execution_mode`, `po_packet_id`, `req_ids`, `scope_allowlist`, `allowed_inputs_hash`, `target_commit_sha`, `po_agent_id`, `created_at_utc`).
- Missing security/privacy traceability or missing security/privacy evidence.
- Hardcoded secrets/keys/tokens or unredacted personal data in code, tests, logs, or artifacts.
- Missing ISO security/data control verdicts in audit report.
- Security baseline age exceeds configured maximum age.
- Unresolved blocker/major findings.
- Missing required gate evidence artifacts.

## 4. PR policy
- PR must include:
  - `REQ_IDS`,
  - traceability references,
  - DEV gate artifact reference,
  - AUDIT gate artifact reference,
  - explicit audit decision,
  - security/privacy evidence references,
  - ISO security/data control verdict references.

## 5. Merge and release policy
- Merge requires `AUDIT=APPROVE` and all mandatory checks green.
- Merge authority remains with PO governance decision.
- Release/versioning requires final release-readiness evidence.
- If any mandatory control fails, status is `NOT_READY_FOR_RELEASE`.
