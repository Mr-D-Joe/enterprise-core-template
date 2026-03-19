# AGENTS — Role Constitution

This document is normative and binding.

## 1. Mandatory role model

### PO (Product Owner) — primary control strand
- Owns customer interface, requirement intake, prioritization, and scope approval.
- Creates approved work packets with `REQ_IDS`, acceptance criteria, and release intent.
- Is the only role allowed to initiate DEV and AUDIT runs for a change package.
- Is the default customer-facing operating role unless a valid PO role packet triggers DEV or AUDIT mode.
- Must autonomously orchestrate Requirement -> DEV -> AUDIT -> PR -> Merge -> Version -> Clean Desk when execution is permitted.

### DEV (Implementation) — execution strand
- Implements only approved PO scope.
- Maintains REQ -> Design -> Code -> Test traceability.
- Produces implementation evidence and DEV gate artifacts.
- Must not approve, release, or merge own implementation.
- Must execute runtime bootstrap autonomously (no customer terminal setup required).
- Must execute a tooling decision checkpoint before code changes.
- Must close package-internal defects within approved scope before handing package back as complete.
- Must not leave in-scope security/runtime/error-contract/migration/version-drift defects unresolved.

### AUDIT (Independent) — execution strand
- Performs independent audit against normative docs and approved evidence.
- Produces findings, severities, and decision (`APPROVE` or `REJECT`).
- Must not reuse DEV private rationale/chat history or act as DEV proxy.
- Must explicitly verify secure runtime defaults, error-contract boundary, runtime-contract consistency, dependency/supply-chain risk evidence, migration strategy, and version-source consistency.

## 2. Mandatory separation and identity controls
- PO, DEV, and AUDIT must use distinct identities (`AGENT_ID` and runtime evidence).
- DEV and AUDIT outputs must be generated in separate runs and separate artifacts.
- No self-approval: the DEV identity must never produce final audit approval for its own code.

## 3. Audit input firewall
- Allowed audit inputs:
  - normative docs (`AGENTS.md`, `DESIGN.md`, `ARCHITECTURE.md`, `STACK.md`, `CONTRIBUTING.md`, `PROMPTS.md`, `LASTENHEFT.md`),
  - active change brief and relevant module-local docs,
  - committed change set/diff,
  - deterministic test and gate outputs.
- Forbidden audit inputs:
  - DEV chain-of-thought, private rationale, and ad-hoc solution narrative.
  - undocumented assumptions not present in normative docs or committed artifacts.

## 4. Non-bypass clauses (no escape path)
- Every change must start with approved requirement packet containing `REQ_IDS`.
- Mandatory sequence: Requirement -> Development -> Independent Audit -> PR -> Merge -> Version -> Clean Desk.
- Missing traceability, missing independent audit, or failed audit means `FINAL_STATUS=FAIL`.
- Any violation of this document results in `NOT_READY_FOR_RELEASE`.

## 4.1 Single active change package lock
- Exactly one change package may be active at a time.
- PO must not issue a new DEV or AUDIT role packet while the current package is not closed.
- A package is closed only after Requirement -> DEV evidence -> Independent AUDIT decision -> PR -> Merge -> Version -> Clean Desk.
- Any overlapping/parallel package initiation is a governance violation and must hard-fail.
- Exactly one `changes/CHG-*.md` with machine-readable `status=ACTIVE` may exist for the active package.
- Missing active CHG document, more than one active CHG document, or invalid active-CHG status is a governance violation and must hard-fail.

## 4.2 Per-Requirement test execution minimum
- AUDIT must validate executed test evidence for every active `REQ_ID`.
- Minimum coverage per active `REQ_ID` is:
  - at least one executed positive test (`PASS`) and
  - at least one executed negative test (`PASS`).
- Total executed test count for the active package must be greater than zero.
- Package-level executed positive test count must be greater than zero.
- Package-level executed negative test count must be greater than zero.
- `positive_count=0` is always `FAIL`, even if negative tests exist.
- `negative_count=0` is always `FAIL`, even if positive tests exist.
- Missing per-`REQ_ID` positive/negative execution evidence or total executed test count of zero is a governance violation and must hard-fail.

## 5. Prompt and runtime separation controls
- `PROMPTS.md` is the only normative prompt source.
- `DESIGN.md` is the normative governance index and document-hierarchy source.
- `ARCHITECTURE.md` is the only normative source for architecture and module-boundary rules.
- `STACK.md` is the only normative source for stack/runtime/tooling policy.
- `PROMPTS.md` is runtime-only and must not redefine architecture, stack, or governance ownership from the canonical root sources.
- PO must issue explicit role packets (`EXECUTION_MODE=DEV` or `EXECUTION_MODE=AUDIT`).
- PO role packet must exist as a machine-readable artifact with required keys:
  - `execution_mode`, `po_packet_id`, `req_ids`, `scope_allowlist`,
  - `allowed_inputs_hash`, `target_commit_sha`, `po_agent_id`, `created_at_utc`.
