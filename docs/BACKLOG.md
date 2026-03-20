# BACKLOG

This document is the compact package-control surface for the repository.
It is human-readable, AI-usable, and not default execution context.
Detailed execution context belongs in `changes/CHG-*.md`, not in backlog rows.
All package rows must remain compact and non-narrative.

## Metadata
This section is mandatory and machine-readable.
Required keys:
- `active_package_id`
- `next_package_id`
- `next_after_next_package_id`
- `control_role`
- `default_execution_context`
- `detailed_execution_context_path`
- `package_row_status_values`

active_package_id=<package_id|none>
next_package_id=<package_id|none>
next_after_next_package_id=<package_id|none>
control_role=package_control_only
default_execution_context=false
detailed_execution_context_path=changes/CHG-*.md
package_row_status_values=open,active,closed

## Active package
Exactly one visible active package row is allowed when work is in progress.
If no package is active, show exactly one explicit no-active-package display state.
Normal package rows in this section use only the package-row status `active`.
Mandatory columns:
- status
- package_id
- req_ids
- owner
- evidence_paths
- updated_at_utc

| status | package_id | req_ids | owner | evidence_paths | updated_at_utc |
|---|---|---|---|---|---|
| active | PKG-YYYY-0001 | REQ-001,REQ-002 | PO | changes/CHG-YYYY-0001.md;system_reports/gates/current_dev_gate.env | YYYY-MM-DDTHH:MM:SSZ |

No-active-package display example:

| active_package_state | package_id | req_ids | owner | evidence_paths | updated_at_utc |
|---|---|---|---|---|---|
| none | none | none | none | none | YYYY-MM-DDTHH:MM:SSZ |

## Open packages
Open packages are ordered by priority first and customer value second, highest first.
Rows in this section must use only the package-row status `open`.
Mandatory columns:
- priority
- customer_value
- status
- package_id
- req_ids
- owner
- evidence_paths
- updated_at_utc

| priority | customer_value | status | package_id | req_ids | owner | evidence_paths | updated_at_utc |
|---|---|---|---|---|---|---|---|
| 1 | high | open | PKG-YYYY-0002 | REQ-003 | PO | changes/CHG-YYYY-0002.md | YYYY-MM-DDTHH:MM:SSZ |
| 2 | medium | open | PKG-YYYY-0003 | REQ-004,REQ-005 | PO | changes/CHG-YYYY-0003.md;system_reports/gates/po_role_packet_dev.env | YYYY-MM-DDTHH:MM:SSZ |

## Closed packages
Closed packages are ordered by completion time, newest first.
Rows in this section must use only the package-row status `closed`.
Mandatory columns:
- closed_at_utc
- status
- package_id
- req_ids
- owner
- evidence_paths

| closed_at_utc | status | package_id | req_ids | owner | evidence_paths |
|---|---|---|---|---|---|
| YYYY-MM-DDTHH:MM:SSZ | closed | PKG-YYYY-0001 | REQ-001,REQ-002 | PO | changes/CHG-YYYY-0001.md;system_reports/gates/current_audit_gate.env |
| YYYY-MM-DDTHH:MM:SSZ | closed | PKG-YYYY-0000 | REQ-000 | PO | changes/CHG-YYYY-0000.md |

## Unrefactored changes
This section is for known changes that are not yet refactored into bounded package rows.
These are not package rows and must not use the main package-row status vocabulary.
Mandatory columns:
- change_id
- change_kind
- short_description
- target_package_id
- noted_at_utc

| change_id | change_kind | short_description | target_package_id | noted_at_utc |
|---|---|---|---|---|
| UC-001 | pending_refactor | Replace placeholder package control data with real package rows | PKG-YYYY-0002 | YYYY-MM-DDTHH:MM:SSZ |
| UC-002 | residual_cleanup | Clean residual legacy planning note after migration | none | YYYY-MM-DDTHH:MM:SSZ |
