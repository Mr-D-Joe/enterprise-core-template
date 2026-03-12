# CHANGELOG — <PROJECT_NAME>

All notable changes to this project are documented in this file.

## [Unreleased]
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

## [0.1.0] - <YYYY-MM-DD>
### Added
- Initial governance baseline from enterprise core template.
- Mandatory PO -> DEV -> AUDIT -> PR -> Merge -> Version sequence.
- Independent audit controls and machine-readable gate artifacts.
