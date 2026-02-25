# AGENTS — Role Constitution

This document is normative and binding.

## 1. Mandatory role model

### PO (Product Owner) — primary control strand
- Owns customer interface, requirement intake, prioritization, and scope approval.
- Creates approved work packets with `REQ_IDS`, acceptance criteria, and release intent.
- Is the only role allowed to initiate DEV and AUDIT runs for a change package.

### DEV (Implementation) — execution strand
- Implements only approved PO scope.
- Maintains REQ -> Design -> Code -> Test traceability.
- Produces implementation evidence and DEV gate artifacts.
- Must not approve, release, or merge own implementation.

### AUDIT (Independent) — execution strand
- Performs independent audit against normative docs and approved evidence.
- Produces findings, severities, and decision (`APPROVE` or `REJECT`).
- Must not reuse DEV private rationale/chat history or act as DEV proxy.

## 2. Mandatory separation and identity controls
- PO, DEV, and AUDIT must use distinct identities (`AGENT_ID` and runtime evidence).
- DEV and AUDIT outputs must be generated in separate runs and separate artifacts.
- No self-approval: the DEV identity must never produce final audit approval for its own code.

## 3. Audit input firewall
- Allowed audit inputs:
  - normative docs (`AGENTS.md`, `DESIGN.md`, `CONTRIBUTING.md`, `PROMPTS.md`, specs),
  - committed change set/diff,
  - deterministic test and gate outputs.
- Forbidden audit inputs:
  - DEV chain-of-thought, private rationale, and ad-hoc solution narrative.
  - undocumented assumptions not present in normative docs or committed artifacts.

## 4. Non-bypass clauses (no escape path)
- Every change must start with approved requirement packet containing `REQ_IDS`.
- Mandatory sequence: Requirement -> Development -> Independent Audit -> PR -> Merge -> Version.
- Missing traceability, missing independent audit, or failed audit means `FINAL_STATUS=FAIL`.
- Any violation of this document results in `NOT_READY_FOR_RELEASE`.

## 5. Prompt and runtime separation controls
- `PROMPTS.md` is the only normative prompt source.
- PO must issue explicit role packets (`EXECUTION_MODE=DEV` or `EXECUTION_MODE=AUDIT`).
- PO role packet must exist as a machine-readable artifact with required keys:
  - `execution_mode`, `po_packet_id`, `req_ids`, `scope_allowlist`,
  - `allowed_inputs_hash`, `target_commit_sha`, `po_agent_id`, `created_at_utc`.
- DEV and AUDIT must execute in separate runs with separate role packets.
- AUDIT input must be limited to committed artifacts and approved evidence files.
- DEV must not receive audit findings or audit rationale before DEV gate completion.
- Any mode-mixing, cross-role leakage, or non-PO-triggered execution is an independence violation and must hard-fail.

## 6. Security and privacy non-negotiables
- No secret or personal data exfiltration into prompts, chat output, logs, or release artifacts.
- No hardcoded credentials, API keys, tokens, or private certificates in code or tests.
- Every change touching data must include explicit data classification, retention, and redaction behavior.
- DEV must implement least-privilege and data-minimization behavior by default.
- AUDIT must reject releases with missing security/privacy evidence or unresolved high-risk findings.
- AUDIT must execute the ISO-conform security/data checklist defined in `docs/governance/INDEPENDENT_AUDIT_POLICY.md`.
- AUDIT decision is invalid if `docs/governance/AUDIT_REPORT_TEMPLATE.md` security/data control section is incomplete.
