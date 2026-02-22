#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "${REPO_ROOT}"

echo "-> Initializing Terraform (no-backend)..."
terraform init -backend=false

echo "-> Verifying HCL formatting..."
terraform fmt -check -recursive

echo "-> Validating Terraform configuration..."
terraform validate
