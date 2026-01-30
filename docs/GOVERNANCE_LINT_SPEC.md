# Governance Lint Specification (No Code)

Version: 1.9.4  
Datum: 2026-01-30  
Status: Released (Golden Standard)

---

## Purpose
Define a deterministic, scriptable lint specification to verify governance compliance without implementing code here.

## Scope
This specification validates documentation and structural obligations only. It does not evaluate runtime behavior.

## Inputs
- Repository root
- Target branch (default: `main`)
- strict_mode: true

## Mode Configuration (YAML)

```yaml
strict_mode: true
```

**Immutable config:** `strict_mode: true` must not be changed and is mandatory for all lint executions.

## Mandatory Checks (Fail on Violation)

1. **GOV-LINT-01 — DESIGN.md Exists**
   - File: `DESIGN.md`
   - Regex: `^# DESIGN\.md — Project Constitution`
   - Path rule: must exist at repository root

2. **GOV-LINT-02 — LASTENHEFT.md Exists**
   - File: `LASTENHEFT.md`
   - Regex: `^# LASTENHEFT — Enterprise Core Template`
   - Path rule: must exist at repository root

3. **GOV-LINT-03 — Target Platform Declared**
    - Applies only when `INIT_STATUS: COMPLETE` (derived project).
    - `LASTENHEFT.md` contains a non-empty `{{PLATFORM_TARGET}}` replacement.
    - Platform Decision Checklist is fully completed (no unchecked items).
    - Regex: `^{{PLATFORM_TARGET}}$` must be replaced by one of: `Desktop|Web|API-only`
   - Regex: `^### 1\.5 Platform Decision Checklist \(Mandatory\)$`
    - Regex: `- \[x\]` must appear for all checklist items in section 1.5
    - Init marker: `TEMPLATE_USAGE_GUIDE.md` must be set to `INIT_STATUS: COMPLETE` after initialization
   - Section parser: find header `### 1.5 Platform Decision Checklist (Mandatory)` and stop at next `###` or `##`
   - Section rule: every checklist item in this section must be checked

