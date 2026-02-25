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
  - tooling decision packet contains `application_profile` and stack choices,
  - tooling decision packet exists with official-source evidence and verification date,
  - acceptance criteria and test vectors are explicit,
  - security/privacy impact is explicit (data class, secrets, retention, redaction).
- DEV phase:
  - changes are traceable to `REQ_IDS`,
  - tooling decision packet is updated if stack/runtime choices changed,
  - deterministic tests executed and linked,
  - security/privacy checks executed and linked (secret scan, dependency risk check, privacy/logging tests),
  - runtime bootstrap executed automatically (`.env` and required toolchain setup) with evidence artifact.
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
- Missing tooling decision packet for active scope.
- Missing required tooling decision keys (`application_profile`, `frontend_ui_choice`, `backend_choice`, `data_choice`, `stability_target`).
- Missing official-source or tooling-currency evidence in tooling decision packet.
- Missing security/privacy traceability or missing security/privacy evidence.
- Missing runtime bootstrap evidence for active `REQ_IDS`.
- Customer-facing manual runtime/setup instructions issued by DEV.
- Hardcoded secrets/keys/tokens or unredacted personal data in code, tests, logs, or artifacts.
- Missing ISO security/data control verdicts in audit report.
- Security baseline age exceeds configured maximum age.
- Unresolved blocker/major findings.
- Missing required gate evidence artifacts.

## 4. PR policy
- PR must include:
  - `REQ_IDS`,
  - traceability references,
  - tooling decision packet reference,
  - runtime bootstrap evidence reference,
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
