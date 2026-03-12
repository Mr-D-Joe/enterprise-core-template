#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EXIT_CODE=0

req_file() {
  local f="$1"
  if [[ ! -f "$f" ]]; then
    echo "FAIL missing required file: $f"
    EXIT_CODE=1
  else
    echo "OK   $f"
  fi
}

req_exec() {
  local f="$1"
  if [[ ! -x "$f" ]]; then
    echo "FAIL required executable missing or not executable: $f"
    EXIT_CODE=1
  else
    echo "OK   executable $f"
  fi
}

echo "Running independent audit readiness check..."

req_file "$BASE_DIR/DESIGN.md"
req_file "$BASE_DIR/AGENTS.md"
req_file "$BASE_DIR/CONTRIBUTING.md"
req_file "$BASE_DIR/PROMPTS.md"
req_file "$BASE_DIR/LASTENHEFT.md"
req_file "$BASE_DIR/docs/BACKLOG.md"
req_file "$BASE_DIR/docs/STARTUP_CHECKLIST.md"
req_file "$BASE_DIR/CHANGELOG.md"
req_file "$BASE_DIR/docs/governance/INDEPENDENT_AUDIT_POLICY.md"
req_file "$BASE_DIR/docs/governance/ISO_CONTROL_MATRIX_TEMPLATE.md"
req_file "$BASE_DIR/docs/governance/AUDIT_REPORT_TEMPLATE.md"
req_file "$BASE_DIR/docs/governance/TRACEABILITY_MATRIX_TEMPLATE.md"
req_file "$BASE_DIR/docs/governance/DELIVERY_PIPELINE_PROTOCOL.md"
req_file "$BASE_DIR/docs/governance/GITHUB_RELEASE_PROTOCOL.md"
req_file "$BASE_DIR/docs/governance/FOUR_EYES_GATING.md"
req_file "$BASE_DIR/scripts/gates/dev_gate.sh"
req_file "$BASE_DIR/scripts/gates/audit_gate.sh"
req_exec "$BASE_DIR/scripts/gates/dev_gate.sh"
req_exec "$BASE_DIR/scripts/gates/audit_gate.sh"

if [[ -f "$BASE_DIR/docs/governance/PROJECT_STARTER_CHECKLIST.md" ]]; then
  echo "FAIL legacy checklist file still active: $BASE_DIR/docs/governance/PROJECT_STARTER_CHECKLIST.md"
  EXIT_CODE=1
else
  echo "OK   no legacy project starter checklist file"
fi

check_contains() {
  local file="$1"
  local pattern="$2"
  local reason="$3"
  if grep -Fq -- "$pattern" "$file"; then
    echo "OK   $reason"
  else
    echo "FAIL $reason ($file)"
    EXIT_CODE=1
  fi
}

extract_design_value() {
  local key="$1"
  local raw
  raw="$(tr -d '`' < "$BASE_DIR/DESIGN.md" | grep -Eo "${key}=[^[:space:]]+" | head -n1 || true)"
  if [[ -n "$raw" ]]; then
    echo "${raw#*=}"
  fi
}

extract_file_metadata_value() {
  local file="$1"
  local key="$2"
  local raw
  raw="$(grep -E "^- ${key}=" "$file" | head -n1 || true)"
  if [[ -n "$raw" ]]; then
    echo "${raw#*- ${key}=}"
  fi
}

check_contains "$BASE_DIR/DESIGN.md" "GOV-06 Independent Audit Mandatory" "Independent audit rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-07 Four-Eyes Enforcement" "Four-eyes rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-08 Audit Input Separation" "Audit input separation rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-14 Mandatory Gate Failure Semantics" "Mandatory fail semantics in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-15 ISO-Aligned Evidence Package" "ISO evidence rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-18 Security and Privacy by Default" "Security/privacy default rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-19 Security Baseline Currency" "Security baseline currency rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-20 Key and Secret Management" "Key/secret management rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-21 Privacy and Logging Controls" "Privacy/logging rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-22 ISO-Conform Security/Data Audit Depth" "ISO-conform security/data depth rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-23 Security Baseline Freshness Gate" "Security baseline freshness gate in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-24 Technology Decision Before Build" "Tooling decision pre-build rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-25 Currency and Stability Gate" "Tooling currency/stability rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-26 Official Source Requirement for Tooling" "Tooling official-source rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-27 Profile-First Tool Selection" "Profile-first tooling rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-28 Type-Safe UI Default" "Type-safe UI default rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-29 Runtime and Compiler Currency" "Runtime/compiler currency rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-30 Root-Only Python Environment" "Root-only Python environment rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-31 Serial Change Package Lock" "Serial change package lock rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-32 Per-Requirement Test Pair Coverage" "Per-REQ test pair coverage rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-33 Backlog and Package Metadata Freshness" "Backlog/package freshness rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-34 Machine-Generated Planning Metrics" "Machine-generated planning metrics rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-35 No Active Document Duplication" "No document duplication rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-36 Test Partition Enforcement" "Test partition rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-37 Performance Budget Gate" "Performance budget gate rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-38 Structural Size Gate" "Structural size gate rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-39 Runtime Fitness Review Cadence" "Runtime fitness cadence rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-40 Standardized Waiver Mechanism" "Waiver mechanism rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-41 Secure Runtime Defaults" "Secure runtime defaults rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-42 Error Disclosure Boundary" "Error disclosure boundary rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-43 No Silent Error Masking" "No silent error masking rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-44 Canonical Runtime Contract" "Canonical runtime contract rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-45 Dependency and Supply-Chain Baseline" "Dependency/supply-chain baseline rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-46 Persistence Schema Versioning and Migration Strategy" "Persistence migration strategy rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "GOV-47 Version Single Source of Truth" "Version single-source rule in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "SECURITY_BASELINE_REVIEW_UTC=" "Security baseline review metadata in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "SECURITY_BASELINE_MAX_AGE_DAYS=" "Security baseline max-age metadata in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "SECURITY_BASELINE_SOURCES=" "Security baseline source metadata in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "TOOLING_DECISION_REVIEW_UTC=" "Tooling decision review metadata in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "PLANNING_METADATA_MAX_AGE_DAYS=" "Planning metadata max-age in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "RUNTIME_FITNESS_REVIEW_UTC=" "Runtime fitness review date in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "RUNTIME_FITNESS_MAX_AGE_DAYS=" "Runtime fitness max-age in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "PYTHON_MODULE_LOC_LIMIT=900" "Python module LOC limit in DESIGN"

