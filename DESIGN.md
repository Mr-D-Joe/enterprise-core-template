# DESIGN — Governance Index

This document is normative and binding.

## Purpose
`DESIGN.md` is the canonical governance index for this repository.
It defines document ownership, hierarchy, AI-context discipline, and structural-truth rules.
It must remain short, stable, and delegating.

## Normative hierarchy
1. `AGENTS.md`
2. `DESIGN.md`
3. `ARCHITECTURE.md`
4. `STACK.md`
5. `CONTRIBUTING.md`
6. `PROMPTS.md`
7. `LASTENHEFT.md`

Supportive files are non-normative by default:
- `docs/governance/*`
- `docs/templates/*`
- `changes/*`
- `system_reports/*`

Supportive files become binding only when explicitly referenced by canonical normative files.

## Canonical ownership
- `AGENTS.md`
  Role constitution, separation of duties, audit firewall, non-bypass rules.
- `DESIGN.md`
  Governance index, source-of-truth map, structural-truth rule, AI-context rule.
- `ARCHITECTURE.md`
  Modular monolith, module model, layering, boundaries, contracts, security/privacy/observability architecture.
- `STACK.md`
  Technology profiles, runtime/toolchain policy, repository stack defaults, tooling decision policy.
- `CONTRIBUTING.md`
  Delivery sequence, blockers, PR/merge/release workflow, gate expectations.
- `PROMPTS.md`
  Runtime execution contract for PO/DEV/AUDIT only.
- `LASTENHEFT.md`
  Orientation only: project purpose, scope, terms, capability map, quality goals.

No other root file may compete with these responsibilities.

## Canonical paths
- `ARCHITECTURE.md` at repository root.
- `STACK.md` at repository root.
- `changes/` for active change briefs.
- `changes/CHG-TEMPLATE.md` for the reusable change-brief scaffold.
- `docs/modules/` for navigation and module registry.
- `docs/templates/module-docs/` for reusable module-documentation scaffolds.
- Module-local docs directly adjacent to module code.
- `docs/BACKLOG.md` for package and migration backlog control.

Alternative parallel locations for the same artifact type are forbidden.

## Default architecture stance
- Default architecture is a modular monolith.
- Modules are cut along business capabilities, not technical layers alone.
- Code structure and documentation structure must mirror the same capability and `MOD_ID` model.
- Microservices require an ADR with at least two justified architectural drivers.

## Structural-truth rule
The repository must maintain one coherent structure across:
- capabilities,
- `MOD_ID`s,
- code modules,
- module-local documentation,
- contracts,
- change briefs,
- backlog and release metadata.

If code is split into modules, documentation must split along the same boundaries.
If documentation defines a boundary, code must either reflect it or carry an explicit temporary mismatch record with ADR or waiver evidence.
Silent drift between code structure and documentation structure is `FAIL`.

## AI-context discipline
Default coding context is limited to:
- `AGENTS.md`
- `PROMPTS.md`
- `DESIGN.md`
- `ARCHITECTURE.md`
- `STACK.md`
- `CONTRIBUTING.md`
- the active `changes/CHG-*.md`
- affected module-local docs
- directly impacted neighboring modules only if necessary
- relevant ADRs only when actually needed

Not allowed as default coding context:
- full `LASTENHEFT.md` for every task,
- full `docs/` tree,
- full ADR history,
- full changelog history,
- full-repository summaries without concrete need.

Execution context must be derived from exactly one active `changes/CHG-*.md`.
Authoritative source documents remain complete, but DEV and AUDIT must consume the bounded derivation instead of undifferentiated source documents.
Non-extracted source text is out of scope for the active package.

## Derived execution context
- `docs/BACKLOG.md`, `CHANGELOG.md`, `LASTENHEFT.md`, ADRs, and module-local docs are authoritative source documents.
- `changes/CHG-*.md` is the only operative package document for DEV and AUDIT.
- Exactly one `changes/CHG-*.md` with machine-readable `status=ACTIVE` may exist for the active package.
- Every active CHG document must begin with one YAML frontmatter block containing at least:
  - `chg_id`
  - `status`
  - `req_ids`
  - `mod_ids`
  - `included_sources`
  - `excluded_sources`
  - `created_at_utc`
  - `updated_at_utc`
- Allowed CHG status values are exactly:
  - `DRAFT`
  - `ACTIVE`
  - `CLOSED`
  - `ARCHIVED`
