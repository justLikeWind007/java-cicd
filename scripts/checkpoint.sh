#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: scripts/checkpoint.sh \"<commit message>\""
  exit 1
fi

msg="$1"

if git diff --quiet && git diff --cached --quiet; then
  echo "No changes to commit."
  exit 0
fi

git add -A
git commit -m "$msg"
echo "Checkpoint committed: $msg"
