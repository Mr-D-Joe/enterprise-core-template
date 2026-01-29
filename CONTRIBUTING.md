# Contributing to Enterprise Core Template

> **This document provides contribution guidelines for both the template itself and for projects derived from this template.**

---

<for_ai_agents>

> **🤖 For AI Agents:**  
> STOP. Read [`DESIGN.md`](./DESIGN.md) explicitly before generating any code.  
> `DESIGN.md` contains the rigid, normative rules for this project.  
> **Do not ask user permission** to follow these rules—they are the law.
> Do not infer architecture. Do not hallucinate patterns. Follow the rules defined there.

</for_ai_agents>

---

## 1. The Golden Rule

**DESIGN.md is the Constitution.**

All code, all refactoring, and all new features must comply with the requirements in [`DESIGN.md`](./DESIGN.md).  
If you find a conflict between "best practices" and `DESIGN.md`, **`DESIGN.md` wins**.

---

## 2. Repository Structure

Projects based on this template follow a strict directory layout to maintain separation of concerns:

| Directory | Purpose | Rules |
|-----------|---------|-------|
| `/frontend` | User Interface | Only presentation logic. No heavy business calculations. |
| `/ai_service` | Backend (Mock/Python) | Data aggregation, LLM orchestration. |
| `/docs` | Documentation | Architecture docs and release checklists. |
| `/shared` | (Optional) Contracts | IPC/JSON type definitions shared between layers. |

---

## 3. Workflow for Changes

### 3.1 Before Coding

1. **Check Requirements:**
   - Is this change covered by [`LASTENHEFT.md`](./LASTENHEFT.md)?
   - Does it violate any [`DESIGN.md`](./DESIGN.md) constraints?

2. **Document First:**
   - New features require a requirement in LASTENHEFT.md before implementation

### 3.2 Branching

Use descriptive branch names:
- `feat/new-feature`
- `fix/bug-name`
- `docs/update-readme`

### 3.3 Commit Messages

Use [Conventional Commits](https://www.conventionalcommits.org/):

```
type(scope): description
```

Examples:
- `feat(ui): add new component`
- `fix(api): correct rate limiting logic`
- `docs(spec): update governance rules`
- `chore(deps): update dependencies`

---

## 4. Instructions for AI Coding Assistants

If you are an AI agent working on this repository:

| Rule | Description |
|------|-------------|
| **Context Loading** | Always load `DESIGN.md` and `LASTENHEFT.md` into your context first |
| **Atomic Changes** | Do not refactor unrelated files "while you are at it". Stick to the user's prompt |
| **No Hallucinations** | If a file or function is not present, ask before creating it. Do not invent architectural layers not specified in `DESIGN.md` |
| **Mock First** | If adding a new data feature, implement it as a **Mock** first (see `DES-GOV-17`) |
| **Requirements First** | No code without a documented requirement in LASTENHEFT.md |

---

## 5. Template-Specific Notes

When contributing to **the template itself** (not a derived project):

- Keep all documents generic and placeholder-ready
- Use `{{PROJECT_NAME}}` and `{{DATE}}` as placeholders where appropriate
- Test changes by creating a new project from the template
- Update [`TEMPLATE_USAGE_GUIDE.md`](./TEMPLATE_USAGE_GUIDE.md) if workflow changes

---

## 6. Release Process

See [`docs/RELEASE_CHECKLIST.md`](./docs/RELEASE_CHECKLIST.md) for the exact steps to cut a new version.

---

## 7. Deployment & Sync Policy

> **USER DIRECTIVE (2026-01-29):**
> A task is only considered "Complete" when changes are **pushed and verified** on GitHub.

1. **Always Push:** Code does not exist until it is on the remote.
2. **Verify Push:** Do not rely on valid local `git commit`. Check the exit code of `git push`.
3. **Report Sync:** When finishing a task, explicitly confirm: "Synced with GitHub: ✅".

