# Audit Report Template

## Audit metadata
- Audit ID:
- Date (UTC):
- Commit/Release ref:
- Auditor identity:
- Dev identity:
- Independence check: PASS/FAIL

## Scope and inputs
- Included artifacts:
- Excluded artifacts:

## Findings
| Severity | REQ_ID | Description | Evidence | Required Action |
|---|---|---|---|---|

## Traceability verification
- Matrix completeness: PASS/FAIL
- Missing mappings:

## Requirement test execution coverage (mandatory)
- Total executed tests (>0): PASS/FAIL
- Executed positive tests (>0): PASS/FAIL
- Executed negative tests (>0): PASS/FAIL
- Missing per-REQ positive/negative coverage:
| REQ_ID | Positive_Test_ID | Positive_Evidence | Positive_Result | Negative_Test_ID | Negative_Evidence | Negative_Result | Coverage_Verdict |
|---|---|---|---|---|---|---|---|
| <REQ_ID> | <TEST_POS_ID> | <artifact/link> | PASS/FAIL | <TEST_NEG_ID> | <artifact/link> | PASS/FAIL | PASS/FAIL |

## ISO-aligned control check
- Quality process evidence: PASS/FAIL
- Integrity/access control evidence: PASS/FAIL
- AI oversight evidence: PASS/FAIL

## ISO security/data control verdicts (mandatory)
- Baseline freshness (`SECURITY_BASELINE_REVIEW_UTC` age <= `SECURITY_BASELINE_MAX_AGE_DAYS`): PASS/FAIL
- Data classification and boundary controls: PASS/FAIL
- Personal/sensitive data minimization + retention/deletion: PASS/FAIL
- Secret/key/token management (no hardcoded secrets): PASS/FAIL
- Logging/telemetry redaction controls: PASS/FAIL
- Encryption controls (at rest/in transit where applicable): PASS/FAIL
- Dependency risk/vulnerability review: PASS/FAIL
- Evidence references:
  - <artifact/link 1>
  - <artifact/link 2>

## Decision
- APPROVE / REJECT
- Rationale:

## CAPA linkage
- CAPA ticket(s):
- Due date(s):
