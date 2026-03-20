# DESIGN

This document is normative and binding.

## Purpose
`DESIGN.md` is the canonical governance index for this repository.
It defines document ownership, execution-context rules, reporting truth, artifact truth, planning-to-execution handoff, repository drift handling, and root anti-bloat rules.
It must remain short, stable, delegating, and globally applicable.

## Normative references model
The root canonical documents work as bounded normative owners, not as a license to absorb each other's responsibilities.
`AGENTS.md` remains the role constitution.
`DESIGN.md` remains the governance and ownership index.
Other root canonical documents own their own bounded domains and must not be silently redefined here.
Only canonical owning documents are normative. Other files are non-normative unless explicitly designated by the canonical governance model.

## Canonical ownership and delegation
- `AGENTS.md`: role constitution only.
- `DESIGN.md`: governance index, document ownership, execution-context rules, reporting truth model, artifact truth model, planning-to-execution handoff rule, repository drift rule, and root anti-bloat rule.
- `ARCHITECTURE.md`: architecture model, module model, boundaries, layering, interface principles, temporary mismatches, and code/doc structure correspondence.
- `STACK.md`: runtime, toolchain, typing, editor, and stable-version policy.
- `CONTRIBUTING.md`: entry criteria, exit criteria, blockers, and release expectations.
- `PROMPTS.md`: the only normative runtime execution contract.
- `LASTENHEFT.md`: product and scope orientation only.
- Module-local documentation/specification near the code: active implementation-facing technical truth for module behavior, boundaries, contracts, and operating context.
- `docs/BACKLOG.md`: compact, human-readable package control.
- `CHANGELOG.md`: release history only.
- `changes/`: operative package context.
- `changes/CHG-TEMPLATE.md`: the only canonical change-brief template.
- `changes/CHG-*.md`: the operative package execution context.

No other file may silently compete with these responsibilities.
Document responsibilities must not be merged.

## Canonical active locations
- Root canonical governance files live at repository root.
- `docs/BACKLOG.md` is the active planning and package-control ledger.
- `CHANGELOG.md` is the active release-history ledger.
- `changes/` is the active package-context location.
- `docs/modules/` is navigation only and must not replace module-local technical truth.
- Module-local documentation/specification must live near the code it governs.

Alternative parallel active locations for the same responsibility are forbidden.

## Execution-context rules
- Execution must use bounded derived context rather than undifferentiated source context.
- The active `changes/CHG-*.md` document is the single operative package execution context for DEV and AUDIT.
- Exactly one active CHG document is required for active package execution.
- `docs/BACKLOG.md`, `CHANGELOG.md`, `LASTENHEFT.md`, full ADR history, and the full `docs/` tree are never default execution context.
- Module-local documentation/specification near the code is the active implementation-facing technical truth layer for affected modules.
- Central legacy specs must not outrank active module-local documentation/specification for implementation-facing truth.
- `docs/BACKLOG.md` must remain compact, scan-friendly, and human-readable. It is package control, not CHG-level narrative context.
- Open work in `docs/BACKLOG.md` must be ordered by priority and customer value.
- Closed work in `docs/BACKLOG.md` must be ordered by completion time.
- Detailed operative execution context belongs in `changes/CHG-*.md`, not in backlog rows.
- Non-extracted source text is out of scope for DEV and AUDIT once the active CHG document exists.
- Undeclared source usage in active execution is forbidden.

## Reporting truth model
- Final summaries must describe the state that actually exists at the end of the turn.
- If the final state was reached through additional edits in the same turn, that chronology must be stated explicitly.
- A final summary must not imply that no further changes were required if additional repository changes did occur in the same turn.
- Reporting must distinguish earlier observed state, repaired state, and final verified state when discrepancies or repairs occurred.
- Repair, migration, and governance-hardening summaries must prefer proof over smooth narrative.
- Proof-oriented reporting must include final-state verification such as edited-file re-read where relevant, residue checks for forbidden remnants, and rerun of required checks after the final edit state.
- Smooth summaries that erase intervening repair steps are forbidden.

## Artifact truth model
- Current authoritative operational truth must be machine-discernible.
- Historical artifacts may remain, but they must not be confused with current truth.
- Current state must never depend on operator guesswork, implicit latest-file selection, or ambiguous residue.
- Historical and current artifacts may coexist only when current authoritative truth is explicitly marked.
- Undocumented latest-file-wins behavior is forbidden.

## Planning-to-execution handoff rule
- User prose is not executable repository context by itself.
- Before DEV may start, PO must first synchronize the canonical planning/specification chain:
  - `LASTENHEFT.md` when product-level scope, terms, capability map, or high-level quality goals are affected,
  - affected module-local documentation/specification near the code when implementation-facing behavior, boundaries, contracts, or operating context are affected,
  - `docs/BACKLOG.md` for ordered package control,
  - exactly one active `changes/CHG-*.md` for the first executable package.
- Direct execution from prose without this artifact chain is forbidden.

## Repository drift and cleanup-before-next-package rule
- Contradictory repository state is not a valid execution baseline.
- If repository state conflicts with the canonical model, the conflict must be surfaced explicitly.
- Every surfaced conflict must be classified as either:
  - intended deviation, or
  - unintended drift.
- Intended deviation must be explicitly bounded and explained through canonical ownership.
- Unintended drift must be repaired or isolated before the next package starts.
- Manual edits, partial cleanup, imperfect merges, stale runtime artifacts, stale control artifacts, and mixed old/new schemas must not remain unexplained.

## Root anti-bloat rule
- Root canonical files must stay concise, delegating, globally applicable, and non-redundant.
- Root files must not absorb downstream technical detail that belongs in `ARCHITECTURE.md`, `STACK.md`, `PROMPTS.md`, `CONTRIBUTING.md`, `LASTENHEFT.md`, module-local documentation/specification, `docs/BACKLOG.md`, or `changes/CHG-*.md`.
- If detail is implementation-facing, package-specific, runtime-specific, architecture-specific, or product-specific, it must not be expanded inside `DESIGN.md`.