check_contains "$BASE_DIR/AGENTS.md" "PO (Product Owner) — primary control strand" "PO role in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "default customer-facing operating role" "Default PO role in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "DEV (Implementation) — execution strand" "DEV role in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "AUDIT (Independent) — execution strand" "AUDIT role in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" 'distinct identities (`AGENT_ID` and runtime evidence)' "Identity separation in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "No self-approval" "No self-approval in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "Audit input firewall" "Audit firewall in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "Security and privacy non-negotiables" "Security/privacy section in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "No hardcoded credentials, API keys, tokens, or private certificates" "No hardcoded secrets rule in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "No secret or personal data exfiltration" "No secret/PII exfiltration rule in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "ISO-conform security/data checklist" "ISO-conform checklist enforcement in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "Runtime bootstrap autonomy (customer-safe)" "Runtime bootstrap autonomy section in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "Customer-facing instructions to run setup commands manually are forbidden." "No customer manual setup rule in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" 'Python virtual environment location is fixed to project root `.venv` only.' "Root-only Python venv rule in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "Runtime/compiler selections for active scope must target latest stable versions with dated official-source evidence." "Latest-stable runtime/compiler rule in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "Single active change package lock" "Single active package section in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "PO must not issue a new DEV or AUDIT role packet while the current package is not closed." "PO package lock rule in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "Requirement -> DEV -> AUDIT -> PR -> Merge -> Version -> Clean Desk" "Clean-desk sequence in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "package-internal defects within approved scope" "Package-internal defect closure rule in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "security/runtime/error-contract/migration/version-drift defects unresolved" "No unresolved runtime/security/error/migration/version defects rule in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "secure runtime defaults, error-contract boundary, runtime-contract consistency, dependency/supply-chain risk evidence, migration strategy, and version-source consistency" "AUDIT explicit runtime/security/error/migration/version review rule in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "Unsichere Runtime-Defaults, Exception-Leaks an Clients, oder stilles Error-Masking" "Explicit prohibition of insecure defaults/exception leaks/silent masking in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "Per-Requirement test execution minimum" "Per-REQ test execution section in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" 'at least one executed positive test (`PASS`) and' "Per-REQ positive test minimum in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" 'at least one executed negative test (`PASS`).' "Per-REQ negative test minimum in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "Total executed test count for the active package must be greater than zero." "Non-zero test count rule in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "Package-level executed positive test count must be greater than zero." "Package-level positive test count rule in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "Package-level executed negative test count must be greater than zero." "Package-level negative test count rule in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" '`DESIGN.md` is the only normative source for architecture/governance fundamentals.' "DESIGN single-source rule in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" '`PROMPTS.md` is runtime-only and must not redefine architecture/governance fundamentals from `DESIGN.md`.' "PROMPTS runtime-only rule in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "Planning, performance, and waiver controls" "Planning/performance section in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" '`docs/BACKLOG.md` and active package plan metadata must be synchronized before DEV start.' "Backlog sync rule in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" '`LASTENHEFT.md` and `docs/BACKLOG.md` metrics must be machine-generated only' "Machine-generated planning metrics rule in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" 'unit: `pytest -m "not integration"`' "Unit test partition command in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" 'integration: `pytest -m integration`' "Integration test partition command in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" 'Performance evidence for active scope must include explicit budget result (minimum `p95`) before release.' "Performance budget rule in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "Python module size limit above 900 LOC is release-blocking unless an active machine-readable waiver exists." "Module size rule in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "Waivers must be machine-readable, PO-approved, scope-bound, and time-bounded with explicit expiry." "Waiver rule in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "machine-readable artifact with required keys" "Role packet artifact requirement in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "allowed_inputs_hash" "Role packet key list in AGENTS"

