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
- Must execute runtime bootstrap autonomously (no customer terminal setup required).
- Must execute a tooling decision checkpoint before code changes.

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

## 4.1 Single active change package lock
- Exactly one change package may be active at a time.
- PO must not issue a new DEV or AUDIT role packet while the current package is not closed.
- A package is closed only after Requirement -> DEV evidence -> Independent AUDIT decision -> PR -> Merge -> Version.
- Any overlapping/parallel package initiation is a governance violation and must hard-fail.

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

## 7. Runtime bootstrap autonomy (customer-safe)
- DEV must create `.env` from `.env.template` automatically when missing.
- DEV must prepare only required runtimes based on active `REQ_IDS` and test vectors.
- Python requirements must trigger automatic `.venv` creation when missing.
- Python virtual environment location is fixed to project root `.venv` only.
- Runtime/compiler selections for active scope must target latest stable versions with dated official-source evidence.
- Customer-facing instructions to run setup commands manually are forbidden.
- Missing required toolchains must be reported as explicit blocker evidence with `FINAL_STATUS=FAIL`.

## 8. Tooling decision autonomy (customer-safe)
- DEV must create/update `system_reports/gates/tooling_decision_template.env` before implementation starts.
- DEV must select `application_profile` from `DESIGN.md` before choosing concrete tools.
- The tooling decision must include UI/frontend, backend, data, and mobile decision fields (if mobile scope exists).
- Decision evidence must reference official sources and verification date.
- Tool/version decisions must target stable/LTS releases only (no beta/rc/canary for production scope).
- If official-source or currency evidence is missing, implementation must hard-fail.
- Customer-facing framework/tool selection prompts are forbidden unless PO explicitly requests alternatives.
