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

echo "======================================"
echo "Scaffolding verification complete."
