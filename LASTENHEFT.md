# LASTENHEFT — Enterprise Core Template
## Requirements Specification Document

> **⚠️ TEMPLATE DOCUMENT**  
> This document uses `{{PLACEHOLDER}}` markers. Replace these when initializing a new project.

⚠️ Dieses Dokument ist normativ für funktionale Anforderungen.

Architektur-, Governance-, LLM- und Systemverhaltensregeln werden ausschließlich durch DESIGN.md definiert.

Im Konfliktfall besitzt DESIGN.md Vorrang.

Version: 1.1  
Datum: 2026-01-28  
Status: Released (Golden Standard)

---

## Placeholders to Replace

| Placeholder | Description | Example |
|-------------|-------------|---------|
| `{{PROJECT_NAME}}` | Your project name | "StockBot Pro" |
| `{{DATE}}` | Initialization date | "2026-01-29" |
| `{{PROJECT_GOAL}}` | Core project objective | "Provide financial analysis" |
| `{{TARGET_USER_1}}` | Primary target user group | "Private Investors" |
| `{{FEATURE_AREA}}` | Feature section name | "Stock Search" |
| `{{REQ_PREFIX}}` | Requirement ID prefix | "UI", "BE", "TA" |

---

## Änderungshistorie

| Version | Datum | Abschnitt | Änderungstyp | Beschreibung |
|--------:|-------|-----------|--------------|--------------|
| 1.0 | {{DATE}} | Gesamt | Initialisierung | Initiale Strukturübernahme aus Enterprise Core Template |
| 1.1 | 2026-01-28 | Gesamt | Refactoring | Einführung des Context/Story-Musters und Schärfung der Atomarität |

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

---

Ende des Lastenhefts

