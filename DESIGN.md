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

## 1. Architecture baseline

### 1.1 Stack matrix
| Layer | Technology | Notes |
|---|---|---|
| Frontend | React + TypeScript | Vite |
| Backend | Python + FastAPI | API/service layer |
| Persistence | SQLite/PostgreSQL | per project needs |

### 1.2 Repository structure
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
Required sequence is Requirement -> Implementation -> Audit -> PR -> Merge -> Version.

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

## 3. Security baseline metadata (mandatory)
`SECURITY_BASELINE_REVIEW_UTC=2026-02-25`
`SECURITY_BASELINE_MAX_AGE_DAYS=90`
`SECURITY_BASELINE_SOURCES=OWASP_ASVS_5.0.0;OWASP_API_TOP_10;OWASP_TOP_10;NIST_SSDF_SP_800_218;NIST_CSF_2_0;NIST_AI_RMF_GENAI_PROFILE`

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
