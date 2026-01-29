# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.2.0] - 2026-01-29

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