- Any missing frontmatter, missing key, invalid status, or more than one active CHG document is `FAIL`.
- The active CHG document must declare every included source document and every excluded source document.
- Every included non-root source document requires an explicit inclusion reason.
- Any source document used by DEV or AUDIT but not declared in the active CHG document is forbidden input and causes `FAIL`.
- All role packets, gate artifacts, and package-level evidence must bind to the active `chg_id`.
- Evidence that does not bind to the active `chg_id` is invalid for release.

## Source inclusion rules
- `docs/BACKLOG.md` is never default execution context.
- Before DEV or AUDIT starts, PO must derive the active package backlog slice into the active CHG document.
- `CHANGELOG.md` is never default execution context.
- Only the minimal relevant changelog slice may be derived into the active CHG document when package history is materially relevant.
- `LASTENHEFT.md` is not default execution context.
- `LASTENHEFT.md` may be included only when the active package changes:
  - scope or non-scope,
  - key business terms,
  - capability/module map,
  - product-level functional intent,
  - high-level quality goals.
- ADRs are excluded by default.
- ADR inclusion is mandatory only when the active package changes or depends on:
  - module boundaries,
  - contract boundary semantics or versions,
  - runtime or stack decisions,
  - persistence boundaries or data ownership,
  - security or compliance boundaries,
  - an ADR-governed decision.
- Only the minimal ADR set directly governing the active package may be included.
- Full backlog, full changelog, full lastenheft, full ADR history, and full docs trees are forbidden default execution context.

## Backlog and changelog separation
- `docs/BACKLOG.md` is the forward-looking planning and execution-control document.
- `CHANGELOG.md` is the backward-looking release-history document.
- `docs/BACKLOG.md` must remain separate from `CHANGELOG.md`.
- A mixed backlog/changelog document is forbidden.
- `docs/BACKLOG.md` must expose next steps in machine-readable form through:
  - `active_package_id`
  - `next_package_id`
  - `next_after_next_package_id`
- If open work exists and `next_package_id` is missing, planning is incomplete and this is `FAIL`.
- If no open work exists:
  - `active_package_id=none`
  - `next_package_id=none`
  - `next_after_next_package_id=none`
- `docs/BACKLOG.md` must contain:
  - a metadata block,
  - an active package board,
  - an ordered pending package queue,
  - a compact closed package ledger.
- Package ordering must not be inferred from prose alone.
- `CHANGELOG.md` must remain release-history only and must not contain planning-control fields or queue semantics, including:
  - `next_package`
  - `next_package_id`
  - `next_after_next_package_id`
  - `pending`
  - `blocked`
  - `owner`
  - `priority`
  - `sequencing rationale`
- Presence of planning-control structures in `CHANGELOG.md` is `FAIL`.

## Root anti-bloat rule
Root files must remain:
- concise,
- delegating,
- globally applicable,
- non-redundant.

Root files must not accumulate:
- module implementation detail,
- task instructions,
- repeated contract detail,
- long narrative history,
- duplicated explanations already owned by another canonical file.

## Legacy structure migration
`docs/specs/*.md` are legacy requirement artifacts.
They must not remain parallel operational specification sources after migration.
Each legacy spec must be:
- migrated into module-local documentation,
- reduced to orientation/index-only status,
- or removed after verified replacement.

## Template constraints
This repository is a template, not a sample business system.
It must not contain fake business modules or fake production capabilities.
Only reusable scaffolds, placeholders, templates, and neutral examples are allowed.

## Compaction policy
- `LASTENHEFT.md` is orientation-only.
- `docs/BACKLOG.md` is an active-package board plus compact ledger.
- `CHANGELOG.md` is a compact release ledger.
- Older detail remains recoverable through Git history, ADRs, release notes, and module-local docs.
- `docs/BACKLOG.md` older completed-package detail must be compacted or moved to `docs/archive/backlog/` when repository policy thresholds are exceeded.
- `CHANGELOG.md` older release detail must be compacted or moved to `docs/archive/changelog/` when repository policy thresholds are exceeded.
- Threshold ownership for compaction must be declared canonically.
- Exceeding compaction thresholds without compaction is `COMPACTION_REQUIRED` or `FAIL`.

## Enforcement expectation
Gate scripts and CI must verify the new structure where feasible:
- canonical root-source ownership,
- duplicate-source absence,
- change-brief presence,
- module-doc scaffold presence,
- legacy-spec deactivation,
- structural-truth alignment,
- canonical policy-source references.
