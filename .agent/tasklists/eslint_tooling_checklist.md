# ESLint Tooling Checklist (Local)

Status date: 2026-02-02
Owner: Joern
Scope: enterprise-core-template guidance update

## What happened
- Root cause in downstream project: ESLint hang traced to `@typescript-eslint/eslint-plugin` import; installation corruption (missing eslint.js) resolved by clean reinstall.
- Guidance update: avoid plugin if it hangs under Node LTS; use `tsc` for unused/undef checks in TS projects.

## Current state
- Documentation updated in CONTRIBUTING.md and CHANGELOG.md.
- Branch pushed: `agent/eslint-config-note`.

## Why this is enterprise-safe
- Enforces deterministic tooling by recommending Node LTS and compiler-based checks.
- Avoids unstable plugin import path until verified.

## Next actions
- Open PR and paste approved PR description.
- Merge after review.

## References
- PR link: https://github.com/Mr-D-Joe/enterprise-core-template/pull/new/agent/eslint-config-note
