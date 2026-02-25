# Independent Audit Policy (Supportive Template)

Purpose:
Ensure independent release assurance with ISO-aligned evidence quality.

## 1. Independence rules
- DEV and AUDIT roles must be separated.
- DEV and AUDIT identities must differ in audit artifacts.
- AUDIT must not reuse DEV-only rationale/chat context.

## 2. Approved AUDIT input set
- DESIGN.md
- LASTENHEFT.md
- docs/specs/*.md
- change set (diff/commit)
- test/gate evidence
- traceability matrix

## 3. Prohibited AUDIT inputs
- DEV private reasoning notes
- hidden TODO lists not in formal artifacts
- undocumented side-channel instructions

## 4. Audit outputs
- Structured findings with severity.
- Evidence references (file, line, artifact).
- Decision: APPROVE / REJECT.
- CAPA linkage for nonconformities.

## 5. Mandatory ISO-conform security and data checks
AUDIT must produce explicit PASS/FAIL verdicts with evidence for:
- Data classification and processing boundaries per affected REQ-ID.
- Personal/sensitive data minimization, retention/deletion, and purpose fit.
- Secret/key/token handling (no hardcoded secrets; secure injection/storage path).
- Logging and telemetry redaction of personal/sensitive/credential data.
- Encryption controls for data at rest/in transit where applicable.
- Dependency risk controls (known-vulnerability exposure review).
- Baseline freshness check against `DESIGN.md`:
  - `SECURITY_BASELINE_REVIEW_UTC`
  - `SECURITY_BASELINE_MAX_AGE_DAYS`
  - `SECURITY_BASELINE_SOURCES`

Any missing control verdict or failed high-risk control requires `REJECT`.

## 6. ISO-aligned process expectations
- Quality management evidence retention.
- Access control and integrity of audit artifacts.
- Human oversight and accountability for AI-supported decisions.

Note:
This template is ISO-aligned guidance. Formal certification requires accredited external audit.
