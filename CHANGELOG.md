# CHANGELOG — <PROJECT_NAME>

All notable changes to this project are documented in this file.
`CHANGELOG.md` is authoritative release history and is never default DEV or AUDIT execution context.
Only the minimal package-relevant changelog slice may be derived into the active `changes/CHG-*.md` when history is materially relevant.
Older release detail must be compacted or archived under `docs/archive/changelog/` when repository policy thresholds are exceeded.
`CHANGELOG.md` is release-history only and must not be used for planning control, queue semantics, or next-step steering.

## [Unreleased]
### Changed
- Package closure metadata aligned to the released derived-context governance baseline.

## [2.5.1] - 2026-03-12
### Added
- Governance hardening package `GOV-HARDEN-20260312` integrated into normative rules and gate checks.
- `ARCHITECTURE.md` and `STACK.md` introduced as canonical root sources.
- Canonical change-brief and module-documentation scaffolds added in `changes/` and `docs/templates/module-docs/`.

### Changed
- Runtime-default, error-contract, runtime-consistency, dependency/supply-chain, migration, and version-source controls tightened in canonical governance docs.
- `DESIGN.md` reduced to a governance index and `LASTENHEFT.md` reduced to orientation-only overview.
- Bootstrap, startup guidance, README, and governance checks aligned to the new root/module structure.

### Fixed
- `docs/specs/*.md` removed as parallel operational specification sources.
- Derived execution context is now bound to exactly one active `CHG` document with YAML frontmatter, declared sources, and `chg_id`-bound evidence artifacts.

## [0.1.0] - <YYYY-MM-DD>
### Added
- Initial governance baseline from enterprise core template.
- Mandatory PO -> DEV -> AUDIT -> PR -> Merge -> Version sequence.
- Independent audit controls and machine-readable gate artifacts.
