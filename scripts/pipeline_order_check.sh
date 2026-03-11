#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EXIT_CODE=0

echo "Running delivery pipeline protocol check..."

required_docs=(
  "$BASE_DIR/AGENTS.md"
  "$BASE_DIR/DESIGN.md"
  "$BASE_DIR/CONTRIBUTING.md"
  "$BASE_DIR/PROMPTS.md"
  "$BASE_DIR/LASTENHEFT.md"
  "$BASE_DIR/CHANGELOG.md"
  "$BASE_DIR/docs/BACKLOG.md"
  "$BASE_DIR/docs/STARTUP_CHECKLIST.md"
  "$BASE_DIR/scripts/prompt_firewall_check.sh"
  "$BASE_DIR/scripts/gates/dev_gate.sh"
  "$BASE_DIR/scripts/gates/audit_gate.sh"
  "$BASE_DIR/docs/governance/DELIVERY_PIPELINE_PROTOCOL.md"
  "$BASE_DIR/docs/governance/GITHUB_RELEASE_PROTOCOL.md"
  "$BASE_DIR/docs/governance/FOUR_EYES_GATING.md"
)

for f in "${required_docs[@]}"; do
  if [[ ! -f "$f" ]]; then
    echo "FAIL missing required normative file: $f"
    EXIT_CODE=1
  else
    echo "OK   $f"
  fi
done

if [[ -f "$BASE_DIR/docs/governance/PROJECT_STARTER_CHECKLIST.md" ]]; then
  echo "FAIL legacy checklist file still active: $BASE_DIR/docs/governance/PROJECT_STARTER_CHECKLIST.md"
  EXIT_CODE=1
else
  echo "OK   no legacy project starter checklist file"
fi

if [[ -x "$BASE_DIR/scripts/prompt_firewall_check.sh" ]]; then
  echo "OK   prompt_firewall_check.sh executable"
else
  echo "FAIL prompt_firewall_check.sh is not executable"
  EXIT_CODE=1
fi

if [[ -x "$BASE_DIR/scripts/gates/dev_gate.sh" ]]; then
  echo "OK   dev_gate.sh executable"
else
  echo "FAIL dev_gate.sh is not executable"
  EXIT_CODE=1
fi

if [[ -x "$BASE_DIR/scripts/gates/audit_gate.sh" ]]; then
  echo "OK   audit_gate.sh executable"
else
  echo "FAIL audit_gate.sh is not executable"
  EXIT_CODE=1
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

