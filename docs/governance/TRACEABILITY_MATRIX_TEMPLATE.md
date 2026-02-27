# Traceability Matrix Template

| REQ_ID | DESIGN_ID | Domain | Code_Target | Test_Pos_ID | Test_Pos_Evidence | Test_Pos_Result | Test_Neg_ID | Test_Neg_Evidence | Test_Neg_Result | Gate_Check | Status | Owner |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| UI-REQ-001 | DES-UI-001 | UI | frontend/src/... | test_ui_001_pos | reports/tests/ui_req_001_pos.txt | PASS | test_ui_001_neg | reports/tests/ui_req_001_neg.txt | PASS | dev_gate:req_trace | completed | DEV |
| BE-REQ-001 | DES-BE-001 | Backend | backend/src/... | test_be_001_pos | reports/tests/be_req_001_pos.txt | PASS | test_be_001_neg | reports/tests/be_req_001_neg.txt | PASS | dev_gate:req_trace | completed | DEV |
| DB-REQ-001 | DES-DATA-001 | Data | backend/src/db/... | test_db_001_pos | reports/tests/db_req_001_pos.txt | PASS | test_db_001_neg | reports/tests/db_req_001_neg.txt | PASS | audit_gate:req_coverage | completed | AUDIT |
| NFR-REQ-001 | DES-NFR-001 | NFR | scripts/... | test_nfr_001_pos | reports/tests/nfr_req_001_pos.txt | PASS | test_nfr_001_neg | reports/tests/nfr_req_001_neg.txt | PASS | audit_gate:req_coverage | completed | AUDIT |

Rules:
1. Every active requirement must have a row.
2. Every changed requirement must update matrix references/status.
3. Every active requirement row must include executed positive+negative test IDs, evidence links, and PASS results.
4. Missing mapping or missing positive/negative coverage is release-blocking.
