# LASTENHEFT — <PROJECT_NAME>

This document is normative.
It is the orientation-only project overview for humans and AI.
It is not the default coding context and must not become an operational implementation container.

Version: 1.0.0
Date: <YYYY-MM-DD>
Status: Active

## Planning metadata (machine-generated, mandatory)
- generated_at_utc=2026-03-12T11:59:26Z
- source_commit_sha=cdd149eb43ea95e139561a438274cd9b5b49aa28
- metrics_generation_mode=machine_only
- last_closed_package_id=GOV-HARDEN-20260312

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
