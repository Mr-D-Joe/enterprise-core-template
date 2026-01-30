# TECHNICAL_SPEC — Enterprise Core Template
## Implementation-Level Specification

> **⚠️ TEMPLATE DOCUMENT**  
> This document uses `{{PLACEHOLDER}}` markers. Replace these when initializing a new project.

Version: 1.9.5  
Datum: 2026-01-30  
Status: Released (Golden Standard)

---

## Placeholders to Replace

| Placeholder | Description | Example |
|-------------|-------------|---------|
| `{{PROJECT_NAME}}` | Your project name | "StockBot Pro" |
| `{{DATE}}` | Initialization date | "2026-01-29" |
| `{{FEATURE_NAME}}` | Feature being specified | "Stock Search" |
| `{{REQ_ID}}` | Requirement ID from LASTENHEFT.md | "UI-REQ-01" |
| `{{ENDPOINT_NAME}}` | API endpoint name | "/api/v1/search" |
| `{{ERROR_CASE}}` | Error scenario name | "API Timeout" |
| `{{DES_REF}}` | DESIGN.md reference | "DES-ARCH-10" |
| `{{IMPLEMENTATION_CONTEXT}}` | Implementation context | "Service-layer mapping..." |
| `{{IMPLEMENTATION_DESCRIPTION}}` | Implementation details | "Hook calls service..." |
| `{{HTTP_METHOD}}` | HTTP method | "POST" |
| `{{PAYLOAD_STRUCTURE}}` | Request payload structure | "JSON schema" |
| `{{RESPONSE_STRUCTURE}}` | Response structure | "JSON schema" |
| `{{ERROR_HANDLING_DESCRIPTION}}` | Error handling description | "Retry + fallback" |
| `{{LIMIT_NAME}}` | Limit name | "Throughput" |
| `{{PERFORMANCE_CONSTRAINTS}}` | Performance constraints | "P95 < 200ms" |
| `{{FRONTEND_FRAMEWORK}}` | Frontend framework | "React" |
| `{{BACKEND_FRAMEWORK}}` | Backend framework | "FastAPI" |
| `{{DESKTOP_RUNTIME}}` | Desktop runtime | "Tauri" |
| `{{STATE_STRATEGY}}` | State strategy | "Server-state + local UI state" |
| `{{TECH_CHOICE_PRIMARY_REASON}}` | Primary tech choice reason | "Performance + maintainability" |
| `{{TECH_CHOICE_CONSTRAINTS}}` | Constraints considered | "Security, offline, auditability" |
| `{{TECH_CHOICE_GOVERNANCE_FIT}}` | Governance fit | "Matches DES-ARCH/DES-GOV rules" |
| `{{TECH_CHOICE_OPERATIONAL_IMPACT}}` | Operational impact | "CI time, packaging, support" |
| `{{TECH_CHOICE_ALTERNATIVES}}` | Alternatives rejected | "Electron due to footprint" |
| `{{ARTIFACT_OWNER_API_SPEC}}` | Artifact owner (API spec) | "Backend Lead" |
| `{{ARTIFACT_STATUS_API_SPEC}}` | Artifact status (API spec) | "Draft/Final" |
| `{{ARTIFACT_OWNER_IPC}}` | Artifact owner (IPC contracts) | "Desktop Lead" |
| `{{ARTIFACT_STATUS_IPC}}` | Artifact status (IPC contracts) | "Draft/Final" |
| `{{ARTIFACT_OWNER_DESKTOP_RUNTIME}}` | Artifact owner (desktop runtime) | "Desktop Lead" |
| `{{ARTIFACT_STATUS_DESKTOP_RUNTIME}}` | Artifact status (desktop runtime) | "Draft/Final" |
| `{{ARTIFACT_OWNER_PACKAGING}}` | Artifact owner (packaging) | "Release Lead" |
| `{{ARTIFACT_STATUS_PACKAGING}}` | Artifact status (packaging) | "Draft/Final" |
| `{{ARTIFACT_OWNER_FRONTEND_BUILD}}` | Artifact owner (frontend build) | "Frontend Lead" |
| `{{ARTIFACT_STATUS_FRONTEND_BUILD}}` | Artifact status (frontend build) | "Draft/Final" |
| `{{ARTIFACT_OWNER_SERVICE_RUNTIME}}` | Artifact owner (service runtime) | "Backend Lead" |
| `{{ARTIFACT_STATUS_SERVICE_RUNTIME}}` | Artifact status (service runtime) | "Draft/Final" |

---

## Änderungshistorie

| Version | Datum | Abschnitt | Änderungstyp | Beschreibung |
|--------:|-------|-----------|--------------|--------------|
| 1.0 | {{DATE}} | Gesamt | Initialisierung | Initiale Strukturübernahme aus Enterprise Core Template |
| 1.1 | 2026-01-28 | Gesamt | Refactoring | Einführung des Kontext-Musters zur Erläuterung der Implementierungs-Intention |
| 1.4.3 | 2026-01-29 | Gesamt | Harmonisierung | Versions- und Datumsstand an Template-Release angeglichen |
| 1.4.4 | 2026-01-29 | Gesamt | Harmonisierung | Platzhalter-Referenztabelle vervollständigt |
| 1.4.6 | 2026-01-29 | 0 | Erweiterung | Tech Choice Justification Vorlage ergänzt |
| 1.5.2 | 2026-01-29 | 6 | Erweiterung | Required Artifacts Mapping ergänzt |
| 1.5.3 | 2026-01-29 | 6 | Präzisierung | Allowed Status Values ergänzt |
| 1.5.5 | 2026-01-29 | 6 | Präzisierung | Artifact Index Reference ergänzt |
| 1.5.6 | 2026-01-29 | 6 | Präzisierung | DOC-ID Referenzen pro Artefakt ergänzt |
| 1.9.0 | 2026-01-29 | Gesamt | Harmonisierung | Versionsstand und Artefakt-Mapping final konsolidiert |