4. **GOV-LINT-04 — Platform Matrix Compliance**
   - Applies only when `INIT_STATUS: COMPLETE` (derived project).
   - If platform == Desktop:
     - `/desktop` exists
     - `/shared` exists
     - `DES-ARCH-04/05/08/15–22` explicitly addressed in documentation
   - If platform == Web:
     - `/frontend` exists
     - `DES-ARCH-01/02/03/06/07/09/10/11` explicitly addressed
   - If platform == API-only:
     - `/ai_service` exists
     - `DES-ARCH-01/02/03/06/09/10/11` explicitly addressed
   - Regex (Desktop): `DES-ARCH-(04|05|08|1[5-9]|2[0-2])`
   - Regex (Web): `DES-ARCH-(01|02|03|06|07|09|10|11)`
   - Regex (API-only): `DES-ARCH-(01|02|03|06|09|10|11)`
   - Path rule (Desktop): `desktop/` and `shared/` directories must exist
   - Path rule (Web): `frontend/` directory must exist
   - Path rule (API-only): `ai_service/` directory must exist
   - Section parser: scan README Platform Matrix for platform row, verify required components/docs/artifacts columns exist
   - Required Artifacts (Desktop):
     - File: `shared/ipc_contracts.md`
     - File: `desktop/runtime_config.md`
     - File: `desktop/packaging.md`
   - Required Artifacts (Web):
     - File: `docs/api_spec.md`
     - File: `frontend/build_config.md`
   - Required Artifacts (API-only):
     - File: `docs/api_spec.md`
     - File: `ai_service/runtime_config.md`
   - Content markers (Desktop artifacts):
     - `shared/ipc_contracts.md` must include headings: `# IPC Contracts`, `## DOC-IPC-01 — Message Types`, `## DOC-IPC-02 — Error Objects`, `## DOC-IPC-03 — Versioning`
     - `desktop/runtime_config.md` must include headings: `# Desktop Runtime Configuration`, `## DOC-DESK-01 — Runtime Choice`, `## DOC-DESK-02 — IPC Bridge`, `## DOC-DESK-03 — Local Storage`, `## DOC-DESK-04 — Packaging Hooks`
     - `desktop/packaging.md` must include headings: `# Desktop Packaging`, `## DOC-PACK-01 — Build Targets`, `## DOC-PACK-02 — Signing`, `## DOC-PACK-03 — Distribution`
     - Expected order (Desktop artifacts):
       - `shared/ipc_contracts.md`: `# IPC Contracts` → `## DOC-IPC-01 — Message Types` → `## DOC-IPC-02 — Error Objects` → `## DOC-IPC-03 — Versioning`
       - `desktop/runtime_config.md`: `# Desktop Runtime Configuration` → `## DOC-DESK-01 — Runtime Choice` → `## DOC-DESK-02 — IPC Bridge` → `## DOC-DESK-03 — Local Storage` → `## DOC-DESK-04 — Packaging Hooks`
       - `desktop/packaging.md`: `# Desktop Packaging` → `## DOC-PACK-01 — Build Targets` → `## DOC-PACK-02 — Signing` → `## DOC-PACK-03 — Distribution`
   - Content markers (Web artifacts):
     - `docs/api_spec.md` must include headings: `# API Specification`, `## DOC-API-01 — Overview`, `## DOC-API-02 — Endpoints`, `## DOC-API-03 — Error Model`, `## DOC-API-04 — Versioning`
     - `frontend/build_config.md` must include headings: `# Frontend Build Configuration`, `## DOC-FE-01 — Build Tool`, `## DOC-FE-02 — Environment Variables`, `## DOC-FE-03 — Output Targets`
     - Expected order (Web artifacts):
       - `docs/api_spec.md`: `# API Specification` → `## DOC-API-01 — Overview` → `## DOC-API-02 — Endpoints` → `## DOC-API-03 — Error Model` → `## DOC-API-04 — Versioning`
       - `frontend/build_config.md`: `# Frontend Build Configuration` → `## DOC-FE-01 — Build Tool` → `## DOC-FE-02 — Environment Variables` → `## DOC-FE-03 — Output Targets`
   - Content markers (API-only artifacts):
     - `docs/api_spec.md` must include headings: `# API Specification`, `## DOC-API-01 — Overview`, `## DOC-API-02 — Endpoints`, `## DOC-API-03 — Error Model`, `## DOC-API-04 — Versioning`
     - `ai_service/runtime_config.md` must include headings: `# Service Runtime Configuration`, `## DOC-BE-01 — Runtime`, `## DOC-BE-02 — Dependencies`, `## DOC-BE-03 — Environment Variables`, `## DOC-BE-04 — Deployment`
     - Expected order (API-only artifacts):
       - `docs/api_spec.md`: `# API Specification` → `## DOC-API-01 — Overview` → `## DOC-API-02 — Endpoints` → `## DOC-API-03 — Error Model` → `## DOC-API-04 — Versioning`
       - `ai_service/runtime_config.md`: `# Service Runtime Configuration` → `## DOC-BE-01 — Runtime` → `## DOC-BE-02 — Dependencies` → `## DOC-BE-03 — Environment Variables` → `## DOC-BE-04 — Deployment`

5. **GOV-LINT-05 — Non-Default Desktop Runtime Justification**
   - Applies only when `INIT_STATUS: COMPLETE` (derived project) and platform == Desktop.
   - If Desktop runtime != Tauri, LASTENHEFT.md contains explicit justification.
   - Regex (default): `^\\- \\[x\\] \\*\\*Default Choice \\(Desktop\\)\\*\\*: Tauri`
   - Regex (justification required): `^\\- \\[x\\] \\*\\*Justification recorded in LASTENHEFT\.md\\*\\*`
   - Section parser: validate within Platform Decision Checklist section

6. **GOV-LINT-06 — Documentation Synchronity**
   - If any non-doc file changed in the last commit, CHANGELOG.md updated.
   - Regex: `^## \\[[0-9]+\\.[0-9]+\\.[0-9]+\\] - [0-9]{4}-[0-9]{2}-[0-9]{2}`
   - Path rule: changes outside `*.md` trigger check for CHANGELOG update

