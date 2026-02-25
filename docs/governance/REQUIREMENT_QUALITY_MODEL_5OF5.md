# Requirement Quality Model (5/5)

Scoring scale:
- 1/5: ambiguous and non-testable.
- 2/5: intent exists but verification is weak.
- 3/5: testable with partial traceability/determinism.
- 4/5: deterministic and traceable with minor gaps.
- 5/5: concise, deterministic, testable, maintainable, auditable.

Criteria (20% each):

1. Clarity and Atomicity
- One requirement property per requirement block.
- Uses `must` with explicit scope.

2. Verifiability
- Objective acceptance criteria.
- Explicit error/negative behavior where relevant.

3. Traceability
- Explicit REQ -> Design -> Code -> Test -> Gate mapping.
- Matrix row exists for each active requirement.

4. LLM Determinism
- Concrete target, data flow, error state, and test vector.
- No irrelevant metadata bloat.

5. Maintainability
- Lean, readable requirement blocks.
- Drift control for path/test references.

Exit conditions for 5/5:
- Weighted score >= 4.6/5.0
- No criterion below 4.0
- No high-severity traceability gap
- No high-severity drift finding
- Independent audit readiness check passes
