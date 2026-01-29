# Artifact Index
Status: TEMPLATE
ORDER LOCKED

IMMUTABLE HEADER BLOCK (LINES 1–3) — DO NOT EDIT

## Immutable Header Block Policy

- Lines 1–5 are immutable.
- Any change to the header block requires an update to:
  1. `docs/GOVERNANCE_LINT_SPEC.md`
  2. `docs/RELEASE_CHECKLIST.md`
  3. `CHANGELOG.md`

## Artifact Index Update Protocol

1. **Add new DOC-IDs** only in `docs/artifact_index.md` first.
2. **Update the source artifact file** with the new DOC-ID section.
3. **Keep order locked**: sections and IDs must remain in the defined order.
4. **Update TECHNICAL_SPEC.md** Section 6 mapping when artifacts change.
5. **Update CHANGELOG.md** with a new version entry.

## DOC-API
- DOC-API-01 — Overview (docs/api_spec.md)
- DOC-API-02 — Endpoints (docs/api_spec.md)
- DOC-API-03 — Error Model (docs/api_spec.md)
- DOC-API-04 — Versioning (docs/api_spec.md)

## DOC-IPC
- DOC-IPC-01 — Message Types (shared/ipc_contracts.md)
- DOC-IPC-02 — Error Objects (shared/ipc_contracts.md)
- DOC-IPC-03 — Versioning (shared/ipc_contracts.md)

## DOC-DESK
- DOC-DESK-01 — Runtime Choice (desktop/runtime_config.md)
- DOC-DESK-02 — IPC Bridge (desktop/runtime_config.md)
- DOC-DESK-03 — Local Storage (desktop/runtime_config.md)
- DOC-DESK-04 — Packaging Hooks (desktop/runtime_config.md)

## DOC-PACK
- DOC-PACK-01 — Build Targets (desktop/packaging.md)
- DOC-PACK-02 — Signing (desktop/packaging.md)
- DOC-PACK-03 — Distribution (desktop/packaging.md)

## DOC-FE
- DOC-FE-01 — Build Tool (frontend/build_config.md)
- DOC-FE-02 — Environment Variables (frontend/build_config.md)
- DOC-FE-03 — Output Targets (frontend/build_config.md)

## DOC-BE
- DOC-BE-01 — Runtime (ai_service/runtime_config.md)
- DOC-BE-02 — Dependencies (ai_service/runtime_config.md)
- DOC-BE-03 — Environment Variables (ai_service/runtime_config.md)
- DOC-BE-04 — Deployment (ai_service/runtime_config.md)
