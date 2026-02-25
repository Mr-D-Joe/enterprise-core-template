# Traceability Matrix Template

| REQ_ID | DESIGN_ID | Domain | Code_Target | Test_ID | Gate_Check | Status | Owner |
|---|---|---|---|---|---|---|---|
| UI-REQ-001 | DES-UI-001 | UI | frontend/src/... | test_ui_001 | dev_gate:req_trace | planned | DEV |
| BE-REQ-001 | DES-BE-001 | Backend | backend/src/... | test_be_001 | dev_gate:req_trace | planned | DEV |
| DB-REQ-001 | DES-DATA-001 | Data | backend/src/db/... | test_db_001 | audit_gate:req_coverage | planned | AUDIT |
| NFR-REQ-001 | DES-NFR-001 | NFR | scripts/... | test_nfr_001 | audit_gate:req_coverage | planned | AUDIT |

Rules:
1. Every active requirement must have a row.
2. Every changed requirement must update matrix references/status.
3. Missing mapping is release-blocking.
