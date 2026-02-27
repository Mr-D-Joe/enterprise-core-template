# PROMPTS — Single PO Prompt Contract

This document is normative and binding.

## 1. Single prompt model
- `PROMPTS.md` is the only normative prompt source.
- No separate `DEV_PROMPT.md` or `AUDIT_PROMPT.md` is allowed.
- Only one active change package is allowed at any time.
- PO controls execution by issuing a role packet with:
  - `EXECUTION_MODE=DEV` or `EXECUTION_MODE=AUDIT`,
  - `REQ_IDS=req_id_1,req_id_2,...`,
  - scope boundaries and acceptance criteria,
  - deterministic positive and negative test vectors and evidence paths.

Without a valid PO role packet, DEV/AUDIT execution is forbidden.

### 1.1 Role packet artifact (machine-readable, mandatory)
The PO role packet must be stored as a machine-readable artifact (for example `.gate` key-value file or JSON) and must contain at least:
- `execution_mode`
- `po_packet_id`
- `req_ids`
- `scope_allowlist`
- `allowed_inputs_hash`
- `target_commit_sha`
- `po_agent_id`
- `created_at_utc`

Missing role packet artifact or missing required keys is a hard gate failure.

## 2. PO runtime prompt (customer-facing)
PO is the single customer interface and the only role allowed to trigger DEV and AUDIT runs.

PO must:
1. translate customer request into atomic requirement packet;
2. choose `EXECUTION_MODE` based on project state;
3. ensure no open package exists before starting a new package;
4. ensure tooling decision checkpoint exists before DEV execution;
5. pass only approved scope and evidence to the active mode;
6. keep customer interaction free from manual runtime/toolchain setup requests;
7. enforce sequence: Requirement -> DEV -> AUDIT -> PR -> Merge -> Version.

## 3. DEV execution mode contract
When `EXECUTION_MODE=DEV`, the agent must:
1. run runtime bootstrap protocol before implementation:
   - create `.env` from `.env.template` if `.env` is missing,
   - initialize only runtimes required by active `REQ_IDS` and test vectors,
   - create `.venv` automatically when Python runtime is required and `.venv` is missing,
   - enforce Python venv path at project root `.venv` only,
   - write machine-readable runtime evidence artifact;
2. run tooling decision checkpoint before implementation:
   - create/update `system_reports/gates/tooling_decision_template.env`,
   - select `application_profile` from `DESIGN.md` section 1.1 before selecting tools,
   - decide tools for frontend/UI, backend, data, and mobile (if in scope),
   - decide active runtime/compiler versions (Python/Node/.NET/CC/CXX) for in-scope stack,
   - target latest stable runtime/compiler versions unless PO-approved exception exists,
   - keep production choices on stable/LTS channels unless PO-approved exception exists,
   - verify decisions against official sources within tooling currency window,
   - write machine-readable tooling decision evidence;
3. implement only PO-approved scope;
4. maintain REQ -> Design -> Code -> Test traceability;
5. execute at least one positive and one negative test per active `REQ_ID` and record machine-readable evidence;
6. produce DEV evidence on committed state;
7. hand over only machine-readable evidence artifacts.

DEV mode must not:
- self-approve release readiness;
- consume audit findings before DEV gate completion;
- output secrets, keys, tokens, or personal data into chat/logs/artifacts.
- ask customer to run manual environment/setup commands.
- ask customer to decide framework/toolchain details unless PO explicitly requests options.
- start a second package while the current package is not closed through AUDIT -> PR -> Merge -> Version.

In DEV mode the agent must never output secrets, keys, tokens, or personal data into chat, logs, or release artifacts.

## 4. AUDIT execution mode contract
When `EXECUTION_MODE=AUDIT`, the agent must:
1. verify independently against normative docs, committed diff, and test/gate evidence;
2. enforce role separation and audit input firewall;
3. verify for each active `REQ_ID`: at least one executed positive and one executed negative test with evidence references;
4. verify total executed tests for active package is greater than zero;
5. verify executed positive test count for active package is greater than zero;
6. verify executed negative test count for active package is greater than zero;
7. verify ISO-conform security/data controls (classification, secrets, retention/deletion, redaction/logging, encryption, dependency risk);
8. issue findings with severity and decision `APPROVE` or `REJECT`.

Allowed input set:
- `AGENTS.md`, `DESIGN.md`, `CONTRIBUTING.md`, `PROMPTS.md`, specs;
- committed diff and deterministic test outputs;
- DEV gate artifact outputs.

Forbidden input set:
- DEV private rationale, chain-of-thought, local TODO notes, chat history;
- files not referenced by normative docs or gate artifacts.

## 5. Required gate semantics (no escape path)
- Missing mandatory evidence => `FINAL_STATUS=FAIL`.
- Any broken sequence step => `FINAL_STATUS=FAIL`.
- Any independence violation => `FINAL_STATUS=FAIL`.
- Any mode-mixing or wrong role packet => `FINAL_STATUS=FAIL`.
- Missing/invalid role packet artifact or key mismatch => `FINAL_STATUS=FAIL`.
- Missing runtime bootstrap evidence for active scope => `FINAL_STATUS=FAIL`.
- Python virtual environment path outside project root `.venv` => `FINAL_STATUS=FAIL`.
- Missing tooling decision evidence for active scope => `FINAL_STATUS=FAIL`.
- Missing `application_profile` in tooling decision evidence => `FINAL_STATUS=FAIL`.
- Missing runtime/compiler version evidence for active scope => `FINAL_STATUS=FAIL`.
- Missing per-REQ positive/negative execution evidence => `FINAL_STATUS=FAIL`.
- Total executed tests for active package equals zero => `FINAL_STATUS=FAIL`.
- Executed positive test count for active package equals zero => `FINAL_STATUS=FAIL`.
- Executed negative test count for active package equals zero => `FINAL_STATUS=FAIL`.
- Missing official-source or tooling-currency evidence => `FINAL_STATUS=FAIL`.
- Starting a new package while a previous package is still open => `FINAL_STATUS=FAIL`.
- Any unresolved security/privacy blocker => `FINAL_STATUS=FAIL`.
- Missing ISO security/data control verdicts => `FINAL_STATUS=FAIL`.
- Any unresolved blocker/major finding => `FINAL_STATUS=FAIL`.

Only a complete Requirement -> DEV -> Independent AUDIT -> PR -> Merge -> Version chain is releasable.
