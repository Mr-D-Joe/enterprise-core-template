# Backend Requirements — Template Project
## Modular specification: API and domain services

This document is normative for backend requirements.

Parent documents:
- `LASTENHEFT.md`
- `DESIGN.md`

## 3. Backend domain

### General Context (module-level)
- Service responsibilities:
- API contracts and constraints:
- Failure boundaries:
- Data classes processed by service:
- Secret/key handling boundary:
- Privacy, retention, and logging constraints:

### Requirements

#### 3.1 BE-REQ-01 — Reject Unknown Ticker Format
The system must reject invalid ticker formats before data-provider lookup.

**Requirement Context**
- Situation: API receives ticker query with disallowed characters.
- Assumption: Validation rule is applied in request schema layer.

**Business Intent**
- Reduce provider error rates and protect backend resources from invalid traffic.

**Security & Privacy Context**
- Data class: internal
- Personal data: none
- Secrets handling: token boundary limited to server runtime env
- Retention/deletion: request validation logs retained 14 days
- Logging/redaction: log only validation error code, never raw auth header or secrets

**Acceptance Criteria**
- AC-1: Invalid ticker returns HTTP 400 with stable error code `invalid_ticker_format`.
- AC-2: No downstream provider call is executed for invalid ticker input.

**Agent Contract**
- Target: `backend/src/...`
- Data-Flow: `api_request -> schema_validation -> service_handler`
- Error-State: `validation failure returns deterministic 400 response`
- Test-Vector: `pytest -q test_be_req_01`
- Security-Privacy: `data_class=internal; pii=none; secrets=runtime_env_only; retention=14d; logging=redacted; encryption=in_transit`
- Trace: `BE-REQ-01, DES-BE-001, TEST-BE-001, dev_gate:req_trace`
