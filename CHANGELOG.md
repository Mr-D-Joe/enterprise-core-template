# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- Documented frontend ESLint config guidance (avoid `@typescript-eslint/eslint-plugin` hangs; use `tsc` for unused/undef checks).
- Added recommended API interface consolidation and type-guard practices.
- Governance: Allowed task bundling within a single requirement when per-task verification is preserved.
- Governance: Standardized internal history ordering to "newest first" and aligned DES-GOV-50, lint spec, and release checklist; version headers synced to 1.10.0.
- Governance: Clarified atomic requirements and allowed multi-requirement implementation packages with explicit mapping and context.

## [1.9.8] - 2026-01-30

### Changed
- **TEMPLATE_USAGE_GUIDE.md** — Beginner-friendly rewrite and “idea only” prompt example.
- **Version alignment** — Core template docs aligned to 1.9.8.

## [1.9.7] - 2026-01-30

### Added
- **Makefile** — `make validate` wrapper for governance and consistency checks.
- **TEMPLATE_USAGE_GUIDE.md** — Quickstart derived-project example.

### Changed
- **Version alignment** — Core template docs aligned to 1.9.7.

## [1.9.6] - 2026-01-30

### Added
- **PROMPTS.md** — Low-spec system prompt snippet.
- **TEMPLATE_USAGE_GUIDE.md** — LLM capability checklist.

### Changed
- **.github/workflows/governance-check.yml** — Shellcheck now required (hard gate).
- **Version alignment** — Core template docs aligned to 1.9.6.

## [1.9.5] - 2026-01-30

### Added
- **ai_prompt_intro.md** — Low-spec mandatory profile for constrained models.

### Changed
- **.github/workflows/governance-check.yml** — Shellcheck best-effort with skip notice; added consistency check in CI.
- **docs/RELEASE_CHECKLIST.md** — Shellcheck parity added.
- **scaffold_structure.sh** — Platform flag now mandatory (no default behavior).
- **TEMPLATE_USAGE_GUIDE.md** — Scaffold flag marked mandatory.
- **Version alignment** — Core template docs aligned to 1.9.5.

## [1.9.4] - 2026-01-30

### Added
- **CI Shellcheck** — Script linting for `scripts/*.sh` in governance workflow.

### Changed
- **docs/RELEASE_CHECKLIST.md** — Added consistency script check.
- **TEMPLATE_USAGE_GUIDE.md** — Platform-specific scaffold examples.
- **PROMPTS.md** — Low-spec LLM profile for deterministic outputs.
- **.github/workflows/governance-check.yml** — Runs consistency check in CI.
- **Version alignment** — Core template docs aligned to 1.9.4.

## [1.9.3] - 2026-01-30

### Added
- **scripts/consistency_check.sh** — Ensures core template docs share identical version/date headers.

### Changed
- **TEMPLATE_USAGE_GUIDE.md** — Consistency checklist now includes script run.
- **Version alignment** — Core template docs aligned to 1.9.3.

## [1.9.2] - 2026-01-30

### Changed
- **Version alignment** — Core template docs aligned to 1.9.2.
- **docs/RELEASE_CHECKLIST.md** — Added governance lint script check.
- **scaffold_structure.sh** — Platform-aware scaffolding to avoid unnecessary directories.
- **TEMPLATE_USAGE_GUIDE.md** — Updated scaffolding instructions and added consistency checklist.
- **.github/workflows/governance-check.yml** — Explicit bash shell for lint step.

## [1.9.1] - 2026-01-30

### Added
- **scripts/governance_lint.sh** — Deterministic governance lint script wired into CI.
- **ai_service/requirements-dev.txt** — Placeholder for typing/test dependencies.

### Changed
- **docs/GOVERNANCE_LINT_SPEC.md** — Clarified derived-project applicability; aligned artifact headings and release gate map.
- **docs/artifact_index.md** — Protocol steps normalized to strict lint format.
- **TEMPLATE_USAGE_GUIDE.md** — DOC-ID update order aligned with artifact index protocol.
- **.github/PULL_REQUEST_TEMPLATE.md** — Added explicit PR checklist completion item.
- **docs/ARCHITECTURE_FREEZE_MARKER.md** — Template status clarified (not frozen).
- **docs/GOVERNANCE_SETUP.md** — Updated example release commit message.
- **README.md** — Version badge updated to 1.9.1.
- **.github/workflows/governance-check.yml** — Executes governance lint script.

## [1.9.0] - 2026-01-29

