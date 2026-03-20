# ARCHITECTURE

This document is normative and binding.

## Purpose
`ARCHITECTURE.md` is the single active root architecture document for this repository.
It defines the architecture model, structural decomposition, module model, boundary rules, layering principles, interface and contract boundary principles, structure correspondence rules, temporary mismatch handling, and ADR touchpoints.
It must remain architecture-focused, technically precise, and delegating where detailed technical truth belongs closer to the code.

## Scope
This document owns root architecture only.
It describes how the system is structurally cut and how modules, boundaries, layers, and contracts are expected to relate.
It does not own governance, runtime orchestration, blocker logic, runtime/toolchain policy, product-orientation detail, or detailed module-local implementation truth.

## Architecture stance
- The preferred default architecture is a modular monolith unless justified constraints require a different structure.
- Modules are cut along coherent capability boundaries rather than technical layers alone.
- Structural simplicity is preferred over premature distribution.
- Separate deployable units require explicit architectural justification.

## Level-1 structural view
At level 1, the repository is expected to decompose into:
- root canonical architecture and governance documents,
- bounded code modules,
- module-local documentation/specification near the code,
- bounded package execution context under `changes/`,
- supporting navigation and reference surfaces that do not replace module-local truth.

The root architecture view must stay structural.
Detailed technical behavior belongs in the owning module-local documentation/specification.

## Module model
Each module must represent one primary architectural responsibility.
Each module is expected to define, at architecture level:
- module identity,
- purpose,
- owned responsibility,
- public entry points or exposed interfaces,
- declared dependencies,
- inbound and outbound boundary expectations,
- owned data or state boundaries where applicable.

Detailed technical behavior, operating detail, and module-specific implementation truth belong near the code, not in this root document.

## Boundary rules
- Module boundaries must be explicit.
- Dependency direction across module boundaries must be intentional and limited.
- Cyclic dependencies between modules are forbidden.
- Internal implementation details must not be used across module boundaries.
- Shared access patterns that erase ownership boundaries are forbidden.
- Boundary crossings must occur through declared interfaces, contracts, or ports rather than implicit reach-through.

## Layering principles
Conceptual layers may be used where they clarify structure, such as:
- interface or API edge,
- application orchestration,
- domain logic,
- ports or abstractions,
- adapters or infrastructure.

The exact layer names may vary by implementation, but the architectural expectation remains:
- dependencies should point inward toward stable core logic,
- outer infrastructure and delivery concerns must not dominate inner domain structure,
- adapters implement boundary contracts rather than redefine them.

## Interface and contract boundary principles
- Interfaces at module boundaries must be explicit.
- Contracts must be defined before or alongside cross-boundary implementation.
- Boundary contracts should be version-aware where evolution is expected.
- Undocumented boundary payloads or implicit boundary semantics are forbidden.
- Interface choices should preserve module replaceability and boundary clarity.

This document defines the contract-first architectural principle only.
Detailed contract technology and runtime policy stay outside this file.

## Code, module, and documentation correspondence rule
Code structure, module structure, and near-code module-local documentation/specification must converge on the same architectural decomposition.
If the root architecture defines a module boundary, code and near-code documentation/specification must either reflect that boundary or carry an explicit temporary mismatch record.
Near-code documentation/specification is the active detailed technical truth layer for the owning module and must remain structurally aligned with the root architecture.

## Temporary mismatch rule
Architecture and implementation are allowed to diverge temporarily only when that divergence is explicit.
Any temporary mismatch must be recorded clearly with:
- the intended target structure,
- the current mismatch,
- the bounded reason for the mismatch,
- the expected cleanup path or isolating rule.

Silent structural drift is forbidden.
Unexplained mismatch between architecture, code, and near-code documentation/specification is invalid.

## ADR touchpoints
ADRs are required for major architectural decisions or explicit architectural exceptions, including when applicable:
- changing the top-level architecture style,
- introducing or removing major boundaries,
- approving structural exceptions,
- accepting long-lived mismatch or non-standard decomposition,
- introducing separate deployable units or materially different interface models.

This document references ADR touchpoints only.
It does not contain ADR history.