check_contains "$BASE_DIR/CONTRIBUTING.md" "Requirement definition and approval (PO)" "Requirement phase in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Concurrent/overlapping change packages are forbidden." "No-overlap rule in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" '`docs/BACKLOG.md`, active package metadata, and `LASTENHEFT.md` machine metrics are synchronized and fresh' "Backlog/package/LASTENHEFT freshness criterion in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" '`LASTENHEFT.md` and `docs/BACKLOG.md` include machine-generated metadata' "Machine-generated planning metadata criterion in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Independent Audit gate (AUDIT)" "Audit phase in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Hard blockers (automatic FAIL)" "Hard blockers in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "NOT_READY_FOR_RELEASE" "Release fail semantics in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "security/privacy checks executed and linked" "Security/privacy checks in DEV phase"
check_contains "$BASE_DIR/CONTRIBUTING.md" "secure runtime defaults are verified for production runtime profile" "Secure runtime defaults criterion in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "no raw internal exception details are exposed in client-facing contracts" "No exception leak criterion in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "no silent error masking returns success-shaped fallback values for failure states" "No silent masking criterion in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "runtime contract is consistent (port/interpreter/start command/env keys)" "Runtime contract consistency criterion in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "dependency vulnerability and supply-chain evidence is linked" "Dependency/supply-chain evidence criterion in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "persistence changes include schema versioning and migration strategy" "Migration strategy criterion in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "version sources are synchronized to one canonical source of truth" "Version source consistency criterion in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" 'runtime bootstrap executed automatically (`.env` and required toolchain setup) with evidence artifact' "Runtime bootstrap DEV criterion in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" 'Missing runtime bootstrap evidence for active `REQ_IDS`.' "Runtime bootstrap blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Customer-facing manual runtime/setup instructions issued by DEV." "Customer-manual-setup blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Missing security/privacy traceability or missing security/privacy evidence." "Security/privacy blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Hardcoded secrets/keys/tokens or unredacted personal data" "Secret/PII blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Missing ISO security/data control verdicts in audit report." "ISO security/data verdict blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Security baseline age exceeds configured maximum age." "Security baseline age blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "machine-readable PO role packet exists with required keys" "Role packet entry criterion in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Missing required role packet keys" "Role packet key blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Missing required tooling decision keys" "Tooling decision key blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" 'Python virtual environment not located at project root `.venv`.' "Root-only Python venv blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Missing latest-stable runtime/compiler evidence for active scope." "Latest-stable runtime/compiler blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Unsichere Runtime-Defaults." "Insecure runtime defaults blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Exception-Leak." "Exception leak blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Error-Masking." "Silent masking blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Runtime-Widerspruch." "Runtime contradiction blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Fehlende Dependency-Sicherheitsprüfung." "Missing dependency security check blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Persistenz ohne Migrationen." "Persistence without migrations blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Versionsdrift." "Version drift blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Stale or unsynchronized backlog/package metadata" "Stale backlog blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" 'Missing machine-generated metadata (`generated_at_utc`, `source_commit_sha`) in `LASTENHEFT.md` or `docs/BACKLOG.md`.' "Planning metadata blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Additional active prompt/governance contract files outside canonical set" "Redundant contract blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "New package started while previous package is not closed" "Open-package blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Stopping before PR -> Merge -> Version -> Clean Desk although all prior mandatory gates passed." "Premature stop blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "DEV or AUDIT release-path evaluation performed only on uncommitted working-tree state." "Uncommitted-state blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Fixed package-internal blocker without rerunning required gates." "Rerun-after-fix blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "stale local package residues left behind after closure." "Clean-desk residue blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" 'deterministic tests executed and linked with per-`REQ_ID` coverage (minimum one positive and one negative test)' "Per-REQ test coverage criterion in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" 'pytest -m "not integration"' "Unit test partition command in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "pytest -m integration" "Integration test partition command in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" 'each active `REQ_ID` has executed positive+negative test evidence and package test count is greater than zero' "AUDIT per-REQ test coverage criterion in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "package-level executed positive test count is greater than zero and executed negative test count is greater than zero" "AUDIT package-level positive/negative count criterion in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" 'Missing per-`REQ_ID` test coverage evidence (minimum one executed positive and one executed negative test).' "Per-REQ test coverage blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" 'Missing separated Python test partition evidence (`pytest -m "not integration"` and `pytest -m integration`) when Python tests are in scope.' "Split test evidence blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Total executed test count for active package equals zero." "Zero-test blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Executed positive test count for active package equals zero." "Zero-positive blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Executed negative test count for active package equals zero." "Zero-negative blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" 'Missing performance budget evidence (`p95`) for active release scope.' "Performance evidence blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Python module exceeds 900 LOC without active valid waiver evidence." "Module size blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Waiver is missing required keys, expired, or not PO-approved." "Waiver blocker in CONTRIBUTING"