### Changed
- **Version Harmonization** — All template documents aligned to version 1.9.0.
- **docs/RELEASE_CHECKLIST.md** — Section order normalized; release gates and protocol locked.
- **docs/GOVERNANCE_LINT_SPEC.md** — Governance lint rules consolidated and version aligned.
- **Release Gate Mirror Rule** — Label standardized across governance docs.
- **Must-Pass Alignment** — GOV-LINT must-pass list aligned with release gate map.

## [1.8.4] - 2026-01-29

### Changed
- **docs/RELEASE_CHECKLIST.md** — Release Gate Map expanded to GOV-LINT-31..35; version updated.

## [1.8.3] - 2026-01-29

### Changed
- **docs/GOVERNANCE_LINT_SPEC.md** — GOV-LINT-31..35 added; Must-Pass list and Release Gate Map expanded; version updated.
- **docs/RELEASE_CHECKLIST.md** — Release Gate Map includes GOV-LINT-26..35; version updated.

## [1.8.2] - 2026-01-29

### Changed
- **docs/GOVERNANCE_LINT_SPEC.md** — GOV-LINT-26..30 added; Must-Pass list and Release Gate Map expanded; version updated.
- **docs/RELEASE_CHECKLIST.md** — Release Gate Map includes GOV-LINT-26..30; update protocol added; version updated.

## [1.8.1] - 2026-01-29

### Changed
- **docs/GOVERNANCE_LINT_SPEC.md** — GOV-LINT-25 added; Must-Pass list and Release Gate Map expanded; version updated.
- **docs/RELEASE_CHECKLIST.md** — Release Gate Map includes GOV-LINT-24/25; version updated.

## [1.8.0] - 2026-01-29

### Changed
- **docs/RELEASE_CHECKLIST.md** — Release Gate Map includes GOV-LINT-23; version updated.
- **docs/GOVERNANCE_LINT_SPEC.md** — Release Gate Map includes GOV-LINT-23; version updated.
- **.github/PULL_REQUEST_TEMPLATE.md** — PR checklist marked immutable.

## [1.7.9] - 2026-01-29

### Changed
- **docs/RELEASE_CHECKLIST.md** — Release Gate table marked immutable; version updated.
- **docs/GOVERNANCE_LINT_SPEC.md** — GOV-LINT-22 header spec tightened; GOV-LINT-23 added; version updated.
- **CONTRIBUTING.md** — PR checklist table includes regex rules.

## [1.7.8] - 2026-01-29

### Changed
- **docs/RELEASE_CHECKLIST.md** — Release Gate Map includes GOV-LINT-22; version updated.
- **docs/GOVERNANCE_LINT_SPEC.md** — Release Gate Map includes GOV-LINT-21/22; version updated.
- **CONTRIBUTING.md** — PR checklist table includes GOV-LINT IDs.

## [1.7.7] - 2026-01-29

### Changed
- **docs/RELEASE_CHECKLIST.md** — Release Gate Map includes GOV-LINT-21; version updated.
- **docs/GOVERNANCE_LINT_SPEC.md** — GOV-LINT-22 added; Mirror Rule regex added; version updated.

## [1.7.6] - 2026-01-29

### Changed
- **docs/GOVERNANCE_LINT_SPEC.md** — Mirror Rule exact line updated to include GOV-LINT-20 label.

## [1.7.5] - 2026-01-29

### Changed
- **docs/RELEASE_CHECKLIST.md** — GOV-LINT-20 added as Must-Pass; Mirror Rule marked with GOV-LINT-20.
- **docs/GOVERNANCE_LINT_SPEC.md** — GOV-LINT-21 added for PR checklist mandatory line; version updated.

## [1.7.4] - 2026-01-29

### Changed
- **docs/RELEASE_CHECKLIST.md** — Release Gate Map includes GOV-LINT-19; version updated.
- **docs/GOVERNANCE_LINT_SPEC.md** — GOV-LINT-20 added; version updated.
- **.github/PULL_REQUEST_TEMPLATE.md** — PR checklist marked mandatory.

## [1.7.3] - 2026-01-29

### Changed
- **docs/GOVERNANCE_LINT_SPEC.md** — Release Gate Mirror Rule; GOV-LINT-19 added; version updated.
- **CONTRIBUTING.md** — PR checklist converted to table.

## [1.7.2] - 2026-01-29

### Changed
- **docs/RELEASE_CHECKLIST.md** — Mirror rule for Release Gate Map; strict_mode gate added; version updated.
- **CONTRIBUTING.md** — PR checklist now explicitly requires PR template completion.

## [1.7.1] - 2026-01-29

