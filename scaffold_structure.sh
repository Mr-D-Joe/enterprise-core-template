#!/bin/bash

# Scaffold Structure Script
# Purpose: Ensure consistent sub-project creation (Frontend/AI Service)

echo "Enterprise Core Template - Scaffolding"
echo "======================================"

if [ -d "frontend" ]; then
    echo "[INFO] /frontend already exists."
else
    echo "[INIT] Creating /frontend..."
    # Using 'create-vite' non-interactively if arguments were provided, otherwise just creating dir
    mkdir -p frontend
    echo "[HINT] Run 'npx create-vite@latest frontend --template react-ts' to initialize inside."
fi

if [ -d "ai_service" ]; then
    echo "[INFO] /ai_service already exists."
else
    echo "[INIT] Creating /ai_service..."
    mkdir -p ai_service
    touch ai_service/.gitkeep
    echo "[INFO] /ai_service directory created."
fi

if [ -d "shared" ]; then
    echo "[INFO] /shared already exists."
else
    echo "[INIT] Creating /shared (optional)..."
    mkdir -p shared
    cat <<'EOF' > shared/README.md
# Shared Contracts (Optional)

This directory is used when contracts must be shared across layers.

## Purpose
- IPC and JSON type definitions
- Shared DTOs and protocol schemas

## Governance Constraints
- Must comply with DESIGN.md (DES-ARCH-15–18)
- Changes require synchronized documentation updates

## When to Use
- If the target platform requires IPC or shared contracts

EOF
    echo "[INFO] /shared directory created with README."
fi

if [ -d "desktop" ]; then
    echo "[INFO] /desktop already exists."
else
    echo "[INIT] Creating /desktop (optional)..."
    mkdir -p desktop
    cat <<'EOF' > desktop/README.md
# Desktop Shell (Optional)

This directory is used only when the target platform is **Desktop**.

## Purpose
- Host the frontend in a desktop runtime
- Provide IPC, filesystem access, local caching, and packaging

## Governance Constraints
- Must comply with DESIGN.md (DES-ARCH-04/05/08/19–22)
- No new architectural layers without DESIGN.md change

## When to Use
- If LASTENHEFT.md sets the target platform to **Desktop**

EOF
    echo "[INFO] /desktop directory created with README."
fi

echo "======================================"
echo "Scaffolding verification complete."