check_contains "$BASE_DIR/PROMPTS.md" "AUDIT execution mode contract" "AUDIT mode section in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "Scope note:" "Scope note section in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" '`DESIGN.md` defines fundamental governance/architecture rules.' "DESIGN fundamental scope in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "Default operating role (mandatory)" "Default operating role section in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "PO autonomy default (mandatory)" "PO autonomy default section in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "DEV completion expectation (mandatory)" "DEV completion expectation section in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "AUDIT orchestration by PO" "AUDIT orchestration section in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "Mandatory package closure" "Mandatory package closure section in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "Forbidden input set" "Forbidden audit inputs in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "run runtime bootstrap protocol before implementation" "Runtime bootstrap protocol in DEV mode in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "ask customer to run manual environment/setup commands." "No customer manual setup in DEV mode in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'select `application_profile` from `DESIGN.md` section 1.1 before selecting tools' "Application profile selection in DEV mode in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "keep production choices on stable/LTS channels unless PO-approved exception exists" "Stable/LTS tooling choice rule in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'enforce Python venv path at project root `.venv` only' "Root-only Python venv rule in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "target latest stable runtime/compiler versions unless PO-approved exception exists" "Latest-stable runtime/compiler rule in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "Only one active change package is allowed at any time." "Single active package rule in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "ensure no open package conflict exists before starting a new package;" "PO open-package check in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" '`docs/BACKLOG.md`, active PO package plan, `LASTENHEFT.md` machine metrics' "PO backlog/package/LASTENHEFT freshness rule in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "deterministic positive and negative test vectors and evidence paths." "PO positive/negative test vector rule in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'provide at least one executed positive and one executed negative test per active `REQ_ID`;' "DEV per-REQ test execution rule in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'execute separated test partitions for Python scope: unit (`pytest -m "not integration"`) and integration (`pytest -m integration`);' "DEV split test execution rule in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "secure runtime defaults are verified for release scope" "DEV secure-runtime-defaults completion rule in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "no raw internal exceptions are exposed in client-facing responses" "DEV no-exception-leak completion rule in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "no silent error masking reports failure paths as success values" "DEV no-silent-masking completion rule in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "runtime contract is consistent (port/interpreter/start command/env keys)" "DEV runtime contract consistency completion rule in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "dependency/supply-chain vulnerability evidence exists for release scope" "DEV dependency/supply-chain completion rule in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "persistence changes include schema versioning and migration strategy" "DEV migration strategy completion rule in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "version source-of-truth is consistent across manifest/build/release artifacts" "DEV version-source consistency completion rule in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "PO must trigger AUDIT immediately after successful committed-state DEV completion for the active package." "Immediate AUDIT trigger rule in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'verify for each active `REQ_ID`: at least one executed positive and one executed negative test with evidence references;' "AUDIT per-REQ test verification rule in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "verify total executed tests for active package is greater than zero;" "AUDIT non-zero test count rule in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "verify executed positive test count for active package is greater than zero;" "AUDIT positive test count rule in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "verify executed negative test count for active package is greater than zero;" "AUDIT negative test count rule in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing runtime bootstrap evidence for active scope => `FINAL_STATUS=FAIL`.' "Runtime bootstrap fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing `application_profile` in tooling decision evidence => `FINAL_STATUS=FAIL`.' "Application profile fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing runtime/compiler version evidence for active scope => `FINAL_STATUS=FAIL`.' "Runtime/compiler fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'More than one active package => `FINAL_STATUS=FAIL`.' "Multiple active packages fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'insecure runtime defaults => `FINAL_STATUS=FAIL`.' "Insecure runtime defaults fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'raw exception exposure => `FINAL_STATUS=FAIL`.' "Raw exception exposure fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'silent masking => `FINAL_STATUS=FAIL`.' "Silent masking fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'runtime contract inconsistent => `FINAL_STATUS=FAIL`.' "Runtime contract inconsistency fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'missing dependency evidence => `FINAL_STATUS=FAIL`.' "Missing dependency evidence fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'persistence without migrations => `FINAL_STATUS=FAIL`.' "Persistence without migrations fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'version source mismatch => `FINAL_STATUS=FAIL`.' "Version-source mismatch fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing per-REQ positive/negative execution evidence => `FINAL_STATUS=FAIL`.' "Per-REQ test coverage fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Total executed tests for active package equals zero => `FINAL_STATUS=FAIL`.' "Zero-test fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Executed positive test count for active package equals zero => `FINAL_STATUS=FAIL`.' "Zero-positive fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Executed negative test count for active package equals zero => `FINAL_STATUS=FAIL`.' "Zero-negative fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing split unit/integration test execution evidence where Python tests are in scope => `FINAL_STATUS=FAIL`.' "Split test fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Stale backlog/package metadata => `FINAL_STATUS=FAIL`.' "Backlog/package fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing machine-generated metadata in planning docs (`generated_at_utc`, `source_commit_sha`) => `FINAL_STATUS=FAIL`.' "Planning metadata fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing performance budget evidence (`p95`) => `FINAL_STATUS=FAIL`.' "Performance fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Additional active prompt/governance contract files outside canonical set => `FINAL_STATUS=FAIL`.' "Redundant contract fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Any independence violation => `FINAL_STATUS=FAIL`' "Independence fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Any unresolved blocker/major finding => `FINAL_STATUS=FAIL`' "Blocker fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Any mode-mixing or wrong role packet => `FINAL_STATUS=FAIL`' "Execution-mode fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Any unresolved security/privacy blocker => `FINAL_STATUS=FAIL`' "Security/privacy fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing ISO security/data control verdicts => `FINAL_STATUS=FAIL`' "ISO security/data fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Stopping before `PR -> Merge -> Version -> Clean Desk` although all prior mandatory gates passed => `FINAL_STATUS=FAIL`.' "Premature stop fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Performing DEV or AUDIT only on uncommitted working-tree state for release path => `FINAL_STATUS=FAIL`.' "Uncommitted-state fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Failing to rerun gates after fixing a package-internal blocker => `FINAL_STATUS=FAIL`.' "Rerun-after-fix fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Leaving temporary gate artifacts, duplicate workflow files, or stale local package residues after merge/version => `FINAL_STATUS=FAIL`.' "Clean-desk residue fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "A package is only complete when all six closure steps are finished." "Mandatory package closure completion rule in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "must never output secrets, keys, tokens, or personal data" "DEV secret/PII protection in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "Single prompt model" "Single prompt model section in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "PO runtime prompt (customer-facing)" "PO runtime section in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "DEV execution mode contract" "DEV execution mode section in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "AUDIT execution mode contract" "AUDIT execution mode section in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "EXECUTION_MODE=DEV" "DEV execution mode token in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "EXECUTION_MODE=AUDIT" "AUDIT execution mode token in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "ISO-conform security/data controls" "AUDIT ISO security/data scope in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "Role packet artifact (machine-readable, mandatory)" "Role packet artifact section in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "execution_mode" "Role packet key execution_mode in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "po_packet_id" "Role packet key po_packet_id in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "req_ids" "Role packet key req_ids in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "scope_allowlist" "Role packet key scope_allowlist in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "allowed_inputs_hash" "Role packet key allowed_inputs_hash in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "target_commit_sha" "Role packet key target_commit_sha in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "po_agent_id" "Role packet key po_agent_id in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "created_at_utc" "Role packet key created_at_utc in PROMPTS"

