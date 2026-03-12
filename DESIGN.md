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

## Enforcement expectation
Gate scripts and CI must verify the new structure where feasible:
- canonical root-source ownership,
- duplicate-source absence,
- change-brief presence,
- module-doc scaffold presence,
- legacy-spec deactivation,
- structural-truth alignment,
- canonical policy-source references.
