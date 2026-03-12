# STACK — Runtime And Tooling Policy

This document is normative and binding.

## Purpose
`STACK.md` is the canonical stack, runtime, and tooling policy source for this repository.
It owns technology profiles, runtime/compiler policy, and tooling-decision defaults.

## Technology profile matrix
Tooling must start with one profile selection before implementation.

| Profile ID | UI/Frontend | Backend/API | Data | Mobile | Apply when |
|---|---|---|---|---|---|
| `PROFILE_WEB_DEFAULT` | Next.js + React + TypeScript | FastAPI | PostgreSQL | Optional React Native + Expo | Default for customer-facing web products and SaaS |
| `PROFILE_ENTERPRISE_PORTAL` | Angular + TypeScript | FastAPI | PostgreSQL | Optional React Native + Expo | Data-heavy internal workflows with strict structure |
| `PROFILE_SERVER_RENDERED_LIGHT` | htmx + server-rendered templates | FastAPI | PostgreSQL or SQLite | none | Form or workflow apps where low client complexity is a goal |
| `PROFILE_MOBILE_CROSS_PLATFORM` | React Native + Expo + TypeScript | FastAPI | PostgreSQL | iOS + Android from one codebase | Cross-platform parity required |
| `PROFILE_MOBILE_IOS_FIRST` | SwiftUI + minimal web admin UI | FastAPI | PostgreSQL | Native iOS first | Apple-platform quality is the primary driver |

## Tool selection policy
1. Select one `application_profile` before any implementation starts.
2. Production web UI must be type-safe. Plain JavaScript is allowed only for static or minimal pages.
3. Production dependencies must be stable or LTS unless a PO-approved exception exists.
4. Tool decisions must be backed by official sources and verification dates.
5. Runtime and compiler versions for active scope must target latest stable releases unless a valid exception exists.
6. Python virtual environment path is fixed to project root `.venv`.

## Canonical tooling decision packet
`system_reports/gates/tooling_decision_template.env` must include at least:
- `decision_packet_id`
- `decision_status`
- `scope_req_ids`
- `application_profile`
- `frontend_ui_choice`
- `backend_choice`
- `data_choice`
- `mobile_choice`
- `stability_target`
- `python_version_choice`
- `node_version_choice`
- `dotnet_version_choice`
- `cc_choice`
- `cxx_choice`
- `official_source_1`
- `official_source_2`
- `source_verified_utc`
- `tooling_source_max_age_days`
- `selection_rationale`
- `tradeoffs`
- `fallback_option`
- `created_at_utc`

## Policy defaults
These values are repository policy defaults, not universal standards:
- `TOOLING_SOURCE_MAX_AGE_DAYS=90`
- `RUNTIME_FITNESS_MAX_AGE_DAYS=90`
- `PLANNING_METADATA_MAX_AGE_DAYS=90`

## Source requirements
Tooling and runtime decisions must reference official sources only:
- official documentation,
- official release notes,
- official version matrices.

## Runtime and compiler policy
Active runtime and compiler choices must be evidenced for the in-scope stack:
- Python
- Node.js
- .NET
- C
- C++

Customer-facing manual setup prompts are forbidden.
Runtime bootstrap must happen automatically where feasible and produce machine-readable evidence.