### Changed
- **docs/GOVERNANCE_LINT_SPEC.md** — Release Gate Map added; strict_mode mandatory clarified.
- **.github/PULL_REQUEST_TEMPLATE.md** — PR Workflow Checklist added.

## [1.7.0] - 2026-01-29

### Changed
- **docs/RELEASE_CHECKLIST.md** — Release Gate (Must-Pass) table added; version updated.
- **CONTRIBUTING.md** — PR workflow checklist added.
- **TEMPLATE_USAGE_GUIDE.md** — strict_mode mandatory flag highlighted; version updated.

## [1.6.9] - 2026-01-29

### Changed
- **docs/GOVERNANCE_LINT_SPEC.md** — Must-Pass Enforcement section added.
- **CONTRIBUTING.md** — Lint Signature required for PRs.
- **docs/RELEASE_CHECKLIST.md** — strict_mode immutability mirrored; version updated.

## [1.6.8] - 2026-01-29

### Changed
- **docs/RELEASE_CHECKLIST.md** — Must-Pass GOV-LINT table and sign-off gate added; version updated.
- **docs/GOVERNANCE_LINT_SPEC.md** — strict_mode immutable config noted.

## [1.6.7] - 2026-01-29

### Changed
- **docs/RELEASE_CHECKLIST.md** — GOV-LINT reference table added; version updated.
- **TEMPLATE_USAGE_GUIDE.md** — strict_mode parameter mirrored; version updated.
- **docs/GOVERNANCE_LINT_SPEC.md** — Lint Signature checkbox rule added.

## [1.6.6] - 2026-01-29

### Changed
- **docs/GOVERNANCE_LINT_SPEC.md** — GOV-LINT index table added.
- **docs/RELEASE_CHECKLIST.md** — Strict mode parameter included in lint signature; version updated.
- **.github/PULL_REQUEST_TEMPLATE.md** — Lint signature completion checkbox added.

## [1.6.5] - 2026-01-29

### Changed
- **docs/RELEASE_CHECKLIST.md** — GOV-LINT IDs referenced; version updated.
- **docs/GOVERNANCE_LINT_SPEC.md** — Strict mode YAML block added.
- **.github/PULL_REQUEST_TEMPLATE.md** — Lint Signature mandatory section added.

## [1.6.4] - 2026-01-29

### Changed
- **docs/GOVERNANCE_LINT_SPEC.md** — GOV-LINT IDs added; strict_mode flag defined.
- **docs/RELEASE_CHECKLIST.md** — Lint signature section added; version updated.

## [1.6.3] - 2026-01-29

### Changed
- **docs/GOVERNANCE_LINT_SPEC.md** — Strict mode default enabled; immutable header policy lint rule added.
- **docs/RELEASE_CHECKLIST.md** — Regex checks now include file-scope references; version updated.

## [1.6.2] - 2026-01-29

### Changed
- **docs/RELEASE_CHECKLIST.md** — Lint readiness regex list added; version updated.
- **docs/artifact_index.md** — Immutable header block policy section added.
- **docs/GOVERNANCE_LINT_SPEC.md** — Strict mode section added.

## [1.6.1] - 2026-01-29

### Changed
- **docs/GOVERNANCE_LINT_SPEC.md** — Exact header block rules updated for immutable marker.
- **docs/RELEASE_CHECKLIST.md** — Lint readiness checklist detailed with file/regex checks.
- **docs/artifact_index.md** — DO NOT EDIT marker added to immutable header block.

## [1.6.0] - 2026-01-29

### Changed
- **docs/GOVERNANCE_LINT_SPEC.md** — Strict Update-Protocol regex and immutable header line rules added.
- **docs/artifact_index.md** — Immutable header block marker added.
- **docs/RELEASE_CHECKLIST.md** — Lint readiness checklist added; version updated.

## [1.5.9] - 2026-01-29

### Changed
- **docs/GOVERNANCE_LINT_SPEC.md** — Numbered Update-Protocol regex and ORDER LOCKED line rule added.
- **TEMPLATE_USAGE_GUIDE.md** — DOC-ID update order mirrored as mandatory checklist.

## [1.5.8] - 2026-01-29

### Changed
- **docs/GOVERNANCE_LINT_SPEC.md** — Update Protocol lint checks added.
- **docs/RELEASE_CHECKLIST.md** — Artifact Index marker check added; version updated.
- **README.md** — DOC-ID update order documented.

## [1.5.7] - 2026-01-29