check_contains "$BASE_DIR/LASTENHEFT.md" "generated_at_utc=" "LASTENHEFT generated_at_utc metadata present"
check_contains "$BASE_DIR/LASTENHEFT.md" "source_commit_sha=" "LASTENHEFT source_commit_sha metadata present"
check_contains "$BASE_DIR/LASTENHEFT.md" "metrics_generation_mode=machine_only" "LASTENHEFT machine-generated metrics mode present"
check_contains "$BASE_DIR/docs/BACKLOG.md" "generated_at_utc=" "BACKLOG generated_at_utc metadata present"
check_contains "$BASE_DIR/docs/BACKLOG.md" "source_commit_sha=" "BACKLOG source_commit_sha metadata present"
check_contains "$BASE_DIR/docs/BACKLOG.md" "planning_sync_state=" "BACKLOG planning sync state present"
check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" 'pytest -m "not integration"' "STARTUP checklist unit test command present"
check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" "pytest -m integration" "STARTUP checklist integration test command present"
check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" "./scripts/gates/dev_gate.sh" "STARTUP checklist DEV gate command present"
check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" "./scripts/gates/audit_gate.sh" "STARTUP checklist AUDIT gate command present"
check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" "Verify secure runtime defaults" "STARTUP secure runtime defaults checkpoint present"
check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" "Verify error-contract boundary" "STARTUP error-contract checkpoint present"
check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" "Verify runtime-contract consistency" "STARTUP runtime-contract checkpoint present"
check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" "Verify dependency/supply-chain and vulnerability evidence" "STARTUP dependency/supply-chain checkpoint present"
check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" "Verify persistence migration strategy" "STARTUP migration checkpoint present"
check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" "Verify version-source consistency" "STARTUP version-source checkpoint present"
check_contains "$BASE_DIR/CHANGELOG.md" "## [Unreleased]" "CHANGELOG unreleased section present"
check_contains "$BASE_DIR/CHANGELOG.md" "## [0.1.0]" "CHANGELOG baseline version section present"

check_contains "$BASE_DIR/docs/governance/INDEPENDENT_AUDIT_POLICY.md" "Mandatory ISO-conform security and data checks" "ISO-conform security/data section in audit policy"
check_contains "$BASE_DIR/docs/governance/INDEPENDENT_AUDIT_POLICY.md" 'Any missing control verdict or failed high-risk control requires `REJECT`.' "Mandatory reject rule in audit policy"
check_contains "$BASE_DIR/docs/governance/INDEPENDENT_AUDIT_POLICY.md" "SECURITY_BASELINE_MAX_AGE_DAYS" "Baseline age control in audit policy"
check_contains "$BASE_DIR/docs/governance/INDEPENDENT_AUDIT_POLICY.md" "Mandatory requirement-test execution coverage" "Requirement-test coverage section in audit policy"
check_contains "$BASE_DIR/docs/governance/INDEPENDENT_AUDIT_POLICY.md" 'at least one executed positive test (`PASS`) per `REQ_ID`;' "Positive test minimum in audit policy"
check_contains "$BASE_DIR/docs/governance/INDEPENDENT_AUDIT_POLICY.md" 'at least one executed negative test (`PASS`) per `REQ_ID`;' "Negative test minimum in audit policy"
check_contains "$BASE_DIR/docs/governance/INDEPENDENT_AUDIT_POLICY.md" "total executed tests for the active package must be greater than zero." "Non-zero test count in audit policy"
check_contains "$BASE_DIR/docs/governance/INDEPENDENT_AUDIT_POLICY.md" "executed positive test count for the active package must be greater than zero." "Positive test count in audit policy"
check_contains "$BASE_DIR/docs/governance/INDEPENDENT_AUDIT_POLICY.md" "executed negative test count for the active package must be greater than zero." "Negative test count in audit policy"

