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

echo "Running independent audit readiness check..."

req_file "$BASE_DIR/DESIGN.md"
req_file "$BASE_DIR/AGENTS.md"
req_file "$BASE_DIR/CONTRIBUTING.md"
req_file "$BASE_DIR/PROMPTS.md"
req_file "$BASE_DIR/docs/governance/INDEPENDENT_AUDIT_POLICY.md"
req_file "$BASE_DIR/docs/governance/ISO_CONTROL_MATRIX_TEMPLATE.md"
req_file "$BASE_DIR/docs/governance/AUDIT_REPORT_TEMPLATE.md"
req_file "$BASE_DIR/docs/governance/TRACEABILITY_MATRIX_TEMPLATE.md"
req_file "$BASE_DIR/docs/governance/DELIVERY_PIPELINE_PROTOCOL.md"
req_file "$BASE_DIR/docs/governance/GITHUB_RELEASE_PROTOCOL.md"

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
check_contains "$BASE_DIR/DESIGN.md" "SECURITY_BASELINE_REVIEW_UTC=" "Security baseline review metadata in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "SECURITY_BASELINE_MAX_AGE_DAYS=" "Security baseline max-age metadata in DESIGN"
check_contains "$BASE_DIR/DESIGN.md" "SECURITY_BASELINE_SOURCES=" "Security baseline source metadata in DESIGN"

check_contains "$BASE_DIR/AGENTS.md" "PO (Product Owner) — primary control strand" "PO role in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "DEV (Implementation) — execution strand" "DEV role in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "AUDIT (Independent) — execution strand" "AUDIT role in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" 'distinct identities (`AGENT_ID` and runtime evidence)' "Identity separation in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "No self-approval" "No self-approval in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "Audit input firewall" "Audit firewall in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "Security and privacy non-negotiables" "Security/privacy section in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "No hardcoded credentials, API keys, tokens, or private certificates" "No hardcoded secrets rule in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "No secret or personal data exfiltration" "No secret/PII exfiltration rule in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "ISO-conform security/data checklist" "ISO-conform checklist enforcement in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "machine-readable artifact with required keys" "Role packet artifact requirement in AGENTS"
check_contains "$BASE_DIR/AGENTS.md" "allowed_inputs_hash" "Role packet key list in AGENTS"

check_contains "$BASE_DIR/CONTRIBUTING.md" "Requirement definition and approval (PO)" "Requirement phase in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Independent Audit gate (AUDIT)" "Audit phase in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Hard blockers (automatic FAIL)" "Hard blockers in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "NOT_READY_FOR_RELEASE" "Release fail semantics in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "security/privacy checks executed and linked" "Security/privacy checks in DEV phase"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Missing security/privacy traceability or missing security/privacy evidence." "Security/privacy blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Hardcoded secrets/keys/tokens or unredacted personal data" "Secret/PII blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Missing ISO security/data control verdicts in audit report." "ISO security/data verdict blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Security baseline age exceeds configured maximum age." "Security baseline age blocker in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "machine-readable PO role packet exists with required keys" "Role packet entry criterion in CONTRIBUTING"
check_contains "$BASE_DIR/CONTRIBUTING.md" "Missing required role packet keys" "Role packet key blocker in CONTRIBUTING"

check_contains "$BASE_DIR/PROMPTS.md" "AUDIT execution mode contract" "AUDIT mode section in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" "Forbidden input set" "Forbidden audit inputs in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Any independence violation => `FINAL_STATUS=FAIL`' "Independence fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Any unresolved blocker/major finding => `FINAL_STATUS=FAIL`' "Blocker fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Any mode-mixing or wrong role packet => `FINAL_STATUS=FAIL`' "Execution-mode fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Any unresolved security/privacy blocker => `FINAL_STATUS=FAIL`' "Security/privacy fail semantics in PROMPTS"
check_contains "$BASE_DIR/PROMPTS.md" 'Missing ISO security/data control verdicts => `FINAL_STATUS=FAIL`' "ISO security/data fail semantics in PROMPTS"
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

check_contains "$BASE_DIR/docs/governance/INDEPENDENT_AUDIT_POLICY.md" "Mandatory ISO-conform security and data checks" "ISO-conform security/data section in audit policy"
check_contains "$BASE_DIR/docs/governance/INDEPENDENT_AUDIT_POLICY.md" 'Any missing control verdict or failed high-risk control requires `REJECT`.' "Mandatory reject rule in audit policy"
check_contains "$BASE_DIR/docs/governance/INDEPENDENT_AUDIT_POLICY.md" "SECURITY_BASELINE_MAX_AGE_DAYS" "Baseline age control in audit policy"

check_contains "$BASE_DIR/docs/governance/AUDIT_REPORT_TEMPLATE.md" "ISO security/data control verdicts (mandatory)" "Security/data section in audit report template"
check_contains "$BASE_DIR/docs/governance/AUDIT_REPORT_TEMPLATE.md" 'Baseline freshness (`SECURITY_BASELINE_REVIEW_UTC` age <= `SECURITY_BASELINE_MAX_AGE_DAYS`): PASS/FAIL' "Baseline freshness line in audit report template"
check_contains "$BASE_DIR/docs/governance/AUDIT_REPORT_TEMPLATE.md" "Secret/key/token management (no hardcoded secrets): PASS/FAIL" "Secret management line in audit report template"
check_contains "$BASE_DIR/docs/governance/AUDIT_REPORT_TEMPLATE.md" "Dependency risk/vulnerability review: PASS/FAIL" "Dependency risk line in audit report template"
check_contains "$BASE_DIR/docs/governance/AUDIT_REPORT_TEMPLATE.md" "- APPROVE / REJECT" "Binary decision vocabulary in audit report template"

check_contains "$BASE_DIR/docs/governance/ISO_CONTROL_MATRIX_TEMPLATE.md" "| Data classification |" "Data classification row in ISO control matrix"
check_contains "$BASE_DIR/docs/governance/ISO_CONTROL_MATRIX_TEMPLATE.md" "| Data minimization and retention |" "Data minimization/retention row in ISO control matrix"
check_contains "$BASE_DIR/docs/governance/ISO_CONTROL_MATRIX_TEMPLATE.md" "| Secret management |" "Secret management row in ISO control matrix"
check_contains "$BASE_DIR/docs/governance/ISO_CONTROL_MATRIX_TEMPLATE.md" "| Logging redaction |" "Logging redaction row in ISO control matrix"
check_contains "$BASE_DIR/docs/governance/ISO_CONTROL_MATRIX_TEMPLATE.md" "| Encryption controls |" "Encryption row in ISO control matrix"
check_contains "$BASE_DIR/docs/governance/ISO_CONTROL_MATRIX_TEMPLATE.md" "| Dependency risk management |" "Dependency risk row in ISO control matrix"
check_contains "$BASE_DIR/docs/governance/ISO_CONTROL_MATRIX_TEMPLATE.md" "| Security baseline freshness |" "Baseline freshness row in ISO control matrix"

check_contains "$BASE_DIR/docs/governance/DELIVERY_PIPELINE_PROTOCOL.md" "PO executes official PR merge path." "PO merge execution in delivery protocol"
check_contains "$BASE_DIR/docs/governance/GITHUB_RELEASE_PROTOCOL.md" 'Merge execution is performed by PO identity after `AUDIT=APPROVE`.' "PO merge execution in release protocol"

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
