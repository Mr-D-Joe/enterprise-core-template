# LASTENHEFT — Enterprise Core Template
## Requirements Specification Document

> **⚠️ TEMPLATE DOCUMENT**  
> This document uses `{{PLACEHOLDER}}` markers. Replace these when initializing a new project.

⚠️ Dieses Dokument ist normativ für funktionale Anforderungen.

Architektur-, Governance-, LLM- und Systemverhaltensregeln werden ausschließlich durch DESIGN.md definiert.

Im Konfliktfall besitzt DESIGN.md Vorrang.

Version: 1.9.4  
Datum: 2026-01-30  
Status: Released (Golden Standard)

---

## Placeholders to Replace

| Placeholder | Description | Example |
|-------------|-------------|---------|
| `{{PROJECT_NAME}}` | Your project name | "StockBot Pro" |
| `{{DATE}}` | Initialization date | "2026-01-29" |
| `{{PROJECT_GOAL}}` | Core project objective | "Provide financial analysis" |
| `{{TARGET_USER_1}}` | Primary target user group | "Private Investors" |
| `{{TARGET_USER_2}}` | Secondary target user group | "Analysts" |
| `{{PLATFORM_TARGET}}` | Target platform | "Desktop", "Web", "API-only" |
| `{{FEATURE_AREA}}` | Feature section name | "Stock Search" |
| `{{REQ_PREFIX}}` | Requirement ID prefix | "UI", "BE", "TA" |
| `{{USER_STORY_CONTEXT}}` | User story context | "Users need..." |
| `{{BACKEND_CONTEXT}}` | Backend context | "APIs and data processing..." |
| `{{PLATFORM_CONTEXT}}` | Platform context | "OS integration details..." |
| `{{REQUIREMENT_NAME}}` | Requirement title | "Search stocks" |
| `{{ATOMIC_FUNCTION}}` | Atomic function | "search stocks by ticker" |
| `{{ATOMIC_TECHNICAL_FUNCTION}}` | Atomic technical function | "cache API responses" |
| `{{PLATFORM}}` | Platform name | "macOS, Windows" |
| `{{RESPONSE_TIME_REQUIREMENTS}}` | Response time requirements | "P95 < 200ms" |
| `{{STABILITY_REQUIREMENTS}}` | Stability & feedback requirements | "Show progress and retry guidance" |

---

## Änderungshistorie

| Version | Datum | Abschnitt | Änderungstyp | Beschreibung |
|--------:|-------|-----------|--------------|--------------|
| 1.0 | {{DATE}} | Gesamt | Initialisierung | Initiale Strukturübernahme aus Enterprise Core Template |
| 1.1 | 2026-01-28 | Gesamt | Refactoring | Einführung des Context/Story-Musters und Schärfung der Atomarität |
| 1.2 | 2026-01-29 | 7 | Erweiterung | Einführung von NFRs für CI-Reproduzierbarkeit und Test-Determinismus (NFR-REQ-08/09). |
| 1.4.3 | 2026-01-29 | 1 | Harmonisierung | Zielplattform als explizite Anforderung und Platzhalter ergänzt. |
| 1.4.4 | 2026-01-29 | 7 | Harmonisierung | Fehlende NFR-Platzhalter ergänzt. |
| 1.4.5 | 2026-01-29 | 1 | Erweiterung | Platform Decision Checklist ergänzt. |
| 1.4.6 | 2026-01-29 | 1 | Präzisierung | Platform Decision Checklist mit Default-Entscheidungen ergänzt. |
| 1.5.3 | 2026-01-29 | 1 | Präzisierung | Required Artifacts Mapping als Pflicht ergänzt. |
| 1.9.0 | 2026-01-29 | Gesamt | Harmonisierung | Versionsstand und Checklist-Struktur final konsolidiert. |

---

## 1. Projektübersicht

### 1.1 Projektname

{{PROJECT_NAME}}

### 1.2 Projektziel

> **LLM Instruction:** Describe the core project objective concisely.

{{PROJECT_GOAL}}

### 1.3 Zielgruppe

- {{TARGET_USER_1}}
- {{TARGET_USER_2}}

### 1.4 Zielplattform

> **LLM Instruction:** Choose the most suitable target platform based on project needs and efficiency.

{{PLATFORM_TARGET}}

### 1.5 Platform Decision Checklist (Mandatory)

> **LLM Instruction:** Fill in each item explicitly. Do not leave blank.

- [ ] **Target Platform** selected: {{PLATFORM_TARGET}}
- [ ] **Primary Rationale** documented (performance, UX, distribution, constraints).
- [ ] **Runtime/Framework Choice** documented (e.g., Tauri/Electron for Desktop, SSR/SPA for Web).
- [ ] **Default Choice (Desktop)**: Tauri (unless explicitly justified otherwise).
- [ ] **Default Choice (Web)**: Modern SSR/SPA with strict determinism (framework choice + reason).
- [ ] **Default Choice (API-only)**: Minimal runtime + deterministic stack (framework choice + reason).
- [ ] **Justification recorded in LASTENHEFT.md** for any non-default choice (e.g., Electron).
- [ ] **Required directories** aligned with platform (see README Platform Matrix).
- [ ] **Required artifacts** mapped in TECHNICAL_SPEC.md Section 6 (Required Artifacts Mapping).

---

## 2. Funktionale Anforderungen

### 2.1 {{FEATURE_AREA}}

#### Kontext & User Story

> **LLM Instruction:** Describe the user story and the functional context. Explain the "why" and the systemic relationship to clarify the intention behind the requirements.

{{USER_STORY_CONTEXT}}

#### Anforderungen

#### 2.1.1 {{REQ_PREFIX}}-REQ-01 — {{REQUIREMENT_NAME}}

Das System muss {{ATOMIC_FUNCTION}} bereitstellen.

---

## 3. Daten & Backend

#### Kontext & User Story

> **LLM Instruction:** Describe the technical context for APIs, data processing, or backend logic.

{{BACKEND_CONTEXT}}

#### Anforderungen

#### 3.1.1 {{REQ_PREFIX}}-BE-REQ-01 — {{REQUIREMENT_NAME}}

Das Backend muss {{ATOMIC_TECHNICAL_FUNCTION}} bereitstellen.

---

## 4. Integration & Plattform

#### Kontext & User Story

> **LLM Instruction:** Describe the context for platform integration (e.g., desktop shell, IPC connection, or OS-specific features).

{{PLATFORM_CONTEXT}}

#### Anforderungen

#### 4.1.1 TA-REQ-EXAMPLE-01 — Beispielanforderung

Das System muss als {{PLATFORM}} ausführbar sein.

---

## 7. Nicht-funktionale Anforderungen

### 7.1 NFR-REQ-01 — Reaktionsfähigkeit

> **LLM Instruction:** Define response time requirements.

{{RESPONSE_TIME_REQUIREMENTS}}

### 7.2 NFR-REQ-02 — Systemstabilität & Feedback

> **LLM Instruction:** Define how the system communicates processing status positively to users.

{{STABILITY_REQUIREMENTS}}

### 7.3 NFR-REQ-08 — CI-Reproduzierbarkeit

Die CI muss ohne manuelle Setup-Schritte reproduzierbar laufen; alle Test-Dependencies müssen in der CI installierbar sein.

### 7.4 NFR-REQ-09 — Test-Determinismus

Tests müssen deterministisch ohne externe Dienste/Binaries laufen oder als Integrationstests markiert und getrennt ausführbar sein.

---

Ende des Lastenhefts