check_contains "$BASE_DIR/AGENTS.md" "PO (Product Owner) — primary control strand" "PO primary control strand defined"
check_contains "$BASE_DIR/AGENTS.md" "default customer-facing operating role" "Default PO role in AGENTS present"
check_contains "$BASE_DIR/AGENTS.md" "DEV (Implementation) — execution strand" "DEV execution strand defined"
check_contains "$BASE_DIR/AGENTS.md" "AUDIT (Independent) — execution strand" "AUDIT execution strand defined"
check_contains "$BASE_DIR/AGENTS.md" "No self-approval" "No self-approval rule present"
check_contains "$BASE_DIR/AGENTS.md" "Audit input firewall" "Audit input firewall present"
check_contains "$BASE_DIR/AGENTS.md" "Prompt and runtime separation controls" "Prompt/runtime separation section present"
check_contains "$BASE_DIR/AGENTS.md" "Security and privacy non-negotiables" "Security/privacy section present"
check_contains "$BASE_DIR/AGENTS.md" "ISO-conform security/data checklist" "ISO-conform security/data checklist rule present"
check_contains "$BASE_DIR/AGENTS.md" "Runtime bootstrap autonomy (customer-safe)" "Runtime bootstrap autonomy section present"
check_contains "$BASE_DIR/AGENTS.md" "Customer-facing instructions to run setup commands manually are forbidden." "No customer manual setup rule in AGENTS present"
check_contains "$BASE_DIR/AGENTS.md" 'Python virtual environment location is fixed to project root `.venv` only.' "Root-only Python venv rule in AGENTS present"
check_contains "$BASE_DIR/AGENTS.md" "Runtime/compiler selections for active scope must target latest stable versions with dated official-source evidence." "Latest-stable runtime/compiler rule in AGENTS present"
check_contains "$BASE_DIR/AGENTS.md" "Single active change package lock" "Single active package section in AGENTS present"
check_contains "$BASE_DIR/AGENTS.md" "PO must not issue a new DEV or AUDIT role packet while the current package is not closed." "PO package lock rule in AGENTS present"
check_contains "$BASE_DIR/AGENTS.md" "Requirement -> DEV -> AUDIT -> PR -> Merge -> Version -> Clean Desk" "Clean-desk sequence in AGENTS present"
check_contains "$BASE_DIR/AGENTS.md" "package-internal defects within approved scope" "Package-internal defect closure rule in AGENTS present"
check_contains "$BASE_DIR/AGENTS.md" "Per-Requirement test execution minimum" "Per-REQ test execution section in AGENTS present"
check_contains "$BASE_DIR/AGENTS.md" "Total executed test count for the active package must be greater than zero." "Non-zero test count rule in AGENTS present"
check_contains "$BASE_DIR/AGENTS.md" "Package-level executed positive test count must be greater than zero." "Positive test count rule in AGENTS present"
check_contains "$BASE_DIR/AGENTS.md" "Package-level executed negative test count must be greater than zero." "Negative test count rule in AGENTS present"
check_contains "$BASE_DIR/AGENTS.md" '`DESIGN.md` is the only normative source for architecture/governance fundamentals.' "DESIGN single-source rule in AGENTS present"
check_contains "$BASE_DIR/AGENTS.md" '`PROMPTS.md` is runtime-only and must not redefine architecture/governance fundamentals from `DESIGN.md`.' "PROMPTS runtime-only rule in AGENTS present"
check_contains "$BASE_DIR/AGENTS.md" '`docs/BACKLOG.md` and active package plan metadata must be synchronized before DEV start.' "Backlog sync rule in AGENTS present"
check_contains "$BASE_DIR/AGENTS.md" 'Performance evidence for active scope must include explicit budget result (minimum `p95`) before release.' "Performance budget rule in AGENTS present"
check_contains "$BASE_DIR/AGENTS.md" "Python module size limit above 900 LOC is release-blocking unless an active machine-readable waiver exists." "Module size rule in AGENTS present"

check_contains "$BASE_DIR/CONTRIBUTING.md" "No step may be skipped or reordered." "Strict sequence rule present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Concurrent/overlapping change packages are forbidden." "No-overlap rule present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Requirement definition and approval (PO)" "Requirement phase present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Independent Audit gate (AUDIT)" "Independent audit phase present"
check_contains "$BASE_DIR/CONTRIBUTING.md" '`docs/BACKLOG.md`, active package metadata, and `LASTENHEFT.md` machine metrics are synchronized and fresh' "Backlog/package/LASTENHEFT freshness criterion in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" '`LASTENHEFT.md` and `docs/BACKLOG.md` include machine-generated metadata' "Planning metadata criterion in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Merge authorization (PO based on AUDIT APPROVE)" "PO merge authority with audit dependency present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Hard blockers (automatic FAIL)" "Hard blocker section present"
check_contains "$BASE_DIR/CONTRIBUTING.md" 'runtime bootstrap executed automatically (`.env` and required toolchain setup) with evidence artifact' "Runtime bootstrap DEV entry criterion present"
check_contains "$BASE_DIR/CONTRIBUTING.md" 'Missing runtime bootstrap evidence for active `REQ_IDS`.' "Runtime bootstrap blocker present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Customer-facing manual runtime/setup instructions issued by DEV." "Customer-manual-setup blocker present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Missing ISO security/data control verdicts in audit report." "ISO security/data verdict blocker present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Security baseline age exceeds configured maximum age." "Baseline age blocker present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "machine-readable PO role packet exists with required keys" "Role packet requirement in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Missing required tooling decision keys" "Tooling decision key blocker in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" 'Python virtual environment not located at project root `.venv`.' "Root-only Python venv blocker in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Missing latest-stable runtime/compiler evidence for active scope." "Latest-stable runtime/compiler blocker in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "New package started while previous package is not closed" "Open-package blocker in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Stopping before PR -> Merge -> Version -> Clean Desk although all prior mandatory gates passed." "Premature stop blocker in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "DEV or AUDIT release-path evaluation performed only on uncommitted working-tree state." "Uncommitted-state blocker in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Fixed package-internal blocker without rerunning required gates." "Rerun-after-fix blocker in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "stale local package residues left behind after closure." "Clean-desk residue blocker in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" 'deterministic tests executed and linked with per-`REQ_ID` coverage (minimum one positive and one negative test)' "Per-REQ test coverage entry criterion in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" 'pytest -m "not integration"' "Unit test partition command in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "pytest -m integration" "Integration test partition command in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" 'Missing per-`REQ_ID` test coverage evidence (minimum one executed positive and one executed negative test).' "Per-REQ test coverage blocker in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" 'Missing separated Python test partition evidence (`pytest -m "not integration"` and `pytest -m integration`) when Python tests are in scope.' "Split test evidence blocker in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Total executed test count for active package equals zero." "Zero-test blocker in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Executed positive test count for active package equals zero." "Zero-positive blocker in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Executed negative test count for active package equals zero." "Zero-negative blocker in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" 'Missing performance budget evidence (`p95`) for active release scope.' "Performance evidence blocker in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Python module exceeds 900 LOC without active valid waiver evidence." "Module size blocker in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Waiver is missing required keys, expired, or not PO-approved." "Waiver blocker in CONTRIBUTING present"

