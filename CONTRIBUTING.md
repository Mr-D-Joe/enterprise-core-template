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
8. Clean Desk restoration

No step may be skipped or reordered.
Concurrent/overlapping change packages are forbidden.

## 2. Entry criteria per phase
- Requirement phase (PO):
  - work packet exists with `REQ_IDS`,
  - no active open change package exists from prior execution chain,
  - `docs/BACKLOG.md`, active package metadata, and `LASTENHEFT.md` machine metrics are synchronized and fresh,
  - machine-readable PO role packet exists with required keys,
  - tooling decision packet contains `application_profile` and stack choices,
  - tooling decision packet exists with official-source evidence and verification date,
  - acceptance criteria and test vectors are explicit,
  - security/privacy impact is explicit (data class, secrets, retention, redaction),
  - `LASTENHEFT.md` and `docs/BACKLOG.md` include machine-generated metadata (`generated_at_utc`, `source_commit_sha`).
- DEV phase:
  - changes are traceable to `REQ_IDS`,
  - `scripts/gates/dev_gate.sh` is executed and artifact is stored in `system_reports/gates/dev_gate_*.gate`,
  - tooling decision packet is updated if stack/runtime choices changed,
  - active runtime/compiler versions are documented as latest stable with source/date evidence,
  - deterministic tests executed and linked with per-`REQ_ID` coverage (minimum one positive and one negative test),
  - Python tests in scope are executed as separated runs:
    - `pytest -m "not integration"`
    - `pytest -m integration`,
  - security/privacy checks executed and linked (secret scan, dependency risk check, privacy/logging tests),
  - performance budget evidence is linked (minimum `p95` verdict),
  - runtime bootstrap executed automatically (`.env` and required toolchain setup) with evidence artifact,
  - Python virtual environment is located at project root `.venv` only,
  - package-internal blockers inside approved scope are fixed before DEV handover,
  - required gates are rerun after in-scope fixes.
- AUDIT phase:
  - independent identity and input firewall enforced,
  - explicit PO role packet used (`EXECUTION_MODE=AUDIT`),
  - `scripts/gates/audit_gate.sh` is executed and artifact is stored in `system_reports/gates/audit_gate_*.gate`,
  - findings include severity and evidence,
  - each active `REQ_ID` has executed positive+negative test evidence and package test count is greater than zero,
  - package-level executed positive test count is greater than zero and executed negative test count is greater than zero,
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
- Stale or unsynchronized backlog/package metadata (`docs/BACKLOG.md` or active PO package plan).
- Missing machine-generated metadata (`generated_at_utc`, `source_commit_sha`) in `LASTENHEFT.md` or `docs/BACKLOG.md`.
- Additional active prompt/governance contract files outside canonical set (`PROMPTS.md`, `DESIGN.md`).
- Missing security/privacy traceability or missing security/privacy evidence.
- Missing runtime bootstrap evidence for active `REQ_IDS`.
- Python virtual environment not located at project root `.venv`.
- Customer-facing manual runtime/setup instructions issued by DEV.
- Missing latest-stable runtime/compiler evidence for active scope.
- Missing per-`REQ_ID` test coverage evidence (minimum one executed positive and one executed negative test).
- Missing separated Python test partition evidence (`pytest -m "not integration"` and `pytest -m integration`) when Python tests are in scope.
- Total executed test count for active package equals zero.
- Executed positive test count for active package equals zero.
- Executed negative test count for active package equals zero.
- Missing performance budget evidence (`p95`) for active release scope.
- Python module exceeds 900 LOC without active valid waiver evidence.
- Waiver is missing required keys, expired, or not PO-approved.
- Hardcoded secrets/keys/tokens or unredacted personal data in code, tests, logs, or artifacts.
- Missing ISO security/data control verdicts in audit report.
- Security baseline age exceeds configured maximum age.
- Unresolved blocker/major findings.
- Missing required gate evidence artifacts.
- New package started while previous package is not closed (missing any of: DEV gate, AUDIT decision, PR/Merge, Version).
- Stopping before PR -> Merge -> Version -> Clean Desk although all prior mandatory gates passed.
- DEV or AUDIT release-path evaluation performed only on uncommitted working-tree state.
- Fixed package-internal blocker without rerunning required gates.
- Temporary gate artifacts, duplicate workflow files, or stale local package residues left behind after closure.

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
- Clean Desk restoration requires temporary gate artifacts and stale local package residues to be removed after closure.
- If any mandatory control fails, status is `NOT_READY_FOR_RELEASE`.

## 6. Canonical quality commands (Python scope)
- `pytest -m "not integration"`
- `pytest -m integration`
