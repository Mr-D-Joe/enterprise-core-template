# LASTENHEFT — <PROJECT_NAME>

This document is normative.
It is the orientation-only project overview for humans and AI.
It is not the default coding context and must not become an operational implementation container.
It may enter active execution context only when the active package changes scope/non-scope, key business terms, capability/module map, product-level functional intent, or high-level quality goals, and then only as a bounded excerpt derived into the active `changes/CHG-*.md`.

Version: 1.0.1
Date: 2026-03-12
Status: Closed

## Planning metadata (machine-generated, mandatory)
- generated_at_utc=2026-03-12T18:55:15Z
- source_commit_sha=9f26c9170697ae0f0ac8d4289e2ec1af3a756f55
- metrics_generation_mode=machine_only
- last_closed_package_id=TPL-RESTRUCTURE-20260312-01

## Purpose
- Project goal:
- Target users:
- Platform target:

## Scope
- In scope:
- Out of scope:

## Key terms
- Primary business terms:
- Critical domain concepts:

## Capability and module map
| Capability | MOD_ID | Primary path | Public interfaces | Notes |
|---|---|---|---|---|
| Governance root | MOD-GOV-ROOT | `AGENTS.md`, `DESIGN.md`, `ARCHITECTURE.md`, `STACK.md`, `CONTRIBUTING.md`, `PROMPTS.md` | root governance docs | canonical repository governance |
| Template scaffolds | MOD-GOV-TEMPLATE | `docs/templates/`, `changes/`, `bootstrap_project.sh` | bootstrap and scaffolds | reusable neutral template assets |
| Gates and audits | MOD-GOV-GATES | `scripts/`, `docs/governance/` | gate scripts, CI, audit artifacts | enforcement and evidence support |

## High-level quality goals
- Atomic requirements and bounded change packages.
- Independent audit before release.
- Security-by-default and privacy-by-design.
- Token-efficient AI working context.
- Structural alignment between code, documentation, and contracts.

## Orientation rules
- Detailed implementation guidance belongs in module-local documentation.
- Concrete change execution belongs in `changes/CHG-*.md`.
- Release history belongs in `CHANGELOG.md`.
- Active package control belongs in `docs/BACKLOG.md`.