check_contains "$BASE_DIR/DESIGN.md" "GOV-14 Mandatory Gate Failure Semantics" "Design hard-fail control present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-15 ISO-Aligned Evidence Package" "Design ISO evidence control present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-16 Prompt Mode Separation" "Design prompt mode separation control present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-17 Committed-State Audit Execution" "Design committed-state audit control present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-18 Security and Privacy by Default" "Design security/privacy default control present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-19 Security Baseline Currency" "Design security baseline currency control present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-20 Key and Secret Management" "Design key/secret management control present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-21 Privacy and Logging Controls" "Design privacy/logging control present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-22 ISO-Conform Security/Data Audit Depth" "Design ISO-conform security/data audit depth control present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-23 Security Baseline Freshness Gate" "Design baseline freshness gate present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-27 Profile-First Tool Selection" "Design profile-first tooling control present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-28 Type-Safe UI Default" "Design type-safe UI default control present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-29 Runtime and Compiler Currency" "Design runtime/compiler currency control present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-30 Root-Only Python Environment" "Design root-only Python environment control present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-31 Serial Change Package Lock" "Design serial change package lock control present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-32 Per-Requirement Test Pair Coverage" "Design per-REQ test pair coverage control present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-33 Backlog and Package Metadata Freshness" "Design backlog metadata freshness control present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-34 Machine-Generated Planning Metrics" "Design machine-generated planning metrics control present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-35 No Active Document Duplication" "Design no document duplication control present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-36 Test Partition Enforcement" "Design test partition control present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-37 Performance Budget Gate" "Design performance budget control present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-38 Structural Size Gate" "Design structural size control present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-39 Runtime Fitness Review Cadence" "Design runtime fitness cadence control present"
check_contains "$BASE_DIR/DESIGN.md" "GOV-40 Standardized Waiver Mechanism" "Design waiver mechanism control present"
check_contains "$BASE_DIR/DESIGN.md" "role-packet artifact schema and key integrity" "Design role-packet integrity control present"