check_contains "$BASE_DIR/docs/governance/AUDIT_REPORT_TEMPLATE.md" "ISO security/data control verdicts (mandatory)" "Security/data section in audit report template"
check_contains "$BASE_DIR/docs/governance/AUDIT_REPORT_TEMPLATE.md" 'Baseline freshness (`SECURITY_BASELINE_REVIEW_UTC` age <= `SECURITY_BASELINE_MAX_AGE_DAYS`): PASS/FAIL' "Baseline freshness line in audit report template"
check_contains "$BASE_DIR/docs/governance/AUDIT_REPORT_TEMPLATE.md" "Secret/key/token management (no hardcoded secrets): PASS/FAIL" "Secret management line in audit report template"
check_contains "$BASE_DIR/docs/governance/AUDIT_REPORT_TEMPLATE.md" "Dependency risk/vulnerability review: PASS/FAIL" "Dependency risk line in audit report template"
check_contains "$BASE_DIR/docs/governance/AUDIT_REPORT_TEMPLATE.md" "- APPROVE / REJECT" "Binary decision vocabulary in audit report template"
check_contains "$BASE_DIR/docs/governance/AUDIT_REPORT_TEMPLATE.md" "Requirement test execution coverage (mandatory)" "Requirement test coverage section in audit report template"
check_contains "$BASE_DIR/docs/governance/AUDIT_REPORT_TEMPLATE.md" "Total executed tests (>0): PASS/FAIL" "Non-zero test count line in audit report template"
check_contains "$BASE_DIR/docs/governance/AUDIT_REPORT_TEMPLATE.md" "Executed positive tests (>0): PASS/FAIL" "Positive test count line in audit report template"
check_contains "$BASE_DIR/docs/governance/AUDIT_REPORT_TEMPLATE.md" "Executed negative tests (>0): PASS/FAIL" "Negative test count line in audit report template"
check_contains "$BASE_DIR/docs/governance/AUDIT_REPORT_TEMPLATE.md" "Positive_Test_ID" "Positive test column in audit report template"
check_contains "$BASE_DIR/docs/governance/AUDIT_REPORT_TEMPLATE.md" "Negative_Test_ID" "Negative test column in audit report template"

check_contains "$BASE_DIR/docs/governance/ISO_CONTROL_MATRIX_TEMPLATE.md" "| Data classification |" "Data classification row in ISO control matrix"
check_contains "$BASE_DIR/docs/governance/ISO_CONTROL_MATRIX_TEMPLATE.md" "| Requirement test execution coverage |" "Requirement test execution coverage row in ISO control matrix"
check_contains "$BASE_DIR/docs/governance/ISO_CONTROL_MATRIX_TEMPLATE.md" "| Data minimization and retention |" "Data minimization/retention row in ISO control matrix"
check_contains "$BASE_DIR/docs/governance/ISO_CONTROL_MATRIX_TEMPLATE.md" "| Secret management |" "Secret management row in ISO control matrix"
check_contains "$BASE_DIR/docs/governance/ISO_CONTROL_MATRIX_TEMPLATE.md" "| Logging redaction |" "Logging redaction row in ISO control matrix"
check_contains "$BASE_DIR/docs/governance/ISO_CONTROL_MATRIX_TEMPLATE.md" "| Encryption controls |" "Encryption row in ISO control matrix"
check_contains "$BASE_DIR/docs/governance/ISO_CONTROL_MATRIX_TEMPLATE.md" "| Dependency risk management |" "Dependency risk row in ISO control matrix"
check_contains "$BASE_DIR/docs/governance/ISO_CONTROL_MATRIX_TEMPLATE.md" "| Security baseline freshness |" "Baseline freshness row in ISO control matrix"
check_contains "$BASE_DIR/docs/governance/TRACEABILITY_MATRIX_TEMPLATE.md" "Test_Pos_ID" "Positive test ID column in traceability matrix template"
check_contains "$BASE_DIR/docs/governance/TRACEABILITY_MATRIX_TEMPLATE.md" "Test_Neg_ID" "Negative test ID column in traceability matrix template"
check_contains "$BASE_DIR/docs/governance/TRACEABILITY_MATRIX_TEMPLATE.md" "Test_Pos_Result" "Positive test result column in traceability matrix template"
check_contains "$BASE_DIR/docs/governance/TRACEABILITY_MATRIX_TEMPLATE.md" "Test_Neg_Result" "Negative test result column in traceability matrix template"
check_contains "$BASE_DIR/docs/governance/TRACEABILITY_MATRIX_TEMPLATE.md" "Missing mapping or missing positive/negative coverage is release-blocking." "Traceability matrix positive/negative coverage rule"

check_contains "$BASE_DIR/docs/governance/DELIVERY_PIPELINE_PROTOCOL.md" "PO executes official PR merge path." "PO merge execution in delivery protocol"
check_contains "$BASE_DIR/docs/governance/GITHUB_RELEASE_PROTOCOL.md" 'Merge execution is performed by PO identity after `AUDIT=APPROVE`.' "PO merge execution in release protocol"
check_contains "$BASE_DIR/docs/governance/GITHUB_RELEASE_PROTOCOL.md" "CHANGELOG.md" "Release protocol changelog requirement present"
check_contains "$BASE_DIR/docs/governance/FOUR_EYES_GATING.md" "Binding gate chain" "Four-eyes gate chain section present"
check_contains "$BASE_DIR/docs/governance/FOUR_EYES_GATING.md" "scripts/gates/dev_gate.sh" "Four-eyes DEV gate script reference present"
check_contains "$BASE_DIR/docs/governance/FOUR_EYES_GATING.md" "scripts/gates/audit_gate.sh" "Four-eyes AUDIT gate script reference present"

if grep -R -n -F "REQUEST_CHANGES" "$BASE_DIR/docs/governance" "$BASE_DIR/PROMPTS.md" >/dev/null 2>&1; then
  echo "FAIL non-binary decision term REQUEST_CHANGES found in prompt/governance templates"
  EXIT_CODE=1
else
  echo "OK   binary decision vocabulary enforced in prompt/governance templates"
fi

