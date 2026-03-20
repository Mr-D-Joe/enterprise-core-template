# CONTRIBUTING

This document is normative and binding.

## Purpose
`CONTRIBUTING.md` defines delivery readiness, hard blockers, enforcement-level phase expectations, and concise PR/merge/release expectations.
It is the enforcement layer for what must be true before work proceeds.
It must remain concise, enforceable, review-friendly, and separate from governance ownership and runtime procedure detail.

## Mandatory delivery sequence
The delivery sequence is enforced as:
1. ready state established,
2. DEV execution,
3. DEV-to-AUDIT handoff,
4. AUDIT decision,
5. pull request review/update,
6. merge,
7. versioning and release completion.

No step may be skipped or reordered.
Concurrent or overlapping active packages are forbidden.

## Definition of ready
Work is ready for DEV only when all required planning and specification artifacts are synchronized and the package is bounded.
Ready means:
- the intended work has been translated out of user prose into repository artifacts,
- required planning/specification artifacts are current,
- bounded package slicing is complete,
- exactly one active CHG exists for the package to be executed,
- required role-packet and runtime prerequisites defined elsewhere already exist,
- the repository is not in unresolved drift or contradictory baseline state.

## DEV entry criteria
DEV must not start unless all of the following are true:
- planning/specification artifacts required for the package have been synchronized,
- bounded package slicing is complete,
- exactly one active `changes/CHG-*.md` exists,
- the active package is unambiguous,
- required runtime-entry artifacts defined by the runtime contract already exist,
- execution input is bounded to declared in-scope context,
- unresolved drift or contradictory baseline state is not being carried forward.

## DEV-to-AUDIT handoff expectations
DEV may hand off to AUDIT only when:
- the active package has the runtime-defined evidence required for handoff,
- required active-context bindings are present,
- the package state is no longer partial, contradictory, or ambiguous.

AUDIT must not begin from incomplete or contradictory package state.

## Hard blockers
The following are hard blockers and must stop progression:
- acting directly from prose without required artifact updates,
- missing `LASTENHEFT.md` update when product or capability scope is affected,
- missing affected module-local documentation/specification update when implementation-facing behavior, boundaries, contracts, or operating context are affected,
- unordered, freeform, or unsynchronized planning state,
- missing active CHG,
- more than one active CHG,
- missing required runtime-entry prerequisites defined elsewhere,
- unresolved repository drift,
- contradictory baseline or current-state artifact truth,
- undeclared or out-of-scope execution input where bounded execution context is required,
- starting a new package while a previous package is still open.

## Pull request expectations
A pull request must not proceed unless the active package is bounded, reviewable, and free of unresolved blockers.
Required DEV and AUDIT enforcement state must exist at the appropriate step.

## Merge expectations
Merge must not proceed unless the active package completed required enforcement steps and no hard blocker remains open.

## Release expectations
Release/version progression must not proceed unless current package truth is clear, required decision state exists, and no contradictory or unresolved blocker state is being carried forward.