check_contains "$BASE_DIR/PROMPTS.md" "Required gate semantics (no escape path)" "Prompt-level no-escape semantics present"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing mandatory evidence => `FINAL_STATUS=FAIL`' "Prompt fail semantics present"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing ISO security/data control verdicts => `FINAL_STATUS=FAIL`' "Prompt ISO security/data fail semantics present"
check_contains "$BASE_DIR/PROMPTS.md" "Default operating role (mandatory)" "Default operating role section present"
check_contains "$BASE_DIR/PROMPTS.md" "PO autonomy default (mandatory)" "PO autonomy default section present"
check_contains "$BASE_DIR/PROMPTS.md" "DEV completion expectation (mandatory)" "DEV completion expectation section present"
check_contains "$BASE_DIR/PROMPTS.md" "AUDIT orchestration by PO" "AUDIT orchestration section present"
check_contains "$BASE_DIR/PROMPTS.md" "Mandatory package closure" "Mandatory package closure section present"
check_contains "$BASE_DIR/PROMPTS.md" "Single prompt model" "Single prompt model section present"
check_contains "$BASE_DIR/PROMPTS.md" "Scope note:" "Prompt scope section present"
check_contains "$BASE_DIR/PROMPTS.md" '`DESIGN.md` defines fundamental governance/architecture rules.' "Prompt DESIGN fundamental scope present"
check_contains "$BASE_DIR/PROMPTS.md" "PO runtime prompt (customer-facing)" "PO runtime section present"
check_contains "$BASE_DIR/PROMPTS.md" "DEV execution mode contract" "DEV mode section present"
check_contains "$BASE_DIR/PROMPTS.md" "run runtime bootstrap protocol before implementation" "Runtime bootstrap protocol in DEV mode present"
check_contains "$BASE_DIR/PROMPTS.md" "ask customer to run manual environment/setup commands." "No customer manual setup in DEV mode present"
check_contains "$BASE_DIR/PROMPTS.md" 'select `application_profile` from `DESIGN.md` section 1.1 before selecting tools' "Application profile selection in DEV mode present"
check_contains "$BASE_DIR/PROMPTS.md" "keep production choices on stable/LTS channels unless PO-approved exception exists" "Stable/LTS tooling selection rule in DEV mode present"
check_contains "$BASE_DIR/PROMPTS.md" 'enforce Python venv path at project root `.venv` only' "Root-only Python venv rule in DEV mode present"
check_contains "$BASE_DIR/PROMPTS.md" "target latest stable runtime/compiler versions unless PO-approved exception exists" "Latest-stable runtime/compiler rule in DEV mode present"
check_contains "$BASE_DIR/PROMPTS.md" "Only one active change package is allowed at any time." "Single active package rule in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" "ensure no open package conflict exists before starting a new package;" "PO open-package check in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" '`docs/BACKLOG.md`, active PO package plan, `LASTENHEFT.md` machine metrics' "PO backlog/package/LASTENHEFT freshness rule in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'provide at least one executed positive and one executed negative test per active `REQ_ID`;' "DEV per-REQ test execution rule in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'execute separated test partitions for Python scope: unit (`pytest -m "not integration"`) and integration (`pytest -m integration`);' "DEV split test rule in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'verify for each active `REQ_ID`: at least one executed positive and one executed negative test with evidence references;' "AUDIT per-REQ test verification rule in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" "verify total executed tests for active package is greater than zero;" "AUDIT non-zero test count rule in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" "verify executed positive test count for active package is greater than zero;" "AUDIT positive test count rule in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" "verify executed negative test count for active package is greater than zero;" "AUDIT negative test count rule in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing runtime bootstrap evidence for active scope => `FINAL_STATUS=FAIL`.' "Runtime bootstrap fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing `application_profile` in tooling decision evidence => `FINAL_STATUS=FAIL`.' "Application profile fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing runtime/compiler version evidence for active scope => `FINAL_STATUS=FAIL`.' "Runtime/compiler fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'More than one active package => `FINAL_STATUS=FAIL`.' "Multiple active packages fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing per-REQ positive/negative execution evidence => `FINAL_STATUS=FAIL`.' "Per-REQ test coverage fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing split unit/integration test execution evidence where Python tests are in scope => `FINAL_STATUS=FAIL`.' "Split test fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Total executed tests for active package equals zero => `FINAL_STATUS=FAIL`.' "Zero-test fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Executed positive test count for active package equals zero => `FINAL_STATUS=FAIL`.' "Zero-positive fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Executed negative test count for active package equals zero => `FINAL_STATUS=FAIL`.' "Zero-negative fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Stale backlog/package metadata => `FINAL_STATUS=FAIL`.' "Backlog/package fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing machine-generated metadata in planning docs (`generated_at_utc`, `source_commit_sha`) => `FINAL_STATUS=FAIL`.' "Planning metadata fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing performance budget evidence (`p95`) => `FINAL_STATUS=FAIL`.' "Performance fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Additional active prompt/governance contract files outside canonical set => `FINAL_STATUS=FAIL`.' "Redundant contract fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Stopping before `PR -> Merge -> Version -> Clean Desk` although all prior mandatory gates passed => `FINAL_STATUS=FAIL`.' "Premature stop fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Performing DEV or AUDIT only on uncommitted working-tree state for release path => `FINAL_STATUS=FAIL`.' "Uncommitted-state fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Failing to rerun gates after fixing a package-internal blocker => `FINAL_STATUS=FAIL`.' "Rerun-after-fix fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Leaving temporary gate artifacts, duplicate workflow files, or stale local package residues after merge/version => `FINAL_STATUS=FAIL`.' "Clean-desk residue fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" "AUDIT execution mode contract" "AUDIT mode section present"
check_contains "$BASE_DIR/docs/governance/TRACEABILITY_MATRIX_TEMPLATE.md" "Test_Pos_ID" "Traceability matrix positive test ID column present"
check_contains "$BASE_DIR/docs/governance/TRACEABILITY_MATRIX_TEMPLATE.md" "Test_Neg_ID" "Traceability matrix negative test ID column present"
check_contains "$BASE_DIR/docs/governance/AUDIT_REPORT_TEMPLATE.md" "Requirement test execution coverage (mandatory)" "Audit report requirement test coverage section present"
check_contains "$BASE_DIR/LASTENHEFT.md" "generated_at_utc=" "LASTENHEFT generated_at_utc metadata present"
check_contains "$BASE_DIR/LASTENHEFT.md" "source_commit_sha=" "LASTENHEFT source_commit_sha metadata present"
check_contains "$BASE_DIR/docs/BACKLOG.md" "generated_at_utc=" "BACKLOG generated_at_utc metadata present"
check_contains "$BASE_DIR/docs/BACKLOG.md" "source_commit_sha=" "BACKLOG source_commit_sha metadata present"
check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" 'pytest -m "not integration"' "STARTUP checklist unit test command present"
check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" "pytest -m integration" "STARTUP checklist integration test command present"
check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" "./scripts/gates/dev_gate.sh" "STARTUP checklist DEV gate command present"
check_contains "$BASE_DIR/docs/STARTUP_CHECKLIST.md" "./scripts/gates/audit_gate.sh" "STARTUP checklist AUDIT gate command present"
check_contains "$BASE_DIR/CHANGELOG.md" "## [Unreleased]" "CHANGELOG unreleased section present"

