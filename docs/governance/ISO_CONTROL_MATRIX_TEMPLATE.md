# ISO Control Matrix Template (ISO-aligned)

| Control Area | ISO Family | Requirement/Rule | Evidence Artifact | Owner | Status |
|---|---|---|---|---|---|
| Requirement quality | ISO 9001 style QMS controls | Atomic, testable requirements | spec files + lint output | PO | planned |
| Documented process | ISO 9001 style documented procedures | Design/Lastenheft/spec hierarchy | DESIGN.md, LASTENHEFT.md | PO | planned |
| Traceability | ISO 9001 style traceability and records | REQ->Design->Code->Test->Gate | trace matrix, gate logs | DEV | planned |
| Access and integrity | ISO 27001 style controls | separated roles and artifact integrity | audit policy, signed reports | AUDIT | planned |
| Independent assurance | ISO 9001/27001 governance | independent audit decision | audit report template | AUDIT | planned |
| Data classification | ISO 27001/27701 style controls | classified data and boundary mapping | specs + audit report | DEV/AUDIT | planned |
| Data minimization and retention | ISO 27701/privacy style controls | purpose fit + retention/deletion controls | specs + tests + audit report | DEV/AUDIT | planned |
| Secret management | ISO 27001 style controls | no hardcoded secrets + secure injection path | scans + config evidence + audit report | DEV/AUDIT | planned |
| Logging redaction | ISO 27001/privacy style controls | sensitive data redaction in logs/telemetry | log tests + audit report | DEV/AUDIT | planned |
| Encryption controls | ISO 27001 style controls | encryption at rest/in transit where applicable | design/config/test evidence | DEV/AUDIT | planned |
| Dependency risk management | ISO 27001/SSDF style controls | vulnerability exposure review and mitigation | dependency report + audit report | DEV/AUDIT | planned |
| Security baseline freshness | ISO governance style controls | baseline review age within allowed window | DESIGN metadata + audit readiness log | AUDIT | planned |
| AI governance oversight | ISO/IEC 42001 style controls | human oversight and accountability | decision records, CAPA | PO | planned |

Guidance:
- Replace `planned` with lifecycle state per release cycle.
- Keep artifact links immutable once released.
