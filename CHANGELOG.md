# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.3.0] - 2026-01-29

### Added
- **LICENSE** — Added MIT License (Copyright 2026 Joern) to satisfy compliance.
- **DES-GOV-51** — CI Toolchain Completeness.
- **DES-GOV-52** — No undeclared external binaries in tests.
- **DES-GOV-53** — Prohibition of `typing.Any` (strict typing).
- **DES-GOV-54** — Typing stubs must be in `dev-dependencies`.
- **DES-GOV-55** — Test determinism and isolation (no implicit network/browser).

## [1.2.0] - 2026-01-29

### Added
- **DES-GOV-49** — Documentation Synchronicity: Code changes require doc updates.
- **DES-GOV-50** — History Ordering: Standardized internal (chrono) vs global (rev-chrono) sorting.
- **Workflow Step** — Added "Update Documentation" step to CONTRIBUTING.md.
- **System Prompt** — Added GOV-05 (Doc Sync) and GOV-06 (History Order) to `ai_prompt_intro.md`.

### Added
- **Template Placeholder Tables** — All template documents now include a "Placeholders to Replace" reference table for LLM agents.

- **LLM Instructions** — Template documents include inline `> **LLM Instruction:**` markers to guide AI agents during project initialization.
- **GitHub Badges** — README.md now displays template, status, and version badges.

### Changed
- **Consistent Placeholder Format** — Standardized all placeholders to use `{{PLACEHOLDER}}` format across all documents.
- **README.md** — Complete redesign for proper GitHub template presentation with enterprise-ready structure.
- **CONTRIBUTING.md** — Enhanced with tables and clearer AI agent instructions.
- **LASTENHEFT.md** — Added placeholder reference table and LLM instructions.
- **PROMPTS.md** — Standardized placeholders and added reference table.
- **STYLEGUIDE.md** — Standardized placeholders and added reference table.
- **TECHNICAL_SPEC.md** — Standardized placeholders and added reference table.
- **SYSTEM_REPORT.md** — Standardized placeholders and added reference table.
- **CODEOWNERS** — Updated to use `{{GITHUB_USERNAME}}` placeholder format.

### Fixed
- **GitHub Display** — README.md no longer shows `{{PROJECT_NAME}}` placeholder; now displays proper template branding.

## [1.1.0] - 2026-01-28

### Added
- **DES-GOV-48** — Neue Governance-Regel: Funktionale Anforderungen erfordern nun einen "Kontext & User Story"-Abschnitt.
- Kontext-Muster in `TECHNICAL_SPEC.md` zur Erläuterung der Implementierungs-Intention.

### Changed
- `LASTENHEFT.md`: Alle Sektionen verwenden nun konsistent das Kontext & User Story-Muster.
- `DESIGN.md`: Version auf 1.1 aktualisiert mit neuer Governance-Regel.

### Fixed
- Fehlender Kontext-Header in Sektion 4 (Integration & Plattform) von `LASTENHEFT.md`.

## [1.0.0] - Initial Release

### Added
- Initial project structure based on Enterprise Core Template.

