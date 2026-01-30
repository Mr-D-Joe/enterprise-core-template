# Release Checklist

**Target Audience:** Release Managers & Automation Agents  
**Scope:** Creating a new versioned release (e.g., `v1.3`).

Version: 1.9.3  
Datum: 2026-01-30  
Status: Released (Golden Standard)

---

## 1. Pre-Flight Check

- [ ] **Clean Working Tree:** `git status` must show no uncommitted changes.
- [ ] **Tests:** All local tests must pass.
- [ ] **Linting:** Code must adhere to style guides.

## 2. Specification Governance

- [ ] **Scan `LASTENHEFT.md`:** Does it contain *only* functional requirements?
- [ ] **Scan `DESIGN.md`:** Are governance/architecture changes reflected here?
- [ ] **Check Consistency:** Do requirement IDs match implementations?

## 2.1 Governance-Lint (Mandatory)

- [ ] **Platform Decision Present:** `LASTENHEFT.md` explicitly defines `{{PLATFORM_TARGET}}` and the Platform Decision Checklist is completed.
- [ ] **Desktop Conditionality:** If platform is Desktop, `DES-ARCH-04/05/08/15–22` are addressed and `/desktop` exists.
- [ ] **Non-Default Desktop Choice:** If Electron is used, explicit justification is recorded in `LASTENHEFT.md`.
- [ ] **Documentation Sync:** Updated docs per DES-GOV-49 (CHANGELOG/README/LASTENHEFT).
- [ ] **History Order:** Internal histories are ascending, CHANGELOG descending (DES-GOV-50).
- [ ] **Governance-Lint Spec:** `docs/GOVERNANCE_LINT_SPEC.md` reviewed for completeness.
- [ ] **Governance Lint Script:** `./scripts/governance_lint.sh` passes.
- [ ] **Initialization Status:** `INIT_STATUS: COMPLETE` set only after checklist completion.
- [ ] **Artifacts Mapping Gate:** `TECHNICAL_SPEC.md` Section 6 completed for required artifacts.
- [ ] **Artifact Index Marker:** `docs/artifact_index.md` contains `ORDER LOCKED`.
- [ ] **Lint Readiness (Mandatory):**
  - [ ] `docs/artifact_index.md` header block regex (lines 1–5) (GOV-LINT-16):
    - `^# Artifact Index$`
    - `^Status: TEMPLATE$`
    - `^ORDER LOCKED$`
    - `^$`
    - `^IMMUTABLE HEADER BLOCK \(LINES 1–3\) — DO NOT EDIT$`
  - [ ] `docs/artifact_index.md` update protocol markers (GOV-LINT-15):
    - `^## Artifact Index Update Protocol$`
    - `^(1\\. Add new DOC-IDs|2\\. Update the source artifact file|3\\. Keep order locked|4\\. Update TECHNICAL_SPEC\\.md|5\\. Update CHANGELOG\\.md)$`
  - [ ] `TEMPLATE_USAGE_GUIDE.md` placeholder rule (GOV-LINT-08):
    - No `\\{\\{[A-Z0-9_]+\\}\\}` remains when `INIT_STATUS: COMPLETE`.

## 3. Documentation Update

- [ ] **Update `CHANGELOG.md`:**
  - Add new version header `## [vX.Y] - YYYY-MM-DD`.
  - Categories: `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`.
- [ ] **Update Version Numbers:** Check project configuration files (e.g. `package.json`) and `LASTENHEFT.md` header.

## 4. Git Operations

1. **Commit Release:**
   ```bash
   git add .
   git commit -m "chore(release): prepare release vX.Y"
   ```

2. **Tagging:**
   ```bash
   git tag -a vX.Y -m "Release vX.Y - [Short Summary]"
   ```

3. **Push:**
   ```bash
   git push origin main vX.Y
   ```

---

## 5. GitHub Release

- [ ] Go to GitHub UI -> Releases -> Draft a new release.
- [ ] Select tag `vX.Y`.
- [ ] Paste `CHANGELOG.md` content for this version into the description.
- [ ] Publish.

## 6. Lint Signature (Mandatory)

- **Reviewed By:** ______________________
- **Date (YYYY-MM-DD):** __________________
- **Strict Mode Confirmed:** ☐ Yes  ☐ No
- **Strict Mode Parameter:** `strict_mode: true`
- [ ] **Lint Signature completed** — Sign-off: ______________________

**Strict Mode Immutable:** `strict_mode: true` must not be changed.

## 6.1 Strict Mode Gate (Mandatory)

- [ ] `strict_mode: true` verified in `docs/GOVERNANCE_LINT_SPEC.md`

## 7. GOV-LINT Reference Table

| ID | Title | Must-Pass |
|----|-------|-----------|
| GOV-LINT-08 | Placeholder Resolution | Yes |
| GOV-LINT-15 | Artifact Index Update Protocol Enforcement | Yes |
| GOV-LINT-16 | ORDER LOCKED Line Position | Yes |
| GOV-LINT-17 | Immutable Header Block Policy | Yes |
| GOV-LINT-18 | Lint Signature Checkbox | Yes |

## 8. Release Gate (Must-Pass) — IMMUTABLE TABLE

IMMUTABLE TABLE — DO NOT EDIT

| GOV-LINT ID | Required |
|-------------|----------|
| GOV-LINT-08 | Yes |
| GOV-LINT-15 | Yes |
| GOV-LINT-16 | Yes |
| GOV-LINT-17 | Yes |
| GOV-LINT-18 | Yes |
| GOV-LINT-19 | Yes |
| GOV-LINT-20 | Yes |
| GOV-LINT-21 | Yes |
| GOV-LINT-22 | Yes |
| GOV-LINT-23 | Yes |
| GOV-LINT-24 | Yes |
| GOV-LINT-25 | Yes |
| GOV-LINT-26 | Yes |
| GOV-LINT-27 | Yes |
| GOV-LINT-28 | Yes |
| GOV-LINT-29 | Yes |
| GOV-LINT-30 | Yes |
| GOV-LINT-31 | Yes |
| GOV-LINT-32 | Yes |
| GOV-LINT-33 | Yes |
| GOV-LINT-34 | Yes |
| GOV-LINT-35 | Yes |

> **Mirror Rule (GOV-LINT-20):** This table must exactly mirror the Release Gate Map in `docs/GOVERNANCE_LINT_SPEC.md`.

## 9. Release Checklist Update Protocol (Mandatory)

1. Update `docs/GOVERNANCE_LINT_SPEC.md` rules if checklist changes.
2. Update `docs/RELEASE_CHECKLIST.md` content and version.
3. Update `CHANGELOG.md` with a new version entry.
4. Update README version badge.

---

**Confidentiality:** This process ensures auditability. Do not skip steps.
