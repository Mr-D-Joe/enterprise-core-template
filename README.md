# {{PROJECT_NAME}}

> **Based on Enterprise Core Template (Golden Standard)**

Status: **Enterprise Ready**  
Version: 1.1

<for_ai_agents>
**CRITICAL INSTRUCTION FOR ALL AI AGENTS:**
1.  **Stop.** Do not generate code yet.
2.  Read `DESIGN.md` immediately. This is the **Constitution**.
3.  Read `LASTENHEFT.md`. This defines **What** you must build.
4.  Do not hallucinate architecture. Use strict "Governance-First" compliance.
5.  If this is a new project, follow `TEMPLATE_USAGE_GUIDE.md` for initialization.
</for_ai_agents>

---

> [!IMPORTANT]  
> **SPECIFICATION GOVERNANCE: ACTIVE**  
> This project is governed by strict compliance rules.  
> 📜 **Constitution:** [`DESIGN.md`](./DESIGN.md)  
> 📋 **Requirements:** [`LASTENHEFT.md`](./LASTENHEFT.md)  
> 🤝 **Contributing:** [`CONTRIBUTING.md`](./CONTRIBUTING.md)  
>
> 🤖 **AI Agents:** You MUST read `CONTRIBUTING.md` before generating code.

---

## Purpose

This repository is the verified **"Golden Template"** for building Enterprise-grade applications with strict governance, AI-assisted development, and long-term maintainability.

### Template Features

- ✅ Pre-configured governance documents (DESIGN.md, LASTENHEFT.md, CONTRIBUTING.md)
- ✅ Atomic requirements structure
- ✅ AI agent workflows and prompts
- ✅ Mock-first development approach
- ✅ Change history tracking
- ✅ Architecture freeze markers

---

## How to Use This Template

### Option 1: GitHub "Use this template"

1. Click **"Use this template"** button on GitHub
2. Choose a name for your new repository
3. Follow `TEMPLATE_USAGE_GUIDE.md` to initialize

### Option 2: Clone and Reinitialize

```bash
# Clone template
git clone https://github.com/YOUR_USERNAME/enterprise-core-template.git new-project
cd new-project

# Remove template's git history
rm -rf .git
git init

# Follow TEMPLATE_USAGE_GUIDE.md for customization
```

---

## Governance Model

This repository is governed by three documents:

| Document | Role |
|--------|------|
| **DESIGN.md** | Binding project constitution & architecture rules |
| **LASTENHEFT.md** | Functional requirements |
| **README.md** | Orientation and navigation only |

DESIGN.md is the single source of architectural truth.

---

## Template Structure

```text
/docs                    Architecture documentation
  ├── ARCHITECTURE_FREEZE_MARKER.md
  ├── GOVERNANCE_SETUP.md
  └── RELEASE_CHECKLIST.md
/.agent                  AI agent workflows
  └── /workflows         Slash-command workflows
DESIGN.md                Project constitution
LASTENHEFT.md           Requirements specification
CONTRIBUTING.md          Contribution guidelines
TEMPLATE_USAGE_GUIDE.md  Template initialization guide
PROMPTS.md               AI prompt templates
STYLEGUIDE.md            Code style guidelines
TECHNICAL_SPEC.md        Technical specifications
CHANGELOG.md             Version history
```

---

## Key Documents

| Document | Purpose |
|----------|---------|
| `TEMPLATE_USAGE_GUIDE.md` | How to initialize a new project from this template |
| `DESIGN.md` | Architecture rules, governance (DES-GOV-*), LLM guidelines |
| `LASTENHEFT.md` | Atomic requirements with change history |
| `CONTRIBUTING.md` | Development workflow, mock-first approach |
| `PROMPTS.md` | Standard prompt templates for AI agents |

---

## Development Philosophy

This template follows:

- **Governance-first development** — Rules before code
- **Atomic requirements** — One function per requirement (DES-GOV-33)
- **Mock-first implementation** — Mock before real API (DES-GOV-17)
- **LLM discipline** — Controlled AI integration
- **Auditability** — Full change history
- **Deterministic behavior** — Predictability over convenience

---

## Projects Using This Template

- [WEATHER](https://github.com/YOUR_USERNAME/weather) — Privacy-first weather app
- [Stock News Pro](https://github.com/YOUR_USERNAME/stock-news-pro) — Financial analysis platform

---

## License

MIT License

Copyright (c) 2026 Joern

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

---

## Final Note

This repository is intentionally governed more strictly than typical projects.

This is by design to support:

- AI-assisted development
- Enterprise auditability
- Long-term maintainability
- Architectural integrity

**Do not modify governance documents without updating the version and change history.**