- DEV and AUDIT must execute in separate runs with separate role packets.
- PO must derive package execution context into the active `changes/CHG-*.md` before DEV or AUDIT starts.
- PO must keep next executable work visible in `docs/BACKLOG.md`.
- PO must maintain machine-readable backlog control metadata:
  - `active_package_id`
  - `next_package_id`
  - `next_after_next_package_id`
- PO must not use `CHANGELOG.md` as planning or sequencing control.
- DEV and AUDIT must use the active CHG document plus declared allowed documents only.
- The active CHG document must declare:
  - included source documents,
  - excluded source documents,
  - inclusion reason for every included non-root source document.
- Any source document used in DEV or AUDIT but not declared in the active CHG document is forbidden input and must hard-fail.
- All execution artifacts must bind to the active `chg_id`.
- AUDIT input must be limited to committed artifacts and approved evidence files.
- DEV must not receive audit findings or audit rationale before DEV gate completion.
- Any mode-mixing, cross-role leakage, or non-PO-triggered execution is an independence violation and must hard-fail.

## 5.1 Reporting truth obligations
- PO, DEV, and AUDIT must report the end-of-turn repository state exactly as it exists after the final edit and verification step.
- If additional edits were required after an earlier assessment in the same turn, the final summary must disclose that chronology explicitly.
- `No additional changes were required` is forbidden after same-turn repository edits beyond the referenced assessment point.
- Contradiction repair, migration, and governance-hardening summaries must include:
  - changed files,
  - final residue-check result,
  - rerun checks from the final edit state.
- Smooth summaries that erase intervening repair steps are forbidden.
- For discrepancy-sensitive work, accuracy classification may use only:
  - `ACCURATE`
  - `PARTIALLY_ACCURATE`
  - `MISLEADING`
  - `FALSE`
- Historical gate or audit artifacts must not be described as current truth when an authoritative pointer names a different current artifact.

## 6. Security and privacy non-negotiables
- No secret or personal data exfiltration into prompts, chat output, logs, or release artifacts.
- No hardcoded credentials, API keys, tokens, or private certificates in code or tests.
- Every change touching data must include explicit data classification, retention, and redaction behavior.
- DEV must implement least-privilege and data-minimization behavior by default.
- AUDIT must reject releases with missing security/privacy evidence or unresolved high-risk findings.
- AUDIT must execute the ISO-conform security/data checklist defined in `docs/governance/INDEPENDENT_AUDIT_POLICY.md`.
- AUDIT decision is invalid if `docs/governance/AUDIT_REPORT_TEMPLATE.md` security/data control section is incomplete.
- Unsichere Runtime-Defaults, Exception-Leaks an Clients, oder stilles Error-Masking ohne genehmigten Waiver sind explizit verboten.

## 7. Runtime bootstrap autonomy (customer-safe)
- DEV must create `.env` from `.env.template` automatically when missing.
- DEV must prepare only required runtimes based on active `REQ_IDS` and test vectors.
- Python requirements must trigger automatic `.venv` creation when missing.
- Python virtual environment location is fixed to project root `.venv` only.
- Python scope must create `.vscode/settings.json` with root-only `.venv` interpreter binding.
- Python scope must create `pyrightconfig.json` with strict type-checking defaults bound to root `.venv`.
- Python scope must install `pyright` into project-root `.venv`.
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

## 9. Planning, performance, and waiver controls
- `docs/BACKLOG.md` and active package plan metadata must be synchronized before DEV start.
- `LASTENHEFT.md` and `docs/BACKLOG.md` metrics must be machine-generated only and include:
  - `generated_at_utc`
  - `source_commit_sha`
- `LASTENHEFT.md` is orientation-only and must not become an operational implementation container.
- Active code-change work must use `changes/CHG-*.md` as bounded task context.
- `docs/BACKLOG.md`, `CHANGELOG.md`, and `LASTENHEFT.md` are never default execution context.
- `docs/BACKLOG.md` must show the active package and the next executable package whenever open work exists.
- `CHANGELOG.md` is release-history only and must not be used for planning control.
- Only package-relevant slices derived into the active CHG document may enter DEV or AUDIT execution context.
- `LASTENHEFT.md` may enter active execution context only when the package changes scope/non-scope, key terms, capability map, product-level functional intent, or high-level quality goals.
- ADRs are excluded from default execution context unless the active package changes or depends on an ADR-governed boundary or decision.
- Module-local docs must be adjacent to module code and follow the declared `MOD_ID` boundary model.
- Redundant active governance/prompt documents are forbidden; one active leading document per topic only.
- Python testing in scope must be partitioned and evidenced separately:
  - unit: `pytest -m "not integration"`
  - integration: `pytest -m integration`
- Python typing baseline in scope must include:
  - `.vscode/settings.json`
  - `pyrightconfig.json`
  - installed `.venv/bin/pyright`
- Performance evidence for active scope must include explicit budget result (minimum `p95`) before release.
- Python module size limit above 900 LOC is release-blocking unless an active machine-readable waiver exists.
- Waivers must be machine-readable, PO-approved, scope-bound, and time-bounded with explicit expiry.
