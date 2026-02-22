#!/usr/bin/env bash
set -euo pipefail

chmod +x .githooks/pre-push
chmod +x scripts/checkpoint.sh
chmod +x scripts/autocommit.sh

git config core.hooksPath .githooks

echo "Git workflow initialized."
echo "Installed hooks path: $(git config --get core.hooksPath)"
echo "Use scripts/checkpoint.sh \"message\" for manual checkpoint commits."
echo "Use scripts/autocommit.sh for automatic commits while coding."