---

## 1. Core Feature Specifications

### 1.1 Feature Area: {{FEATURE_NAME}}

#### Kontext & User Story Implementation

> **LLM Instruction:** Describe here how the corresponding user story is technically approached and which architectural decisions are central.

{{IMPLEMENTATION_CONTEXT}}

#### 1.1.1 TECH-SPEC-FEAT-01 — {{FEATURE_NAME}}

**Implements Requirements:** {{REQ_ID}}

> **LLM Instruction:** Describe the specific technical implementation chosen to fulfill the requirements.

{{IMPLEMENTATION_DESCRIPTION}}

---

## 2. Interface Specifications (API/IPC)

### 2.1 Endpoint Definitions

#### 2.1.1 TECH-SPEC-API-01 — {{ENDPOINT_NAME}}

| Property | Value |
|----------|-------|
| **Method** | {{HTTP_METHOD}} |
| **Payload** | {{PAYLOAD_STRUCTURE}} |
| **Response** | {{RESPONSE_STRUCTURE}} |

---

## 3. Error Handling & Fallbacks

### 3.1 Failure Scenarios

#### 3.1.1 TECH-SPEC-ERROR-01 — {{ERROR_CASE}}

**Related Governance:** {{DES_REF}}

> **LLM Instruction:** Describe the error handling mechanism for this scenario.

{{ERROR_HANDLING_DESCRIPTION}}

---

## 4. Performance & Limits

### 4.1 Constraints

#### 4.1.1 TECH-SPEC-PERF-01 — {{LIMIT_NAME}}

> **LLM Instruction:** Describe specific performance constraints or limits implemented.

{{PERFORMANCE_CONSTRAINTS}}

---

## 5. Tech Choice Justification (Mandatory)

> **LLM Instruction:** Fill in all fields explicitly. No blanks.

### 5.1 Selected Stack Summary

- **Frontend Framework**: {{FRONTEND_FRAMEWORK}}
- **Backend Framework**: {{BACKEND_FRAMEWORK}}
- **Desktop Runtime (if any)**: {{DESKTOP_RUNTIME}}
- **State/Server-State Strategy**: {{STATE_STRATEGY}}

### 5.2 Rationale

- **Primary Reason**: {{TECH_CHOICE_PRIMARY_REASON}}
- **Constraints Considered**: {{TECH_CHOICE_CONSTRAINTS}}
- **Governance Fit**: {{TECH_CHOICE_GOVERNANCE_FIT}}
- **Operational Impact**: {{TECH_CHOICE_OPERATIONAL_IMPACT}}
- **Alternatives Rejected**: {{TECH_CHOICE_ALTERNATIVES}}

---

## 6. Required Artifacts Mapping (Mandatory)

> **LLM Instruction:** List required artifacts from README Platform Matrix and map each to an owner and status.

| Artifact | Owner | Status | Reference | DOC-IDs |
|----------|-------|--------|-----------|
| docs/api_spec.md | {{ARTIFACT_OWNER_API_SPEC}} | {{ARTIFACT_STATUS_API_SPEC}} | Platform Matrix | DOC-API-01..DOC-API-04 |
| shared/ipc_contracts.md | {{ARTIFACT_OWNER_IPC}} | {{ARTIFACT_STATUS_IPC}} | Platform Matrix | DOC-IPC-01..DOC-IPC-03 |
| desktop/runtime_config.md | {{ARTIFACT_OWNER_DESKTOP_RUNTIME}} | {{ARTIFACT_STATUS_DESKTOP_RUNTIME}} | Platform Matrix | DOC-DESK-01..DOC-DESK-04 |
| desktop/packaging.md | {{ARTIFACT_OWNER_PACKAGING}} | {{ARTIFACT_STATUS_PACKAGING}} | Platform Matrix | DOC-PACK-01..DOC-PACK-03 |
| frontend/build_config.md | {{ARTIFACT_OWNER_FRONTEND_BUILD}} | {{ARTIFACT_STATUS_FRONTEND_BUILD}} | Platform Matrix | DOC-FE-01..DOC-FE-03 |
| ai_service/runtime_config.md | {{ARTIFACT_OWNER_SERVICE_RUNTIME}} | {{ARTIFACT_STATUS_SERVICE_RUNTIME}} | Platform Matrix | DOC-BE-01..DOC-BE-04 |

**Allowed Status Values:** `Draft`, `Final`, `Deprecated` (no other values permitted).

**Artifact Index Reference:** All DOC-IDs must be listed in `docs/artifact_index.md` (single source of truth).
