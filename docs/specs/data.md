# Data Requirements — Template Project
## Modular specification: Persistence and data lifecycle

This document is normative for data requirements.

Parent documents:
- `LASTENHEFT.md`
- `DESIGN.md`

## 4. Data domain

### General Context (module-level)
- Data lifecycle model:
- Persistence constraints:
- Integrity constraints:
- Data classification model:
- Retention/deletion policy:
- Encryption and key management constraints:

### Requirements

#### 4.1 DB-REQ-01 — Cache Price Snapshots with Retention
The system must persist ticker price snapshots with deterministic retention and purge behavior.

**Requirement Context**
- Situation: Backend receives validated market data response for tracked ticker.
- Assumption: Storage write happens after schema normalization.

**Business Intent**
- Ensure reproducible historical views while controlling storage growth and privacy risk.

**Security & Privacy Context**
- Data class: internal
- Personal data: none
- Secrets handling: database credentials only via secret store injection
- Retention/deletion: retain snapshots for 365 days, then purge daily
- Logging/redaction: never log raw credentials or connection strings

**Acceptance Criteria**
- AC-1: Snapshot record is written once per successful normalized response.
- AC-2: Records older than 365 days are deleted by scheduled purge job.

**Agent Contract**
- Target: `backend/src/db/...`
- Data-Flow: `normalized_market_data -> persistence_layer -> snapshot_table`
- Error-State: `write failure returns retryable error without partial commit`
- Test-Vector-Positive: `pytest -q test_db_req_01_pos`
- Test-Vector-Negative: `pytest -q test_db_req_01_neg`
- Security-Privacy: `data_class=internal; pii=none; secrets=secret_store_only; retention=365d; logging=redacted; encryption=at_rest_and_in_transit`
- Trace: `DB-REQ-01, DES-DATA-001, TEST-DB-001, audit_gate:req_coverage`
