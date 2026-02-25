#!/usr/bin/env bash
set -euo pipefail

SPEC_DIR="docs/specs"
STRICT_MODE="false"

if [[ "${1:-}" == "--strict" ]]; then
  STRICT_MODE="true"
fi

if [[ ! -d "$SPEC_DIR" ]]; then
  echo "ERROR: $SPEC_DIR not found. Run from project root."
  exit 1
fi

EXIT_CODE=0

check_required_global() {
  local file="$1"
  for hdr in "### General Context (module-level)"; do
    if ! grep -Fq "$hdr" "$file"; then
      echo "FAIL $file missing global section: $hdr"
      EXIT_CODE=1
    fi
  done
}

check_requirement_blocks() {
  local file="$1"
  awk -v file="$file" '
  BEGIN {
    in_req=0; req=""; rc=0;
  }
  function fail(msg) {
    printf("FAIL %s %s\n", file, msg);
    rc=1;
  }
  function reset_flags() {
    has_must=0; has_reqctx=0; has_intent=0; has_ac=0;
    has_secctx=0; has_contract=0; has_target=0; has_flow=0; has_err=0; has_test=0; has_secpriv=0; has_trace=0;
  }
  function validate_req() {
    if (!in_req) return;
    if (!has_must) fail(req " missing must-statement");
    if (!has_reqctx) fail(req " missing Requirement Context");
    if (!has_intent) fail(req " missing Business Intent");
    if (!has_secctx) fail(req " missing Security & Privacy Context");
    if (!has_ac) fail(req " missing Acceptance Criteria");
    if (!has_contract) fail(req " missing Agent Contract");
    if (!has_target) fail(req " missing Target");
    if (!has_flow) fail(req " missing Data-Flow");
    if (!has_err) fail(req " missing Error-State");
    if (!has_test) fail(req " missing Test-Vector");
    if (!has_secpriv) fail(req " missing Security-Privacy");
    if (!has_trace) fail(req " missing Trace");
  }
  /^#### / {
    validate_req();
    in_req=1; req=$0; reset_flags();
    next;
  }
  {
    if (!in_req) next;
    line=$0;
    if (line ~ /^[Tt]he system must /) has_must=1;
    if (line ~ /^\*\*Requirement Context\*\*/) has_reqctx=1;
    if (line ~ /^\*\*Business Intent\*\*/) has_intent=1;
    if (line ~ /^\*\*Security & Privacy Context\*\*/) has_secctx=1;
    if (line ~ /^\*\*Acceptance Criteria\*\*/) has_ac=1;
    if (line ~ /^\*\*Agent Contract\*\*/) has_contract=1;
    if (line ~ /^- Target: /) has_target=1;
    if (line ~ /^- Data-Flow: /) has_flow=1;
    if (line ~ /^- Error-State: /) has_err=1;
    if (line ~ /^- Test-Vector: /) has_test=1;
    if (line ~ /^- Security-Privacy: /) {
      has_secpriv=1;
      sec=line;
      if (sec !~ /data_class=/) fail(req " Security-Privacy missing data_class");
      if (sec !~ /pii=/) fail(req " Security-Privacy missing pii");
      if (sec !~ /secrets=/) fail(req " Security-Privacy missing secrets");
      if (sec !~ /retention=/) fail(req " Security-Privacy missing retention");
      if (sec !~ /logging=/) fail(req " Security-Privacy missing logging");
      if (sec !~ /encryption=/) fail(req " Security-Privacy missing encryption");
    }
    if (line ~ /^- Trace: /) {
      has_trace=1;
      trace=line;
      gsub(/^- Trace: /, "", trace);
      n=split(trace, parts, ",");
      if (n < 4) fail(req " Trace must include REQ-ID, DESIGN-ID, TEST-ID, GATE-CHECK");
    }
  }
  END {
    validate_req();
    exit rc;
  }
  ' "$file" || EXIT_CODE=1
}

check_placeholders_strict() {
  local file="$1"
  if grep -nE "\[[^\]]+\]" "$file" >/dev/null; then
    echo "FAIL $file unresolved placeholder tokens found"
    EXIT_CODE=1
  fi
  if grep -nE "<[^>]+>" "$file" >/dev/null; then
    echo "FAIL $file unresolved angle-bracket placeholders found"
    EXIT_CODE=1
  fi
  if grep -nE "\b(TBD|TODO|XXX)\b" "$file" >/dev/null; then
    echo "FAIL $file unresolved planning token found (TBD/TODO/XXX)"
    EXIT_CODE=1
  fi
}

while IFS= read -r file; do
  echo "CHECK $file"
  check_required_global "$file"
  check_requirement_blocks "$file"
  if [[ "$STRICT_MODE" == "true" ]]; then
    check_placeholders_strict "$file"
  fi
  if grep -qi "n/a" "$file"; then
    echo "WARN $file contains n/a; remove irrelevant optional fields in finalized specs"
  fi
done < <(find "$SPEC_DIR" -type f -name "*.md" -not -path "*/_archive/*" | sort)

if [[ "$EXIT_CODE" -eq 0 ]]; then
  echo "PASS spec-lint"
else
  echo "FAIL spec-lint"
fi
exit "$EXIT_CODE"
