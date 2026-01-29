# 🏛️ Enterprise Core Template

> **The Golden Standard for AI-Assisted Enterprise Development**

[![Template](https://img.shields.io/badge/GitHub-Template-green?style=flat&logo=github)](https://github.com/Mr-D-Joe/enterprise-core-template)
![Status](https://img.shields.io/badge/Status-Enterprise%20Ready-blue)
![Version](https://img.shields.io/badge/Version-1.1-informational)

---

This is a **GitHub Template Repository** designed to bootstrap enterprise-grade applications with strict governance, AI-assisted development workflows, and long-term maintainability.

<for_ai_agents>

**🤖 CRITICAL INSTRUCTION FOR ALL AI AGENTS:**

1. **Stop.** Do not generate code yet.
2. Read [`DESIGN.md`](./DESIGN.md) immediately. This is the **Constitution**.
3. Read [`LASTENHEFT.md`](./LASTENHEFT.md). This defines **What** you must build.
4. Do not hallucinate architecture. Use strict "Governance-First" compliance.
5. For new projects, follow [`TEMPLATE_USAGE_GUIDE.md`](./TEMPLATE_USAGE_GUIDE.md) for initialization.

</for_ai_agents>

---

## 🚀 Quick Start

### Create a New Project from This Template

1. Click the green **"Use this template"** button above → **"Create a new repository"**
2. Name your new repository and create it
3. Clone your new repository locally
4. Follow [`TEMPLATE_USAGE_GUIDE.md`](./TEMPLATE_USAGE_GUIDE.md) for full initialization

> [!TIP]
> If you don't see the "Use this template" button, the repository may need to be configured as a template. See [`TEMPLATE_USAGE_GUIDE.md`](./TEMPLATE_USAGE_GUIDE.md) for admin setup instructions.

---

## 📋 What's Included

| Document | Purpose |
|----------|---------|
| [`DESIGN.md`](./DESIGN.md) | 📜 **Constitution** — Binding architecture & governance rules |
| [`LASTENHEFT.md`](./LASTENHEFT.md) | 📋 **Requirements** — Functional specification template |
| [`CONTRIBUTING.md`](./CONTRIBUTING.md) | 🤝 **Workflow** — Development guidelines & AI instructions |
| [`TEMPLATE_USAGE_GUIDE.md`](./TEMPLATE_USAGE_GUIDE.md) | 🎯 **Setup** — Step-by-step project initialization |
| [`PROMPTS.md`](./PROMPTS.md) | 🤖 **AI Prompts** — Standard prompt templates |
| [`STYLEGUIDE.md`](./STYLEGUIDE.md) | 🎨 **Design** — Visual & code style guidelines |
| [`TECHNICAL_SPEC.md`](./TECHNICAL_SPEC.md) | ⚙️ **Tech Spec** — Implementation details template |

---

## ✨ Template Features

- ✅ **Pre-configured Governance** — DESIGN.md as binding constitution
- ✅ **Atomic Requirements** — Each requirement = one function (DES-GOV-33)
- ✅ **AI Agent Workflows** — Built-in prompts and workflows for AI assistants
- ✅ **Mock-First Development** — Prototype before real APIs (DES-GOV-17)
- ✅ **Change History Tracking** — Full auditability of all changes
- ✅ **Architecture Freeze Markers** — Protect stable components

---

## 📁 Directory Structure

```text
enterprise-core-template/
├── docs/                        📚 Architecture documentation
│   ├── ARCHITECTURE_FREEZE_MARKER.md
│   ├── GOVERNANCE_SETUP.md
│   └── RELEASE_CHECKLIST.md
├── .agent/                      🤖 AI agent workflows
│   └── workflows/               Slash-command workflows
├── DESIGN.md                    📜 Project constitution (normative)
├── LASTENHEFT.md                📋 Requirements specification (normative)
├── CONTRIBUTING.md              🤝 Contribution guidelines
├── TEMPLATE_USAGE_GUIDE.md      🎯 Template initialization guide
├── PROMPTS.md                   🤖 AI prompt templates
├── STYLEGUIDE.md                🎨 Code style guidelines
├── TECHNICAL_SPEC.md            ⚙️ Technical specifications
├── CHANGELOG.md                 📝 Version history
└── scaffold_structure.sh        🔧 Project scaffolding script
```

---

## 🏛️ Governance Model

> [!IMPORTANT]
> **SPECIFICATION GOVERNANCE: ACTIVE**
> 
> This template enforces strict compliance rules. All derived projects inherit this governance model.

| Priority | Document | Role |
|:--------:|----------|------|
| 1️⃣ | **DESIGN.md** | Binding constitution — architecture & governance rules |
| 2️⃣ | **LASTENHEFT.md** | Functional requirements specification |
| 3️⃣ | **README.md** | Orientation and navigation only |

**DESIGN.md is the single source of architectural truth.**

---

## 💡 Development Philosophy

This template enforces:

| Principle | Rule | Reference |
|-----------|------|-----------|
| **Governance First** | Rules before code | DES-GOV-01 |
| **Atomic Requirements** | One function per requirement | DES-GOV-33 |
| **Mock First** | Mock before real API integration | DES-GOV-17 |
| **LLM Discipline** | Controlled AI integration | DES-LLM-* |
| **Full Auditability** | Complete change history | DES-GOV-24 |
| **Deterministic Behavior** | Predictability over convenience | DES-GOV-09 |

---

## 🛠️ After Creating Your Project

1. **Run the scaffolding script:**
   ```bash
   chmod +x scaffold_structure.sh
   ./scaffold_structure.sh
   ```

2. **Replace placeholders** in all documents:
   - `{{PROJECT_NAME}}` → Your project name
   - `{{DATE}}` → Current date
   - Update example requirements in LASTENHEFT.md

3. **Start development** following the governance rules in DESIGN.md

---

## 📄 License

MIT License — Copyright (c) 2026 Joern

---

## 🏁 Final Note

This template is **intentionally strict**. The governance overhead exists to support:

- 🤖 AI-assisted development
- 🏢 Enterprise auditability
- 📈 Long-term maintainability
- 🏛️ Architectural integrity

**Welcome to Governance-First Development.**
