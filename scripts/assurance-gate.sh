#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Initiating Full Assurance Gate..."
"${SCRIPT_DIR}/validate-contract.sh"
echo "Assurance Gate: PASSED"
