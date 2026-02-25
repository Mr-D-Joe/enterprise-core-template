# PROMPTS — Single PO Prompt Contract

This document is normative and binding.

## 1. Single prompt model
- `PROMPTS.md` is the only normative prompt source.
- No separate `DEV_PROMPT.md` or `AUDIT_PROMPT.md` is allowed.
- PO controls execution by issuing a role packet with:
  - `EXECUTION_MODE=DEV` or `EXECUTION_MODE=AUDIT`,
  - `REQ_IDS=req_id_1,req_id_2,...`,
  - scope boundaries and acceptance criteria,
  - deterministic test vectors and evidence paths.

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
3. pass only approved scope and evidence to the active mode;
4. enforce sequence: Requirement -> DEV -> AUDIT -> PR -> Merge -> Version.

## 3. DEV execution mode contract
When `EXECUTION_MODE=DEV`, the agent must:
1. implement only PO-approved scope;
2. maintain REQ -> Design -> Code -> Test traceability;
3. produce DEV evidence on committed state;
4. hand over only machine-readable evidence artifacts.

DEV mode must not:
- self-approve release readiness;
- consume audit findings before DEV gate completion;
- output secrets, keys, tokens, or personal data into chat/logs/artifacts.

In DEV mode the agent must never output secrets, keys, tokens, or personal data into chat, logs, or release artifacts.

## 4. AUDIT execution mode contract
When `EXECUTION_MODE=AUDIT`, the agent must:
1. verify independently against normative docs, committed diff, and test/gate evidence;
2. enforce role separation and audit input firewall;
3. verify ISO-conform security/data controls (classification, secrets, retention/deletion, redaction/logging, encryption, dependency risk);
4. issue findings with severity and decision `APPROVE` or `REJECT`.

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
- Any unresolved security/privacy blocker => `FINAL_STATUS=FAIL`.
- Missing ISO security/data control verdicts => `FINAL_STATUS=FAIL`.
- Any unresolved blocker/major finding => `FINAL_STATUS=FAIL`.

Only a complete Requirement -> DEV -> Independent AUDIT -> PR -> Merge -> Version chain is releasable.