### Changed
- **docs/GOVERNANCE_LINT_SPEC.md** — ORDER LOCKED regex rule added.
- **docs/artifact_index.md** — Update Protocol section added.
- **README.md** — Artifact Index mandatory reference added.

## [1.5.6] - 2026-01-29

### Changed
- **docs/artifact_index.md** — ORDER LOCKED marker added.
- **docs/GOVERNANCE_LINT_SPEC.md** — Prefix section regex rule added.
- **TECHNICAL_SPEC.md** — DOC-ID references added per artifact row.

## [1.5.5] - 2026-01-29

### Changed
- **docs/GOVERNANCE_LINT_SPEC.md** — Artifact Index as single source of truth and ordering rules added.
- **TECHNICAL_SPEC.md** — Artifact Index reference added.

## [1.5.4] - 2026-01-29

### Added
- **docs/artifact_index.md** — Central DOC-ID index added.

### Changed
- **docs/GOVERNANCE_LINT_SPEC.md** — Status value regex and artifact index checks added.
- **docs/RELEASE_CHECKLIST.md** — Artifacts Mapping Gate added; version updated.

## [1.5.3] - 2026-01-29

### Added
- **docs/GOVERNANCE_LINT_SPEC.md** — DOC-ID Regex validation rules added.
- **DESIGN.md** — Required Artifacts mandated (DES-GOV-28A).

### Changed
- **TECHNICAL_SPEC.md** — Allowed status values constrained (Draft/Final/Deprecated).
- **LASTENHEFT.md** — Required Artifacts Mapping required in Platform Decision Checklist.

## [1.5.2] - 2026-01-29

### Added
- **docs/GOVERNANCE_LINT_SPEC.md** — YAML Section Order list added.
- **TECHNICAL_SPEC.md** — Required Artifacts Mapping section added.

### Changed
- **docs/api_spec.md** — Added normative IDs for sections.
- **shared/ipc_contracts.md** — Added normative IDs for sections.
- **desktop/runtime_config.md** — Added normative IDs for sections.
- **desktop/packaging.md** — Added normative IDs for sections.
- **frontend/build_config.md** — Added normative IDs for sections.
- **ai_service/runtime_config.md** — Added normative IDs for sections.

## [1.5.1] - 2026-01-29

### Changed
- **docs/api_spec.md** — Placeholder with minimal required sections added.
- **shared/ipc_contracts.md** — Placeholder with minimal required sections added.
- **desktop/runtime_config.md** — Placeholder with minimal required sections added.
- **desktop/packaging.md** — Placeholder with minimal required sections added.
- **frontend/build_config.md** — Placeholder with minimal required sections added.
- **ai_service/runtime_config.md** — Placeholder with minimal required sections added.
- **docs/GOVERNANCE_LINT_SPEC.md** — Expected section order rules added.
- **docs/RELEASE_CHECKLIST.md** — INIT_STATUS control added.

## [1.5.0] - 2026-01-29

### Added
- **docs/api_spec.md** — Placeholder artifact for API specification.
- **shared/ipc_contracts.md** — Placeholder artifact for IPC contracts.
- **desktop/runtime_config.md** — Placeholder artifact for desktop runtime configuration.
- **desktop/packaging.md** — Placeholder artifact for desktop packaging.
- **frontend/build_config.md** — Placeholder artifact for frontend build configuration.
- **ai_service/runtime_config.md** — Placeholder artifact for service runtime configuration.

### Changed
- **TEMPLATE_USAGE_GUIDE.md** — Rule for INIT_STATUS: COMPLETE clarified.
- **docs/GOVERNANCE_LINT_SPEC.md** — Exact content markers required for artifacts.

## [1.4.9] - 2026-01-29

### Changed
- **docs/GOVERNANCE_LINT_SPEC.md** — Required artifacts mit exakten Dateipfaden ergänzt; Init-Status als Placeholder-Guard.
- **README.md** — Platform Matrix um Default Tech Stack und exakte Artefaktpfade ergänzt.
- **TEMPLATE_USAGE_GUIDE.md** — Version aktualisiert.

## [1.4.8] - 2026-01-29

### Changed
- **docs/GOVERNANCE_LINT_SPEC.md** — Path- und Section-Parser-Regeln ergänzt.
- **README.md** — Platform Matrix um Required Artifacts erweitert.
- **TEMPLATE_USAGE_GUIDE.md** — Template Initialization Checklist ergänzt.
- **TEMPLATE_USAGE_GUIDE.md** — Version/Datum/Status ergänzt.

## [1.4.7] - 2026-01-29

