# ARCHITECTURE — Modular Monolith Baseline

This document is normative and binding.

## Purpose
`ARCHITECTURE.md` is the canonical architecture source for this repository.
It owns the module model, boundary rules, layering, contracts, and cross-cutting architecture controls.

## Architecture stance
- Default architecture is a modular monolith.
- New microservices are forbidden unless an ADR documents at least two justified drivers:
  - materially different scaling profile,
  - distinct security or compliance boundary,
  - independently required release cadence,
  - incompatible runtime or technology need.
- Modules are organized around business capabilities, not technical layers alone.

## Module model
Every module must have a stable `MOD_ID` and exactly one primary business responsibility.

Each module must declare:
- purpose,
- scope,
- non-goals,
- owner,
- public entry points,
- public outbound ports,
- data ownership,
- dependencies,
- operational expectations or SLOs.

## Boundary rules
- No cyclic dependencies.
- No internal implementation access across module boundaries.
- No shared database access across module ownership boundaries.
- Domain logic must not depend on frameworks, ORM internals, transport details, or provider SDKs.
- Public APIs may be consumed; internal packages may not.

## Layering rules
Conceptual layers:
- `api`
- `application`
- `domain`
- `ports`
- `adapters`

Rules:
- dependency direction must remain inward,
- `domain` must not import frameworks, adapters, HTTP clients, DB drivers, transport details, or provider SDK types,
- adapters implement ports, never the reverse.

## Contract-first rules
- Synchronous interfaces must use OpenAPI where applicable.
- Async and message interfaces must use AsyncAPI where applicable.
- Contracts must be versioned.
- Undocumented payload formats are forbidden.
- Contract validation or code generation should be used where practical.

## Security and privacy architecture
Apply where applicable:
- OWASP ASVS,
- NIST SSDF,
- CISA Secure by Design.

At minimum:
- secure defaults,
- least privilege,
- server-side validation,
- no secrets in repository,
- dependency scanning,
- secret scanning,
- SAST,
- SBOM where practical,
- provenance/signing hooks where practical,
- no invented authentication if standard OIDC/OAuth-based approaches are intended.

Privacy-by-design is mandatory.
Modules touching personal data must document:
- data categories,
- purpose,
- retention,
- deletion path,
- logging restrictions.

Personal data must not appear in logs, traces, or events unless explicitly justified and protected.

## Observability architecture
- structured logs,
- metrics,
- traces,
- correlation and trace IDs,
- health and readiness conventions,
- OpenTelemetry-compatible patterns where appropriate.

## Structural truth
Code structure and documentation structure must mirror the same module and capability model.
If module-local docs define a boundary, code must reflect it or carry explicit mismatch evidence.

## Architecture fitness functions
Machine-checkable rules should be added where feasible:
- no-cycle checks,
- dependency direction checks,
- forbidden import checks,
- public-boundary checks,
- contract presence checks,
- module-documentation presence checks.

If a rule cannot be fully automated:
- do not fake it,
- document the limitation,
- implement the strongest practical fallback,
- mark the remainder as manual verification.

## Policy defaults
Repository-specific thresholds are policy defaults, not universal standards.
Prefer thresholds on:
- direct module dependencies,
- public interfaces,
- synchronous hops,
- ADR triggers,
- test and quality gates.