7. **GOV-LINT-07 — History Ordering**
   - Internal doc histories are ascending (old → new).
   - CHANGELOG is descending (new → old).
   - Regex (CHANGELOG): newest version must appear first under `## [Unreleased]`.
   - Section parser: in `CHANGELOG.md`, version headers must be in descending order

8. **GOV-LINT-08 — Placeholder Resolution**
    - No `{{PLACEHOLDER}}` tokens remain in non-template derived projects.
    - Regex: `\\{\\{[A-Z0-9_]+\\}\\}` must not appear after initialization.
    - Path rule: exclude template repository itself (allow placeholders), but fail in derived projects (flag if `INIT_STATUS: COMPLETE` is present)
    - Init marker location: `TEMPLATE_USAGE_GUIDE.md` contains `INIT_STATUS: COMPLETE`

9. **GOV-LINT-09 — DOC-ID Validation**
   - All artifact section IDs must follow strict patterns.
   - Regex (API Spec): `^## DOC-API-(0[1-9]|[1-9][0-9]) — `
   - Regex (IPC Contracts): `^## DOC-IPC-(0[1-9]|[1-9][0-9]) — `
   - Regex (Desktop Runtime): `^## DOC-DESK-(0[1-9]|[1-9][0-9]) — `
   - Regex (Desktop Packaging): `^## DOC-PACK-(0[1-9]|[1-9][0-9]) — `
   - Regex (Frontend Build): `^## DOC-FE-(0[1-9]|[1-9][0-9]) — `
   - Regex (Service Runtime): `^## DOC-BE-(0[1-9]|[1-9][0-9]) — `

10. **GOV-LINT-10 — Allowed Status Values (Required Artifacts Mapping)**
   - In `TECHNICAL_SPEC.md` Section 6, status values must be one of: `Draft|Final|Deprecated`.
   - Regex: `\\| .* \\| (Draft|Final|Deprecated) \\|`

11. **GOV-LINT-11 — Artifact Index Consistency**
   - File: `docs/artifact_index.md` must exist.
   - All DOC-IDs listed in artifact files must appear in `docs/artifact_index.md`.
   - `docs/artifact_index.md` is the single source of truth for DOC-ID enumeration.

12. **GOV-LINT-12 — Artifact Index Ordering**
   - Section order must be: `DOC-API`, `DOC-IPC`, `DOC-DESK`, `DOC-PACK`, `DOC-FE`, `DOC-BE`.
   - Within each section, IDs must be in ascending numeric order.

13. **GOV-LINT-13 — Artifact Index Prefix Sections**
   - Section headings must match `^## DOC-(API|IPC|DESK|PACK|FE|BE)$`.

14. **GOV-LINT-14 — ORDER LOCKED Marker**
   - `docs/artifact_index.md` must contain the exact line `ORDER LOCKED`.
   - Regex: `^ORDER LOCKED$`

15. **GOV-LINT-15 — Artifact Index Update Protocol Enforcement**
   - `docs/artifact_index.md` must include the section header `## Artifact Index Update Protocol`.
   - Regex: `^## Artifact Index Update Protocol$`
   - Required step order within the protocol section:
     1. `Add new DOC-IDs` (must be step 1)
     2. `Update the source artifact file` (must be step 2)
     3. `Keep order locked` (must be step 3)
     4. `Update TECHNICAL_SPEC.md` (must be step 4)
     5. `Update CHANGELOG.md` (must be step 5)
   - Section parser: find `## Artifact Index Update Protocol` and parse ordered list items strictly in sequence.
   - Regex (numbered steps, full-line strict): `^(1\\. Add new DOC-IDs|2\\. Update the source artifact file|3\\. Keep order locked|4\\. Update TECHNICAL_SPEC\\.md|5\\. Update CHANGELOG\\.md)$`

16. **GOV-LINT-16 — ORDER LOCKED Line Position**
   - `ORDER LOCKED` must be line 3 in `docs/artifact_index.md` (1-based).
   - Line 4 must be blank.
   - Line 5 must be `IMMUTABLE HEADER BLOCK (LINES 1–3) — DO NOT EDIT`.
   - Exact header block must match:
     - Line 1: `# Artifact Index`
     - Line 2: `Status: TEMPLATE`
     - Line 3: `ORDER LOCKED`
     - Line 4: empty
    - Line 5: `IMMUTABLE HEADER BLOCK (LINES 1–3) — DO NOT EDIT`