# Firewall signal checks on single prompt contract text
if grep -Eiq "chain-of-thought|chat history|private rationale" "$BASE_DIR/PROMPTS.md"; then
  echo "OK   PROMPTS.md declares forbidden DEV-private context for AUDIT mode"
else
  echo "FAIL PROMPTS.md missing explicit DEV-private context firewall terms"
  EXIT_CODE=1
fi

# Baseline age check from DESIGN metadata
baseline_review_date="$(extract_design_value "SECURITY_BASELINE_REVIEW_UTC")"
baseline_max_age_days="$(extract_design_value "SECURITY_BASELINE_MAX_AGE_DAYS")"

if [[ -z "$baseline_review_date" || -z "$baseline_max_age_days" ]]; then
  echo "FAIL unable to extract security baseline date/max-age metadata"
  EXIT_CODE=1
elif [[ ! "$baseline_review_date" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
  echo "FAIL invalid SECURITY_BASELINE_REVIEW_UTC format: $baseline_review_date"
  EXIT_CODE=1
elif [[ ! "$baseline_max_age_days" =~ ^[0-9]+$ ]]; then
  echo "FAIL invalid SECURITY_BASELINE_MAX_AGE_DAYS value: $baseline_max_age_days"
  EXIT_CODE=1
elif ! command -v python3 >/dev/null 2>&1; then
  echo "FAIL python3 not available for baseline age calculation"
  EXIT_CODE=1
else
  baseline_age_days="$(python3 - "$baseline_review_date" <<'PY'
from datetime import date, datetime
import sys
review = datetime.strptime(sys.argv[1], "%Y-%m-%d").date()
today = date.today()
print((today - review).days)
PY
)"
  if [[ ! "$baseline_age_days" =~ ^-?[0-9]+$ ]]; then
    echo "FAIL unable to compute baseline age days"
    EXIT_CODE=1
  elif (( baseline_age_days < 0 )); then
    echo "FAIL security baseline review date is in the future: $baseline_review_date"
    EXIT_CODE=1
  elif (( baseline_age_days > baseline_max_age_days )); then
    echo "FAIL security baseline age $baseline_age_days exceeds max $baseline_max_age_days days"
    EXIT_CODE=1
  else
    echo "OK   security baseline age check ($baseline_age_days <= $baseline_max_age_days days)"
  fi
fi

planning_max_age_days="$(extract_design_value "PLANNING_METADATA_MAX_AGE_DAYS")"
backlog_generated_at="$(extract_file_metadata_value "$BASE_DIR/docs/BACKLOG.md" "generated_at_utc")"
lastenheft_generated_at="$(extract_file_metadata_value "$BASE_DIR/LASTENHEFT.md" "generated_at_utc")"

check_metadata_age() {
  local label="$1"
  local ts="$2"
  local max_age="$3"
  if [[ -z "$ts" ]]; then
    echo "FAIL ${label} generated_at_utc is missing"
    EXIT_CODE=1
    return
  fi
  if [[ ! "$max_age" =~ ^[0-9]+$ ]]; then
    echo "FAIL invalid PLANNING_METADATA_MAX_AGE_DAYS value: $max_age"
    EXIT_CODE=1
    return
  fi
  local age_days
  age_days="$(python3 - "$ts" <<'PY'
from datetime import datetime, timezone
import sys
raw = sys.argv[1].strip()
try:
    if raw.endswith("Z"):
        dt = datetime.fromisoformat(raw.replace("Z", "+00:00"))
    else:
        dt = datetime.fromisoformat(raw)
        if dt.tzinfo is None:
            dt = dt.replace(tzinfo=timezone.utc)
except Exception:
    print("INVALID")
    raise SystemExit(0)
now = datetime.now(timezone.utc)
delta = now - dt.astimezone(timezone.utc)
print(int(delta.total_seconds() // 86400))
PY
)"
  if [[ "$age_days" == "INVALID" ]]; then
    echo "FAIL ${label} generated_at_utc has invalid ISO timestamp: $ts"
    EXIT_CODE=1
  elif [[ ! "$age_days" =~ ^-?[0-9]+$ ]]; then
    echo "FAIL unable to compute ${label} metadata age"
    EXIT_CODE=1
  elif (( age_days < 0 )); then
    echo "FAIL ${label} generated_at_utc is in the future: $ts"
    EXIT_CODE=1
  elif (( age_days > max_age )); then
    echo "FAIL ${label} metadata age $age_days exceeds max $max_age days"
    EXIT_CODE=1
  else
    echo "OK   ${label} metadata age check ($age_days <= $max_age days)"
  fi
}

if command -v python3 >/dev/null 2>&1; then
  check_metadata_age "BACKLOG" "$backlog_generated_at" "$planning_max_age_days"
  check_metadata_age "LASTENHEFT" "$lastenheft_generated_at" "$planning_max_age_days"
else
  echo "FAIL python3 not available for planning metadata age calculation"
  EXIT_CODE=1
fi

backlog_source_sha="$(extract_file_metadata_value "$BASE_DIR/docs/BACKLOG.md" "source_commit_sha")"
lastenheft_source_sha="$(extract_file_metadata_value "$BASE_DIR/LASTENHEFT.md" "source_commit_sha")"
if [[ "$backlog_source_sha" =~ ^[0-9a-f]{7,40}$ ]]; then
  echo "OK   BACKLOG source_commit_sha format valid"
else
  echo "FAIL BACKLOG source_commit_sha has invalid format: ${backlog_source_sha:-missing}"
  EXIT_CODE=1
fi
if [[ "$lastenheft_source_sha" =~ ^[0-9a-f]{7,40}$ ]]; then
  echo "OK   LASTENHEFT source_commit_sha format valid"
else
  echo "FAIL LASTENHEFT source_commit_sha has invalid format: ${lastenheft_source_sha:-missing}"
  EXIT_CODE=1
fi

latest_po_packet=""
if [[ -d "$BASE_DIR/system_reports/gates" ]]; then
  latest_po_packet="$(find "$BASE_DIR/system_reports/gates" -maxdepth 1 -type f -name 'po_role_packet*.env' -print | sort | tail -n1 || true)"
fi

if [[ -n "$latest_po_packet" ]]; then
  execution_mode_line="$(grep -E '^execution_mode=' "$latest_po_packet" | head -n1 || true)"
  execution_mode_value="${execution_mode_line#execution_mode=}"
  req_ids_line="$(grep -E '^req_ids=' "$latest_po_packet" | head -n1 || true)"
  req_ids_csv="${req_ids_line#req_ids=}"
  req_ids_csv="$(printf '%s' "$req_ids_csv" | tr -d '[:space:]')"

  if [[ -z "$req_ids_csv" ]]; then
    if [[ "$execution_mode_value" == "AUDIT" ]]; then
      echo "FAIL req_ids is empty in AUDIT PO role packet: $latest_po_packet"
      EXIT_CODE=1
    else
      echo "INFO req_ids is empty in PO role packet ($latest_po_packet); skipping active-package test execution coverage check"
    fi
  else
    trace_matrix_file="$BASE_DIR/docs/governance/TRACEABILITY_MATRIX_TEMPLATE.md"
    if [[ ! -f "$trace_matrix_file" ]]; then
      echo "FAIL missing traceability matrix file for test execution coverage check: $trace_matrix_file"
      EXIT_CODE=1
    else
      if ! awk -v req_csv="$req_ids_csv" '
      BEGIN {
        rc=0;
        total_exec=0;
        positive_exec=0;
        negative_exec=0;
        split(req_csv, req_parts, ",");
        for (i in req_parts) {
          r=req_parts[i];
          gsub(/^[ \t]+|[ \t]+$/, "", r);
          if (r != "") required[r]=1;
        }
      }
      function trim(s) {
        gsub(/^[ \t]+|[ \t]+$/, "", s);
        return s;
      }
      /^\|/ {
        line=$0;
        if (line ~ /^\|---/) next;
        split(line, c, "|");
        req=trim(c[2]);
        if (req == "" || req == "REQ_ID") next;
        if (!(req in required)) next;

        found[req]=1;
        pos_id=trim(c[6]);
        pos_ev=trim(c[7]);
        pos_res=toupper(trim(c[8]));
        neg_id=trim(c[9]);
        neg_ev=trim(c[10]);
        neg_res=toupper(trim(c[11]));

        if (pos_id == "" || pos_ev == "" || pos_res == "") {
          printf("FAIL req %s missing positive test id/evidence/result in traceability matrix\n", req);
          rc=1;
        } else if (pos_res != "PASS") {
          printf("FAIL req %s positive test result is not PASS (%s)\n", req, pos_res);
          rc=1;
        } else {
          total_exec++;
          positive_exec++;
        }

        if (neg_id == "" || neg_ev == "" || neg_res == "") {
          printf("FAIL req %s missing negative test id/evidence/result in traceability matrix\n", req);
          rc=1;
        } else if (neg_res != "PASS") {
          printf("FAIL req %s negative test result is not PASS (%s)\n", req, neg_res);
          rc=1;
        } else {
          total_exec++;
          negative_exec++;
        }
      }
      END {
        for (r in required) {
          if (!(r in found)) {
            printf("FAIL req %s missing from traceability matrix\n", r);
            rc=1;
          }
        }
        if (total_exec <= 0) {
          print "FAIL total executed tests for active package is zero";
          rc=1;
        } else {
          printf("OK   active package executed tests count > 0 (%d)\n", total_exec);
        }
        if (positive_exec <= 0) {
          print "FAIL executed positive test count for active package is zero";
          rc=1;
        } else {
          printf("OK   active package positive tests count > 0 (%d)\n", positive_exec);
        }
        if (negative_exec <= 0) {
          print "FAIL executed negative test count for active package is zero";
          rc=1;
        } else {
          printf("OK   active package negative tests count > 0 (%d)\n", negative_exec);
        }
        exit rc;
      }
      ' "$trace_matrix_file"; then
        EXIT_CODE=1
      fi
    fi
  fi
else
  echo "INFO no PO role packet found in system_reports/gates; skipping active-package test execution coverage check"
fi

if [[ -x "$BASE_DIR/scripts/prompt_firewall_check.sh" ]]; then
  if "$BASE_DIR/scripts/prompt_firewall_check.sh"; then
    echo "OK   prompt-firewall-check subcontrol"
  else
    echo "FAIL prompt-firewall-check subcontrol"
    EXIT_CODE=1
  fi
else
  echo "FAIL prompt-firewall-check script missing or not executable"
  EXIT_CODE=1
fi

if [[ "$EXIT_CODE" -eq 0 ]]; then
  echo "PASS audit-readiness"
else
  echo "FAIL audit-readiness"
fi

exit "$EXIT_CODE"
