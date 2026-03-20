---
chg_id: CHG-YYYY-NNNN
package_id: PKG-YYYY-XXXX
status: DRAFT
req_ids:
  - REQ-PLACEHOLDER
mod_ids:
  - MOD-PLACEHOLDER
included_sources:
  - <execution-context-source-path>
excluded_sources:
  - <source-only-or-out-of-scope-path>
created_at_utc: YYYY-MM-DDTHH:MM:SSZ
updated_at_utc: YYYY-MM-DDTHH:MM:SSZ
---

# CHG-YYYY-NNNN -- Package Title

## Operative package context
This document is the bounded operative package context for the active package and active `chg_id`.
Only declared execution-context inputs belong here.
Source-only documents remain source documents unless their bounded package slice is explicitly extracted below.
When implementation-facing behavior, boundaries, contracts, or operating context are technically affected, the affected module-local documentation/specification near the code is an expected execution-context input and must be declared explicitly.

## Package goal
- 

## Package scope
- Active package_id: PKG-YYYY-XXXX
- Active req_ids:
- Affected mod_ids:
- In-scope paths:
- Out-of-scope paths:

## Execution-context inputs
List only the documents or paths that are actual execution-context inputs for this package.
Do not list broad default sources by habit.
Include affected module-local documentation/specification near the code when the package changes implementation-facing behavior, boundaries, contracts, or operating context.

- <path>: <why this source is required for execution>

## Source-only documents and extracted slices
### Backlog package slice
Source-only document: `docs/BACKLOG.md`
- Extracted slice included: yes/no
- Active package row:
- Next relevant package relation:
- Package-control notes required for execution:

### Changelog slice
Source-only document: `CHANGELOG.md`
- Extracted slice included: yes/no
- Required history:
- Why relevant:

### Lastenheft slice
Source-only document: `LASTENHEFT.md`
- Extracted slice included: yes/no
- Trigger:
- Relevant excerpt:

### ADR slice
Source-only document: ADRs
- Extracted slice included: yes/no
- Governing ADRs:
- Why required:

### Affected module-local documentation/specification
Execution-context input category for technically affected modules.
- Included as execution-context input: yes/no
- Owning module paths:
- Why required for this package:

### Neighbor-module documentation
- Included as execution-context input: yes/no
- Direct dependency reason:

## Excluded or out-of-scope sources
- <path>: <why excluded or out of scope>

## Execution constraints
- Non-goals:
- Contracts affected:
- Data model affected:
- Security and privacy impact:
- Explicitly excluded paths or modules:

## Verification targets
- Pass or fail criteria:
- Required tests and checks:

## Reporting chronology
- Earlier observed state:
- Repaired state:
- Final verified state:
- Files changed after earlier assessment:

## Residue and proof checks
- Edited files re-read:
- Forbidden-residue check:
- Final-state rerun checks:

## Final report accuracy classification
- ACCURATE | PARTIALLY_ACCURATE | MISLEADING | FALSE