17. **GOV-LINT-17 — Immutable Header Block Policy**
   - `docs/artifact_index.md` must contain `## Immutable Header Block Policy`.
   - Policy must state that lines 1–5 are immutable.

18. **GOV-LINT-18 — Lint Signature Checkbox**
   - `.github/PULL_REQUEST_TEMPLATE.md` must include the checkbox `- [ ] **Lint Signature completed**`.

19. **GOV-LINT-19 — Strict Mode Gate**
   - `strict_mode: true` must be present in `docs/GOVERNANCE_LINT_SPEC.md` and must not be changed.

20. **GOV-LINT-20 — Release Checklist Mirror Rule**
   - `docs/RELEASE_CHECKLIST.md` must include the exact line:
     - `> **Mirror Rule (GOV-LINT-20):** This table must exactly mirror the Release Gate Map in \`docs/GOVERNANCE_LINT_SPEC.md\`.`
   - Regex: `^> \\*\\*Mirror Rule \\(GOV-LINT-20\\):\\*\\* This table must exactly mirror the Release Gate Map in \\`docs/GOVERNANCE_LINT_SPEC\\.md\\`\\.$`

21. **GOV-LINT-21 — PR Checklist Mandatory Line**
   - `.github/PULL_REQUEST_TEMPLATE.md` must include the exact line:
     - `**This checklist is mandatory and must be completed before merge.**`

22. **GOV-LINT-22 — CONTRIBUTING PR Checklist Table**
   - `CONTRIBUTING.md` must contain the PR checklist table with header:
     - `| Item | GOV-LINT ID | Required | Check Regex |`
   - Table must include all five rows with exact GOV-LINT IDs.
   - Regex checks must match each row:
     - `^\\| \\`DESIGN\\.md\\` reviewed for compliance \\| GOV-LINT-01 \\| Yes \\| \\`\\^\\\\- \\\\[ \\\\] DESIGN\\\\.md reviewed for compliance\\$\\` \\|$`
     - `^\\| \\`LASTENHEFT\\.md\\` updated \\(if functional change\\) \\| GOV-LINT-02 \\| Yes \\| \\`\\^\\\\- \\\\[ \\\\] LASTENHEFT\\\\.md updated \\\\(if functional change\\\\)\\$\\` \\|$`
     - `^\\| \\`CHANGELOG\\.md\\` updated \\(version \\+ entry\\) \\| GOV-LINT-06 \\| Yes \\| \\`\\^\\\\- \\\\[ \\\\] CHANGELOG\\\\.md updated \\\\(version \\\\+ entry\\\\)\\$\\` \\|$`
     - `^\\| Lint Signature completed in PR template \\| GOV-LINT-18 \\| Yes \\| \\`\\^\\\\- \\\\[ \\\\] Lint Signature completed\\$\\` \\|$`
     - `^\\| PR template checklist completed \\(\\`\\.github\\/PULL_REQUEST_TEMPLATE\\.md\\`\\) \\| GOV-LINT-21 \\| Yes \\| \\`\\^\\\\- \\\\[ \\\\] PR template checklist completed \\\\(\\\\.github\\/PULL_REQUEST_TEMPLATE\\\\.md\\\\)\\$\\` \\|$`

23. **GOV-LINT-23 — Release Gate Map Immutable**
   - `docs/RELEASE_CHECKLIST.md` must include the exact header:
     - `## 8. Release Gate (Must-Pass) — IMMUTABLE TABLE`

24. **GOV-LINT-24 — PR Checklist Immutable Section**
   - `.github/PULL_REQUEST_TEMPLATE.md` must include the exact line:
     - `## PR Workflow Checklist (Mandatory) — IMMUTABLE SECTION`

25. **GOV-LINT-25 — PR Checklist Items Exact**
   - `.github/PULL_REQUEST_TEMPLATE.md` must include the exact checklist items:
     - `- [ ] DESIGN.md reviewed for compliance`
     - `- [ ] LASTENHEFT.md updated (if functional change)`
     - `- [ ] CHANGELOG.md updated (version + entry)`
     - `- [ ] Lint Signature completed`
     - `- [ ] PR template checklist completed (.github/PULL_REQUEST_TEMPLATE.md)`