### Changed
- **docs/GOVERNANCE_LINT_SPEC.md** — Regex-Kriterien für deterministische Checks ergänzt.
- **README.md** — Platform Matrix um Required Docs erweitert; scripts-Verzeichnis dokumentiert.
- **scripts/README.md** — Platzhalter für künftige Governance-Lint Automation hinzugefügt.

## [1.4.6] - 2026-01-29

### Changed
- **LASTENHEFT.md** — Platform Decision Checklist mit Default-Entscheidungen ergänzt.
- **TECHNICAL_SPEC.md** — Tech Choice Justification Vorlage ergänzt.
- **docs/GOVERNANCE_LINT_SPEC.md** — Governance-Lint Spezifikation hinzugefügt (ohne Code).
- **docs/RELEASE_CHECKLIST.md** — Governance-Lint Verweis ergänzt.
- **README.md** — Version-Badge aktualisiert.

## [1.4.5] - 2026-01-29

### Changed
- **README.md** — Platform Matrix um konkrete Technologiebeispiele ergänzt.
- **LASTENHEFT.md** — Platform Decision Checklist ergänzt (pflichtig).
- **docs/RELEASE_CHECKLIST.md** — Governance-Lint Checkliste ergänzt.
- **docs/RELEASE_CHECKLIST.md** — Version/Datum/Status ergänzt.

## [1.4.4] - 2026-01-29

### Changed
- **README.md** — Platform Matrix ergänzt; Version-Badge aktualisiert.
- **CONTRIBUTING.md** — Platform Decision Gate ergänzt (DES-ARCH-23).
- **LASTENHEFT.md** — NFR-Platzhalter ergänzt; Version angehoben.
- **TECHNICAL_SPEC.md** — Platzhalter-Referenzen vollständig; Version angehoben.
- **SYSTEM_REPORT.md** — Platzhalter-Referenzen vollständig; Version angehoben.
- **STYLEGUIDE.md** — Version angehoben.
- **PROMPTS.md** — Version angehoben.

## [1.4.3] - 2026-01-29

### Changed
- **README.md** — Governance/Philosophy ergänzt um explizite Plattformentscheidung.
- **TEMPLATE_USAGE_GUIDE.md** — Lastenheft-Anweisung um Zielplattform ergänzt.
- **DESIGN.md** — Version angehoben; DES-ARCH-23 mit Technologieprinzip präzisiert.
- **LASTENHEFT.md** — Version angehoben; Änderungshistorie ergänzt.
- **TECHNICAL_SPEC.md** — Version/Datum harmonisiert; Änderungshistorie ergänzt.
- **STYLEGUIDE.md** — Version/Datum harmonisiert.
- **PROMPTS.md** — Version/Datum harmonisiert.
- **SYSTEM_REPORT.md** — Version/Datum harmonisiert.
- **scaffold_structure.sh** — Optionale Ordner `/desktop` und `/shared` werden angelegt.
- **desktop/README.md** — Platzhalter für Desktop-Shell-Zweck und Governance hinzugefügt.
- **shared/README.md** — Platzhalter für Shared-Contract-Zweck und Governance hinzugefügt.

## [1.4.2] - 2026-01-29

### Changed
- **DESIGN.md** — Desktop-Shell-Architektur regelt jetzt konditional; neue Anforderung zur Plattformentscheidung.
- **README.md** — Version-Badge aktualisiert; optionale Verzeichnisse `/desktop` und `/shared` dokumentiert.
- **CONTRIBUTING.md** — Verzeichnisstruktur um optionalen Desktop-Shell-Hinweis ergänzt.
- **TEMPLATE_USAGE_GUIDE.md** — Scaffolding-Hinweis auf optionale Ordner ergänzt.
- **scaffold_structure.sh** — Optionale Ordner `/desktop` und `/shared` werden mit angelegt.
- **LASTENHEFT.md** — Zielplattform als explizite Anforderung und fehlende Platzhalter ergänzt.

## [1.4.1] - 2026-01-29

### Changed
- **ai_prompt_intro.md** — Updated with stricter governance prompt (GOV-05/GOV-06) and dynamic `{{PROJECT_NAME}}`.

## [1.4.0] - 2026-01-29

### Added
- **NFR-REQ-08** — MANDATORY: CI reproducibility (no manual steps).
- **NFR-REQ-09** — MANDATORY: Test determinism (no implicit external deps).
- **Compliance** — Aligned functional NFRs with governance rules DES-GOV-51 and DES-GOV-55.
- **CONTRIBUTING.md** — Adopted strict "Local Quality Gates" (Sec 5) and clarified AI typing/test rules.

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
