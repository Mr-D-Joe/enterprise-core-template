# Spec Lint Rules

Required for each requirement block:
- Requirement header with unique REQ-ID.
- Requirement statement containing `must`.
- `Requirement Context` section.
- `Business Intent` section.
- `Security & Privacy Context` section.
- `Acceptance Criteria` section (>=1 AC item).
- `Agent Contract` section with:
  - Target
  - Data-Flow
  - Error-State
  - Test-Vector
  - Security-Privacy (`data_class=...; pii=...; secrets=...; retention=...; logging=...; encryption=...`)
  - Trace

Trace format requirement:
- `Trace` must include: `REQ-ID, DESIGN-ID, TEST-ID, GATE-CHECK`.

Global rules:
- No unresolved placeholders in finalized specs.
- No duplicate REQ-IDs.
- Optional fields only when relevant.