26. **GOV-LINT-26 — Release Gate Immutable Marker**
   - `docs/RELEASE_CHECKLIST.md` must include the exact line:
     - `IMMUTABLE TABLE — DO NOT EDIT`

27. **GOV-LINT-27 — Release Checklist Update Protocol**
   - `docs/RELEASE_CHECKLIST.md` must include the header:
     - `## 9. Release Checklist Update Protocol (Mandatory)`
   - Required steps (exact order):
     1. `Update docs/GOVERNANCE_LINT_SPEC.md rules if checklist changes.`
     2. `Update docs/RELEASE_CHECKLIST.md content and version.`
     3. `Update CHANGELOG.md with a new version entry.`
     4. `Update README version badge.`

28. **GOV-LINT-28 — Release Checklist Lint Signature Header**
   - `docs/RELEASE_CHECKLIST.md` must include:
     - `## 6. Lint Signature (Mandatory)`

29. **GOV-LINT-29 — Release Checklist Strict Mode Line**
   - `docs/RELEASE_CHECKLIST.md` must include:
     - `- **Strict Mode Parameter:** \`strict_mode: true\``

30. **GOV-LINT-30 — Release Checklist Lint Signature Checkbox**
   - `docs/RELEASE_CHECKLIST.md` must include:
     - `- [ ] **Lint Signature completed** — Sign-off: ______________________`

31. **GOV-LINT-31 — Release Checklist Update Protocol Steps Regex**
   - `docs/RELEASE_CHECKLIST.md` must include exact step lines:
     - `1. Update docs/GOVERNANCE_LINT_SPEC.md rules if checklist changes.`
     - `2. Update docs/RELEASE_CHECKLIST.md content and version.`
     - `3. Update CHANGELOG.md with a new version entry.`
     - `4. Update README version badge.`

32. **GOV-LINT-32 — Release Checklist Update Protocol Order**
   - Steps must appear in numeric order 1–4 with exact wording.

33. **GOV-LINT-33 — Release Checklist Mirror Rule Label**
   - `docs/RELEASE_CHECKLIST.md` must contain:
     - `> **Mirror Rule (GOV-LINT-20):** This table must exactly mirror the Release Gate Map in \`docs/GOVERNANCE_LINT_SPEC.md\`.`

34. **GOV-LINT-34 — Release Checklist Lint Readiness Block**
   - `docs/RELEASE_CHECKLIST.md` must include:
     - `- [ ] **Lint Readiness (Mandatory):**`

35. **GOV-LINT-35 — Release Checklist Lint Readiness Regex**
   - `docs/RELEASE_CHECKLIST.md` must include regex entries for:
     - `^# Artifact Index$`
     - `^Status: TEMPLATE$`
     - `^ORDER LOCKED$`
     - `^IMMUTABLE HEADER BLOCK \\(LINES 1–3\\) — DO NOT EDIT$`
## Output
- Exit code `0` on success
- Non-zero on any failed check with explicit error message per violation

---

## Expected Section Order (Machine-Readable YAML)

```yaml
artifacts:
  docs/api_spec.md:
    - "# API Specification"
    - "## DOC-API-01 — Overview"
    - "## DOC-API-02 — Endpoints"
    - "## DOC-API-03 — Error Model"
    - "## DOC-API-04 — Versioning"
  shared/ipc_contracts.md:
    - "# IPC Contracts"
    - "## DOC-IPC-01 — Message Types"
    - "## DOC-IPC-02 — Error Objects"
    - "## DOC-IPC-03 — Versioning"
  desktop/runtime_config.md:
    - "# Desktop Runtime Configuration"
    - "## DOC-DESK-01 — Runtime Choice"
    - "## DOC-DESK-02 — IPC Bridge"
    - "## DOC-DESK-03 — Local Storage"
    - "## DOC-DESK-04 — Packaging Hooks"
  desktop/packaging.md:
    - "# Desktop Packaging"
    - "## DOC-PACK-01 — Build Targets"
    - "## DOC-PACK-02 — Signing"
    - "## DOC-PACK-03 — Distribution"
  frontend/build_config.md:
    - "# Frontend Build Configuration"
    - "## DOC-FE-01 — Build Tool"
    - "## DOC-FE-02 — Environment Variables"
    - "## DOC-FE-03 — Output Targets"
  ai_service/runtime_config.md:
    - "# Service Runtime Configuration"
    - "## DOC-BE-01 — Runtime"
    - "## DOC-BE-02 — Dependencies"
    - "## DOC-BE-03 — Environment Variables"
    - "## DOC-BE-04 — Deployment"
```

