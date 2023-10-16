#!/bin/bash

# Clean up previous build artifacts
echo "Cleaning up previous build artifacts ..."
rm -rf openmrs-config-kenyaemr
rm -rf frontend

# Build assets
echo "Building Kenya EMR 3.x assets ..."
CWD=$(pwd)
npx --legacy-peer-deps openmrs@next build \
  --build-config ./configuration/dev-build-config.json \
  --target ./frontend \
  --page-title "SSEMR" \
  --support-offline false

# Assemble assets
echo "Assembling assets ..."
npx --legacy-peer-deps openmrs@next assemble \
  --manifest \
  --mode config \
  --config ./configuration/dev-build-config.json \
  --target ./frontend

# Copy required files
echo "Copying required files ..."
cp "${CWD}/assets/login-icon.svg" "${CWD}/frontend"
cp "${CWD}/assets/primary-navigation.png" "${CWD}/frontend"
cp "${CWD}/assets/favicon.ico" "${CWD}/frontend"
cp "${CWD}/configuration/dev-config.json" "${CWD}/frontend"
mv "${CWD}/frontend/dev-config.json" "${CWD}/frontend/config.json"

# Exit with success status
exit 0
