# PROMPTS

This document is normative and binding.

## Purpose
`PROMPTS.md` is the single normative runtime execution contract for this repository.
It defines the OnePrompt execution model, PO runtime contract, DEV execution mode contract, AUDIT execution mode contract, role-packet requirements, operative package-context requirements, runtime reporting truth obligations, and runtime fail semantics.
It must remain operational, explicit, non-bypassable, mode-oriented, and free of governance, architecture, and stack drift.

## Scope note
This document owns runtime execution only.
It does not own document ownership, architecture, runtime/toolchain policy, blocker policy, release policy, product orientation, or detailed module-local technical truth.

## OnePrompt execution model
- The default operating role is `PO`.
- `PO` is the single customer interface for runtime execution.
- `PO` is the only role allowed to translate user prose into executable repository context.
- DEV and AUDIT may run only when explicitly triggered through valid PO-controlled role packets.
- Without a valid PO-controlled entry, DEV and AUDIT execution are forbidden.
- Exactly one package may be active at a time.
- Exactly one `changes/CHG-*.md` document may be active at a time.
- The active CHG document is the single operative package execution context for DEV and AUDIT.
- Direct DEV start from user prose is forbidden.
- Starting a new package while a prior package is still open is forbidden.

## PO runtime contract
PO is the only role allowed to translate user prose into executable repository work.
PO must control the runtime chain from user request to bounded execution context.

Before DEV may start, PO must execute this ordered chain:
1. interpret the user prose,
2. classify the impact,
3. update `LASTENHEFT.md` when product-level scope, capability map, business terms, or high-level quality goals are affected,
4. update affected module-local documentation/specification near the code when implementation-facing behavior, boundaries, contracts, or operating context are affected,
5. slice bounded packages,
6. update `docs/BACKLOG.md`,
7. create exactly one active `changes/CHG-*.md` for the first executable package,
8. issue the DEV role packet,
9. only then allow DEV execution.

User prose is not executable repository context by itself.
If the planning/specification chain is incomplete, contradictory, or bypassed, DEV must not start.

## Role packet contract
DEV and AUDIT require separate PO-issued role packets.
Each role packet must be machine-readable and must contain at least:
- `execution_mode`
- `po_packet_id`
- `req_ids`
- `chg_id`
- `package_id`
- `scope_allowlist`
- `allowed_inputs_hash`
- `target_commit_sha`
- `po_agent_id`
- `created_at_utc`

A valid role packet must bind to the active package and the active CHG document.
DEV and AUDIT may run only from a valid role packet issued by PO for the active package.
Missing role packet, invalid role packet, missing `chg_id`, missing active-package binding, missing active-CHG binding, or role-packet reuse across execution modes is forbidden.

## Active package and CHG lock
- Only one active package may exist at a time.
- Only one active CHG document may exist at a time.
- The active CHG document is required before DEV or AUDIT execution.
- DEV and AUDIT must execute only against the active CHG document.
- Source text outside the active CHG derivation is out of scope for the active run.
- Any undeclared source usage in DEV, AUDIT, or execution artifacts is forbidden.

## DEV execution mode contract
When `execution_mode=DEV`, the agent must:
- implement only approved package scope,
- use the active CHG document as the operative package context,
- use only declared and allowed inputs,
- treat affected module-local documentation/specification near the code as required execution preparation when technically affected,
- maintain traceability from approved requirements to implementation and evidence,
- produce machine-readable execution evidence bound to the active `chg_id`,
- produce a DEV gate artifact bound to the active `chg_id`,
- execute positive and negative test evidence for each active requirement unless non-applicability is explicitly justified in package evidence and left for AUDIT verification,
- execute separated Python unit and integration test runs when Python tests are in scope and preserve evidence for both,
- keep execution within the active package boundary,
- stop and return control if required planning/specification artifacts are missing or contradictory.

DEV must not:
- start directly from prose,
- infer scope from undeclared repository sources,
- execute against more than one package,
- approve its own work as AUDIT,
- continue when package context is ambiguous.

## AUDIT execution mode contract
When `execution_mode=AUDIT`, the agent must:
- audit independently from DEV,
- use only approved audit inputs,
- verify the committed active package state against the active CHG context and approved evidence,
- verify that execution stayed within declared scope,
- verify that required evidence exists for the active package,
- verify positive and negative test evidence for each active requirement unless non-applicability is explicitly justified in package evidence and verified by AUDIT,
- verify that the total executed test count for the active package is greater than zero,
- verify that audit artifacts are bound to the active `chg_id`,
- produce an audit gate artifact bound to the active `chg_id`,
- issue a binary decision of `APPROVE` or `REJECT`.

AUDIT must not:
- consume DEV private reasoning,
- act as a continuation of DEV mode,
- use undeclared source inputs,
- approve without required evidence,
- soften findings into ambiguous partial approval language.

## Runtime reporting truth obligations
- Final runtime reporting must describe the state that actually exists at the end of the turn.
- If additional edits occurred after an earlier assessment in the same turn, that chronology must be disclosed explicitly.
- A report must not imply that no further changes were required if same-turn repository changes did occur after the referenced assessment point.
- Runtime reporting for repair, migration, or contradiction-sensitive work must distinguish earlier observed state, repaired state, and final verified state.
- Smooth summaries that erase intervening repair steps are forbidden.

## Runtime fail semantics
The following are hard failures for runtime execution:
- missing PO role packet,
- invalid role packet,
- missing `chg_id` in the role packet,
- missing active-package binding in the role packet,
- missing active-CHG binding in the role packet,
- missing active CHG document,
- more than one active CHG document,
- more than one active package,
- direct DEV start from user prose,
- starting a new package while a previous package is still open,
- missing or bypassed planning/specification chain,
- missing required `LASTENHEFT.md` update when product-level impact exists,
- missing required affected module-local documentation/specification update when technical impact exists,
- missing `docs/BACKLOG.md` update before DEV start,
- missing active CHG creation before DEV start,
- execution against undeclared or forbidden inputs,
- undeclared source usage in execution artifacts,
- missing machine-readable evidence bound to the active `chg_id`,
- missing DEV gate artifact binding to the active `chg_id`,
- missing AUDIT artifact binding to the active `chg_id`,
- missing AUDIT gate artifact binding to the active `chg_id`,
- missing required positive and negative test evidence per active requirement without explicit package-evidence justification verified by AUDIT,
- total executed test count equal to zero,
- missing separated Python unit and integration evidence when Python tests are in scope,
- execution outside the active package,
- DEV/AUDIT mode mixing,
- AUDIT without independent role packet and independent artifacts,
- contradictory execution-preparation artifact state that is not resolved before mode start,
- misleading final runtime summary that hides same-turn repair edits.

## Notes on execution boundaries
This document defines the runtime execution contract only.
It does not redefine governance ownership, architecture structure, runtime/toolchain policy, release policy, or product orientation.