check_contains "$BASE_DIR/docs/governance/DELIVERY_PIPELINE_PROTOCOL.md" "PO executes official PR merge path." "PO merge authority in delivery protocol present"
check_contains "$BASE_DIR/docs/governance/GITHUB_RELEASE_PROTOCOL.md" 'Merge execution is performed by PO identity after `AUDIT=APPROVE`.' "PO merge authority in release protocol present"
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
check_contains "$BASE_DIR/PROMPTS.md" "Role packet artifact (machine-readable, mandatory)" "Role packet artifact section present"
check_contains "$BASE_DIR/PROMPTS.md" "allowed_inputs_hash" "Role packet key allowed_inputs_hash present"
check_contains "$BASE_DIR/PROMPTS.md" "target_commit_sha" "Role packet key target_commit_sha present"
check_contains "$BASE_DIR/PROMPTS.md" "po_packet_id" "Role packet key po_packet_id present"
check_contains "$BASE_DIR/PROMPTS.md" "created_at_utc" "Role packet key created_at_utc present"

if grep -Fq "REQUEST_CHANGES" "$BASE_DIR/PROMPTS.md"; then
  echo "FAIL PROMPTS.md contains non-binary decision term REQUEST_CHANGES"
  EXIT_CODE=1
else
  echo "OK   PROMPTS.md uses binary decision vocabulary"
fi

if [[ "$EXIT_CODE" -eq 0 ]]; then
  echo "PASS pipeline-order-check"
else
  echo "FAIL pipeline-order-check"
fi

exit "$EXIT_CODE"
