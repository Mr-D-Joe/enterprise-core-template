# STYLEGUIDE — Enterprise Core Template
## Visual Standards and Design Tokens

> **⚠️ TEMPLATE DOCUMENT**  
> This document uses `{{PLACEHOLDER}}` markers. Replace these when initializing a new project.

Version: 1.9.2  
Datum: 2026-01-30  
Status: Released (Golden Standard)

---

## Placeholders to Replace

| Placeholder | Description | Example |
|-------------|-------------|---------|
| `{{DATE}}` | Initialization date | "2026-01-29" |
| `{{PRIMARY_BG_COLOR}}` | Primary background color | "#0f172a (Slate-900)" |
| `{{ACCENT_COLOR}}` | Accent/highlight color | "#3b82f6 (Blue-500)" |
| `{{SUCCESS_COLOR}}` | Success indication color | "#10b981 (Emerald-500)" |
| `{{ERROR_COLOR}}` | Error indication color | "#f43f5e (Rose-500)" |
| `{{FONT_INTERFACE}}` | UI typeface | "Inter" |
| `{{FONT_MONO}}` | Monospace typeface | "JetBrains Mono" |
| `{{CORNER_RADIUS}}` | Standard corner radius | "0.75rem" |
| `{{SHADOW_TOKEN}}` | Shadow token name | "shadow-sm" |

---

## 1. Design Tokens (Color Palette)

### 1.1 Primary Colors

#### 1.1.1 STYLE-TOKEN-COL-01 — Primary Background

The primary background color uses **{{PRIMARY_BG_COLOR}}** to establish a distinct visual foundation for app containers.

#### 1.1.2 STYLE-TOKEN-COL-02 — Primary Accent

The accent color uses **{{ACCENT_COLOR}}** to highlight primary actions and active states.

### 1.2 Status Colors

#### 1.2.1 STYLE-TOKEN-COL-03 — Success Indication

The system uses **{{SUCCESS_COLOR}}** to clearly signal positive outcomes and safe states.

#### 1.2.2 STYLE-TOKEN-COL-04 — Error Indication

The system uses **{{ERROR_COLOR}}** to clearly signal errors or destructive actions.

---

## 2. Typography

### 2.1 Font Families

#### 2.1.1 STYLE-TOKEN-TYPO-01 — Interface Typeface

The interface employs **{{FONT_INTERFACE}}** as the primary typeface for optimal readability in UI components.

#### 2.1.2 STYLE-TOKEN-TYPO-02 — Monospace Typeface

The system employs **{{FONT_MONO}}** for tabular data and code to ensure precise alignment.

---

## 3. Component Design

### 3.1 Containers & Cards

#### 3.1.1 STYLE-TOKEN-UI-01 — Corner Radius

Standard components utilize a corner radius of **{{CORNER_RADIUS}}** to maintain a cohesive softness across the UI.

#### 3.1.2 STYLE-TOKEN-UI-02 — Depth & Elevation

Depth is conveyed through a combination of **{{SHADOW_TOKEN}}** and distinct borders, establishing hierarchy.

### 3.2 Interaction Design

#### 3.2.1 STYLE-TOKEN-UI-03 — Hover Feedback

Interactive elements provide immediate visual feedback via opacity, scale, or shadow changes on hover, enhancing the responsive feel.