---

## Strict Mode

When strict mode is enabled:
- Any deviation from required regex patterns fails the lint immediately.
- Header block (lines 1–5) in `docs/artifact_index.md` must match exactly.
- Update Protocol list must be numbered 1–5 with exact wording.
- No extra sections are allowed between header block and `## Immutable Header Block Policy`.

**Strict mode is enabled by default.**

---

## GOV-LINT Index

| ID | Title |
|----|-------|
| GOV-LINT-01 | DESIGN.md Exists |
| GOV-LINT-02 | LASTENHEFT.md Exists |
| GOV-LINT-03 | Target Platform Declared |
| GOV-LINT-04 | Platform Matrix Compliance |
| GOV-LINT-05 | Non-Default Desktop Runtime Justification |
| GOV-LINT-06 | Documentation Synchronity |
| GOV-LINT-07 | History Ordering |
| GOV-LINT-08 | Placeholder Resolution |
| GOV-LINT-09 | DOC-ID Validation |
| GOV-LINT-10 | Allowed Status Values (Required Artifacts Mapping) |
| GOV-LINT-11 | Artifact Index Consistency |
| GOV-LINT-12 | Artifact Index Ordering |
| GOV-LINT-13 | Artifact Index Prefix Sections |
| GOV-LINT-14 | ORDER LOCKED Marker |
| GOV-LINT-15 | Artifact Index Update Protocol Enforcement |
| GOV-LINT-16 | ORDER LOCKED Line Position |
| GOV-LINT-17 | Immutable Header Block Policy |
| GOV-LINT-18 | Lint Signature Checkbox |
| GOV-LINT-19 | Strict Mode Gate |
| GOV-LINT-20 | Release Checklist Mirror Rule |
| GOV-LINT-21 | PR Checklist Mandatory Line |
| GOV-LINT-22 | CONTRIBUTING PR Checklist Table |
| GOV-LINT-23 | Release Gate Map Immutable |
| GOV-LINT-24 | PR Checklist Immutable Section |
| GOV-LINT-25 | PR Checklist Items Exact |
| GOV-LINT-26 | Release Gate Immutable Marker |
| GOV-LINT-27 | Release Checklist Update Protocol |
| GOV-LINT-28 | Release Checklist Lint Signature Header |
| GOV-LINT-29 | Release Checklist Strict Mode Line |
| GOV-LINT-30 | Release Checklist Lint Signature Checkbox |
| GOV-LINT-31 | Release Checklist Update Protocol Steps Regex |
| GOV-LINT-32 | Release Checklist Update Protocol Order |
| GOV-LINT-33 | Release Checklist Mirror Rule Label |
| GOV-LINT-34 | Release Checklist Lint Readiness Block |
| GOV-LINT-35 | Release Checklist Lint Readiness Regex |

---

## Must-Pass Enforcement

The following GOV-LINT checks are **mandatory** and must pass for any release:
- GOV-LINT-08
- GOV-LINT-15
- GOV-LINT-16
- GOV-LINT-17
- GOV-LINT-18
- GOV-LINT-19
- GOV-LINT-20
- GOV-LINT-21
- GOV-LINT-22
- GOV-LINT-23
- GOV-LINT-24
- GOV-LINT-25
- GOV-LINT-26
- GOV-LINT-27
- GOV-LINT-28
- GOV-LINT-29
- GOV-LINT-30
- GOV-LINT-31
- GOV-LINT-32
- GOV-LINT-33
- GOV-LINT-34
- GOV-LINT-35

---

## Release Gate Map

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

> **Mirror Rule (GOV-LINT-20):** This table must exactly mirror the Release Gate Map in `docs/RELEASE_CHECKLIST.md`.
