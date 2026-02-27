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
  "$BASE_DIR/scripts/prompt_firewall_check.sh"
  "$BASE_DIR/docs/governance/DELIVERY_PIPELINE_PROTOCOL.md"
  "$BASE_DIR/docs/governance/GITHUB_RELEASE_PROTOCOL.md"
)

for f in "${required_docs[@]}"; do
  if [[ ! -f "$f" ]]; then
    echo "FAIL missing required normative file: $f"
    EXIT_CODE=1
  else
    echo "OK   $f"
  fi
done

if [[ -x "$BASE_DIR/scripts/prompt_firewall_check.sh" ]]; then
  echo "OK   prompt_firewall_check.sh executable"
else
  echo "FAIL prompt_firewall_check.sh is not executable"
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
check_contains "$BASE_DIR/AGENTS.md" "Per-Requirement test execution minimum" "Per-REQ test execution section in AGENTS present"
check_contains "$BASE_DIR/AGENTS.md" "Total executed test count for the active package must be greater than zero." "Non-zero test count rule in AGENTS present"
check_contains "$BASE_DIR/AGENTS.md" "Package-level executed positive test count must be greater than zero." "Positive test count rule in AGENTS present"
check_contains "$BASE_DIR/AGENTS.md" "Package-level executed negative test count must be greater than zero." "Negative test count rule in AGENTS present"

check_contains "$BASE_DIR/CONTRIBUTING.md" "No step may be skipped or reordered." "Strict sequence rule present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Concurrent/overlapping change packages are forbidden." "No-overlap rule present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Requirement definition and approval (PO)" "Requirement phase present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Independent Audit gate (AUDIT)" "Independent audit phase present"
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
check_contains "$BASE_DIR/CONTRIBUTING.md" 'deterministic tests executed and linked with per-`REQ_ID` coverage (minimum one positive and one negative test)' "Per-REQ test coverage entry criterion in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" 'Missing per-`REQ_ID` test coverage evidence (minimum one executed positive and one executed negative test).' "Per-REQ test coverage blocker in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Total executed test count for active package equals zero." "Zero-test blocker in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Executed positive test count for active package equals zero." "Zero-positive blocker in CONTRIBUTING present"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Executed negative test count for active package equals zero." "Zero-negative blocker in CONTRIBUTING present"

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
check_contains "$BASE_DIR/DESIGN.md" "role-packet artifact schema and key integrity" "Design role-packet integrity control present"

check_contains "$BASE_DIR/PROMPTS.md" "Required gate semantics (no escape path)" "Prompt-level no-escape semantics present"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing mandatory evidence => `FINAL_STATUS=FAIL`' "Prompt fail semantics present"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing ISO security/data control verdicts => `FINAL_STATUS=FAIL`' "Prompt ISO security/data fail semantics present"
check_contains "$BASE_DIR/PROMPTS.md" "Single prompt model" "Single prompt model section present"
check_contains "$BASE_DIR/PROMPTS.md" "PO runtime prompt (customer-facing)" "PO runtime section present"
check_contains "$BASE_DIR/PROMPTS.md" "DEV execution mode contract" "DEV mode section present"
check_contains "$BASE_DIR/PROMPTS.md" "run runtime bootstrap protocol before implementation" "Runtime bootstrap protocol in DEV mode present"
check_contains "$BASE_DIR/PROMPTS.md" "ask customer to run manual environment/setup commands." "No customer manual setup in DEV mode present"
check_contains "$BASE_DIR/PROMPTS.md" 'select `application_profile` from `DESIGN.md` section 1.1 before selecting tools' "Application profile selection in DEV mode present"
check_contains "$BASE_DIR/PROMPTS.md" "keep production choices on stable/LTS channels unless PO-approved exception exists" "Stable/LTS tooling selection rule in DEV mode present"
check_contains "$BASE_DIR/PROMPTS.md" 'enforce Python venv path at project root `.venv` only' "Root-only Python venv rule in DEV mode present"
check_contains "$BASE_DIR/PROMPTS.md" "target latest stable runtime/compiler versions unless PO-approved exception exists" "Latest-stable runtime/compiler rule in DEV mode present"
check_contains "$BASE_DIR/PROMPTS.md" "Only one active change package is allowed at any time." "Single active package rule in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" "ensure no open package exists before starting a new package;" "PO open-package check in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'execute at least one positive and one negative test per active `REQ_ID` and record machine-readable evidence;' "DEV per-REQ test execution rule in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'verify for each active `REQ_ID`: at least one executed positive and one executed negative test with evidence references;' "AUDIT per-REQ test verification rule in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" "verify total executed tests for active package is greater than zero;" "AUDIT non-zero test count rule in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" "verify executed positive test count for active package is greater than zero;" "AUDIT positive test count rule in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" "verify executed negative test count for active package is greater than zero;" "AUDIT negative test count rule in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing runtime bootstrap evidence for active scope => `FINAL_STATUS=FAIL`.' "Runtime bootstrap fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing `application_profile` in tooling decision evidence => `FINAL_STATUS=FAIL`.' "Application profile fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing runtime/compiler version evidence for active scope => `FINAL_STATUS=FAIL`.' "Runtime/compiler fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing per-REQ positive/negative execution evidence => `FINAL_STATUS=FAIL`.' "Per-REQ test coverage fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Total executed tests for active package equals zero => `FINAL_STATUS=FAIL`.' "Zero-test fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Executed positive test count for active package equals zero => `FINAL_STATUS=FAIL`.' "Zero-positive fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Executed negative test count for active package equals zero => `FINAL_STATUS=FAIL`.' "Zero-negative fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" 'Starting a new package while a previous package is still open => `FINAL_STATUS=FAIL`.' "Open-package fail semantics in PROMPTS present"
check_contains "$BASE_DIR/PROMPTS.md" "AUDIT execution mode contract" "AUDIT mode section present"
check_contains "$BASE_DIR/docs/governance/TRACEABILITY_MATRIX_TEMPLATE.md" "Test_Pos_ID" "Traceability matrix positive test ID column present"
check_contains "$BASE_DIR/docs/governance/TRACEABILITY_MATRIX_TEMPLATE.md" "Test_Neg_ID" "Traceability matrix negative test ID column present"
check_contains "$BASE_DIR/docs/governance/AUDIT_REPORT_TEMPLATE.md" "Requirement test execution coverage (mandatory)" "Audit report requirement test coverage section present"

check_contains "$BASE_DIR/docs/governance/DELIVERY_PIPELINE_PROTOCOL.md" "PO executes official PR merge path." "PO merge authority in delivery protocol present"
check_contains "$BASE_DIR/docs/governance/GITHUB_RELEASE_PROTOCOL.md" 'Merge execution is performed by PO identity after `AUDIT=APPROVE`.' "PO merge authority in release protocol present"

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
