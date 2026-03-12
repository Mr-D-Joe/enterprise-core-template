# DESIGN — Architecture and Governance

This document is normative and binding.

## Normative hierarchy
1. AGENTS.md
2. DESIGN.md
3. CONTRIBUTING.md
4. PROMPTS.md
5. LASTENHEFT.md
6. docs/specs/*.md

All files in `docs/governance/` are supportive templates/checklists unless explicitly referenced by the four normative control files above.
`DESIGN.md` is the only normative source for architecture/governance fundamentals.
`PROMPTS.md` is the only normative runtime role-execution contract and must not redefine `DESIGN.md` fundamentals.

## 1. Architecture baseline

### 1.1 Technology profile matrix (2026 default)
Tooling must start with one profile selection before implementation.

| Profile ID | UI/Frontend | Backend/API | Data | Mobile | Apply when |
|---|---|---|---|---|---|
| `PROFILE_WEB_DEFAULT` | Next.js + React + TypeScript | FastAPI | PostgreSQL | Optional React Native + Expo | Default for customer-facing web products/SaaS |
| `PROFILE_ENTERPRISE_PORTAL` | Angular + TypeScript | FastAPI | PostgreSQL | Optional React Native + Expo | Data-heavy internal workflows with strict structure |
| `PROFILE_SERVER_RENDERED_LIGHT` | htmx + server-rendered templates | FastAPI | PostgreSQL or SQLite | none | Form/workflow apps where low client complexity is a goal |
| `PROFILE_MOBILE_CROSS_PLATFORM` | React Native + Expo + TypeScript | FastAPI | PostgreSQL | iOS + Android from one codebase | iOS+Android parity required with one team |
| `PROFILE_MOBILE_IOS_FIRST` | SwiftUI (iOS) + minimal web admin UI | FastAPI | PostgreSQL | Native iOS first, Android optional later | iPhone quality and platform integration are priority |

### 1.2 Tool selection rules (simple, hard)
1. Select one `application_profile` from section 1.1 before any code change.
2. Production web UI must be type-safe (`TypeScript`-based stack). Plain JavaScript is allowed only for static/minimal pages.
3. Production dependencies must be stable/LTS (no beta/rc/canary) unless PO explicitly accepts risk.
4. Tool decisions must be backed by official sources and verification date within tooling age window.
5. If mobile is in scope:
   - use `PROFILE_MOBILE_CROSS_PLATFORM` by default;
   - use `PROFILE_MOBILE_IOS_FIRST` only when iOS-first quality/integration is explicit.
6. If no profile matches exactly, choose the nearest profile and document deviation in tooling decision evidence.
7. Active runtime and compiler versions (Python/Node/.NET/CC/CXX as applicable) must be latest stable at decision time and evidenced with official sources.
8. Python virtual environment path is fixed to project root `.venv`; nested or alternative venv locations are non-conform.

### 1.3 Tooling decision packet schema (mandatory)
`system_reports/gates/tooling_decision_template.env` must include at least:
- `decision_packet_id`
- `decision_status`
- `scope_req_ids`
- `application_profile`
- `frontend_ui_choice`
- `backend_choice`
- `data_choice`
- `mobile_choice`
- `stability_target`
- `python_version_choice`
- `node_version_choice`
- `dotnet_version_choice`
- `cc_choice`
- `cxx_choice`
- `official_source_1`
- `official_source_2`
- `source_verified_utc`
- `tooling_source_max_age_days`
- `selection_rationale`
- `created_at_utc`

### 1.4 Repository structure
- `frontend/` frontend application code.
- `backend/` backend services and API.
- `docs/specs/` modular requirement documents.
- `docs/governance/` governance and audit artifacts.

## 2. Governance rules

### GOV-01 Agent Contract First
Implementation must follow the requirement-level agent contract target and data flow.

### GOV-02 No Silent Scope Expansion
No unrelated file changes without explicit requirement trace mapping.

### GOV-03 Deterministic Verification
Each requirement must provide a deterministic test vector.

### GOV-04 Traceability Mandatory
Every implemented requirement must map to REQ -> Design -> Code -> Test -> Gate.

### GOV-05 Lean Contracts
Only relevant contract fields are allowed. Placeholder/noise fields are prohibited in finalized specs.

### GOV-06 Independent Audit Mandatory
Release decisions require an Independent Audit role, separate from implementation.

### GOV-07 Four-Eyes Enforcement
DEV and AUDIT must use distinct identities and produce separate artifacts.

### GOV-08 Audit Input Separation
AUDIT must only use approved input set (contract docs, change set, test evidence, gate reports).

### GOV-09 Nonconformity and CAPA
Audit findings must be classified, tracked, and closed with corrective action evidence.

### GOV-10 ISO-Aligned Control Evidence
Process must maintain evidence suitable for ISO-aligned quality, security, and AI-governance audits.

### GOV-11 PO-Driven Execution
All DEV and AUDIT execution is driven by PO requirement packets.

### GOV-12 Delivery Sequence Enforcement
Required sequence is Requirement -> Implementation -> Audit -> PR -> Merge -> Version -> Clean Desk.

### GOV-13 No Self-Approval
The DEV identity that authored implementation must never issue final audit approval or release authorization.

### GOV-14 Mandatory Gate Failure Semantics
If requirement traceability, independence constraints, or audit quality controls fail, gate status must be `FAIL` with no bypass path.

### GOV-15 ISO-Aligned Evidence Package
Each change package must retain machine-readable evidence for:
- requirement traceability,
- role separation and independent decision,
- deterministic verification,
- final release readiness decision.

### GOV-16 Prompt Mode Separation
Single-prompt operation is mandatory (`PROMPTS.md`). DEV and AUDIT must run with separate role packets (`EXECUTION_MODE`) and separate input sets. Shared context outside approved artifacts is forbidden.

### GOV-17 Committed-State Audit Execution
AUDIT must execute only on committed state after DEV gate evidence exists. Pre-commit or live DEV-context audits are invalid.

### GOV-18 Security and Privacy by Default
All requirements and implementations must define data classification, secret handling, retention/deletion, logging redaction, and encryption expectations where applicable.

### GOV-19 Security Baseline Currency
Security and privacy control mapping must be reviewed on a fixed cadence with dated evidence and named reference standards.

### GOV-20 Key and Secret Management
Credentials must come from approved secret stores or runtime injection. Hardcoded or plaintext credentials are forbidden.

### GOV-21 Privacy and Logging Controls
Personal/sensitive data processing requires explicit minimization, purpose, retention, deletion, and redaction controls.

### GOV-22 ISO-Conform Security/Data Audit Depth
AUDIT must issue explicit PASS/FAIL verdicts for security and data controls (classification, secrets, retention/deletion, redaction/logging, encryption, dependency risk) with evidence references.

### GOV-23 Security Baseline Freshness Gate
Audit readiness is `FAIL` when security baseline review age exceeds `SECURITY_BASELINE_MAX_AGE_DAYS`.

### GOV-24 Technology Decision Before Build
Before implementation, each change package must include an explicit tool decision for UI/frontend, backend, data, and (if applicable) mobile.

### GOV-25 Currency and Stability Gate
Tool decisions must prefer stable/LTS releases and be verified against official source material within `TOOLING_SOURCE_MAX_AGE_DAYS`.

### GOV-26 Official Source Requirement for Tooling
Tooling decisions must reference primary official sources only (official docs, official release notes, official version matrices).

### GOV-27 Profile-First Tool Selection
Before implementation, DEV must bind the change package to one `application_profile` from section 1.1 and use it as default decision baseline.

### GOV-28 Type-Safe UI Default
For production web scope, the UI stack must be TypeScript-based. Non-typed UI stacks require explicit PO risk acceptance in evidence artifacts.

### GOV-29 Runtime and Compiler Currency
For active scope, runtime and compiler decisions must target latest stable versions and be evidenced with dated official sources.

### GOV-30 Root-Only Python Environment
Python virtual environment location is fixed to project root `.venv`; alternative locations are blocked for release readiness.

### GOV-31 Serial Change Package Lock
Only one change package may be active. Starting a new package before the current package reaches Merge, Version, and Clean Desk closure is `FAIL`.

### GOV-32 Per-Requirement Test Pair Coverage
For every active `REQ_ID`, audit evidence must show at least one executed positive test (`PASS`) and one executed negative test (`PASS`). Total executed tests for the active package must be greater than zero.
`positive_count > 0` and `negative_count > 0` are both mandatory at package level; one side cannot compensate for the other.

### GOV-33 Backlog and Package Metadata Freshness
Before DEV start, `docs/BACKLOG.md` and active PO package metadata must be synchronized and current. Stale planning metadata is `FAIL`.

### GOV-34 Machine-Generated Planning Metrics
`LASTENHEFT.md` and `docs/BACKLOG.md` planning metrics must be machine-generated and include `generated_at_utc` and `source_commit_sha`.

### GOV-35 No Active Document Duplication
Only one active leading document per governance/prompt topic is allowed. Parallel active prompt/governance contracts are `FAIL`.

### GOV-36 Test Partition Enforcement
When Python tests are in scope, unit and integration test execution must be separated and evidenced:
- `pytest -m "not integration"`
- `pytest -m integration`

### GOV-37 Performance Budget Gate
Release readiness requires explicit performance budget evidence for active scope (minimum `p95` budget verdict).

### GOV-38 Structural Size Gate
Python module size above `PYTHON_MODULE_LOC_LIMIT` is `FAIL` without active waiver evidence.

### GOV-39 Runtime Fitness Review Cadence
Runtime/toolchain currency and fitness review must be performed on a fixed cadence with dated official-source evidence.

### GOV-40 Standardized Waiver Mechanism
Any exception to hard controls requires a machine-readable waiver with:
- `waiver_id`
- `rule_id`
- `scope`
- `approved_by_po_agent_id`
- `created_at_utc`
- `expires_at_utc`
- `justification`
- `rollback_package_id`
Expired/missing waiver evidence is `FAIL`.

### GOV-41 Secure Runtime Defaults
Production runtime defaults must be secure by default. Disabling security defaults (for example null/disabled CSP, disabled transport security, permissive wildcard origins without scope justification) is `FAIL` unless a valid waiver exists.

### GOV-42 Error Disclosure Boundary
Client-facing contracts must not expose raw internal exceptions, stack traces, infrastructure identifiers, or secret-bearing error details.

### GOV-43 No Silent Error Masking
Errors must not be masked as successful responses (for example `[]`, `0`, `{}`, or success status) when operation semantics represent failure.

### GOV-44 Canonical Runtime Contract
Runtime contract fields must be consistent across code, scripts, docs, and environment keys:
- interpreter/runtime
- port/bind target
- startup command
- required env keys
Inconsistencies are release-blocking.

### GOV-45 Dependency and Supply-Chain Baseline
Each release package must include dependency vulnerability and supply-chain evidence (source integrity and risk review) with explicit PASS/FAIL verdict.

### GOV-46 Persistence Schema Versioning and Migration Strategy
Persistent data changes require explicit schema versioning and deterministic migration strategy (upgrade and rollback behavior).
Persistence changes without migrations are `FAIL`.

### GOV-47 Version Single Source of Truth
Version identifiers across manifest/build/release artifacts must resolve to one canonical source.
Version source mismatch is `FAIL`.

## 3. Security baseline metadata (mandatory)
`SECURITY_BASELINE_REVIEW_UTC=2026-02-25`
`SECURITY_BASELINE_MAX_AGE_DAYS=90`
`SECURITY_BASELINE_SOURCES=OWASP_ASVS_5.0.0;OWASP_API_TOP_10;OWASP_TOP_10;NIST_SSDF_SP_800_218;NIST_CSF_2_0;NIST_AI_RMF_GENAI_PROFILE`
`TOOLING_DECISION_REVIEW_UTC=2026-02-25`
`TOOLING_SOURCE_MAX_AGE_DAYS=90`
`TOOLING_ALLOWED_SOURCE_TYPES=official_docs;official_release_notes;official_version_matrix`
`PLANNING_METADATA_MAX_AGE_DAYS=90`
`RUNTIME_FITNESS_REVIEW_UTC=2026-03-10`
`RUNTIME_FITNESS_MAX_AGE_DAYS=90`
`PYTHON_MODULE_LOC_LIMIT=900`

## 4. Hardening expectations for gate scripts

Gate scripts must enforce the following checks at minimum:
1. presence and integrity of normative files (`AGENTS.md`, `DESIGN.md`, `CONTRIBUTING.md`, `PROMPTS.md`);
2. strict delivery order (Requirement -> DEV -> AUDIT -> Release);
3. independent audit controls (identity separation + audit input firewall);
4. prompt mode separation via explicit PO role packet (`EXECUTION_MODE=DEV|AUDIT`);
5. role-packet artifact schema and key integrity (`execution_mode`, `po_packet_id`, `req_ids`, `scope_allowlist`, `allowed_inputs_hash`, `target_commit_sha`, `po_agent_id`, `created_at_utc`);
6. security/privacy controls (classification, secrets, retention, redaction, verification evidence);
7. ISO-conform security/data control verdicts in audit artifacts;
8. hard-fail behavior when controls are missing or violated.
9. tooling decision checkpoint before implementation with official-source and currency evidence.
10. tooling decision packet schema completeness (`application_profile`, stack choices, stability target, source verification fields).
11. serial package lock enforcement (no overlapping PO packets before prior package closure).
12. per-REQ test pair execution enforcement (positive+negative) with non-zero executed test count for active package.
13. stale backlog/plan metadata detection and hard-fail behavior.
14. no redundant active prompt/governance contract files.
15. test partition enforcement for Python scope (`not integration` and `integration`).
16. performance budget evidence gate enforcement (minimum `p95` verdict).
17. structural module-size gate enforcement with waiver validation.
18. waiver schema/expiry validation for exception paths.
19. secure runtime defaults enforcement.
20. error disclosure boundary enforcement (no raw exception leakage).
21. no silent error masking as success values.
22. canonical runtime contract consistency checks (port/interpreter/start command/env keys).
23. dependency/supply-chain baseline evidence checks.
24. persistence migration strategy checks for schema-affecting changes.
25. version single-source-of-truth consistency checks.
26. waiver rollback-package requirement checks.
