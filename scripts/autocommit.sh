#!/usr/bin/env bash
set -euo pipefail

interval="${AUTOCOMMIT_INTERVAL:-3}"
prefix="${AUTOCOMMIT_PREFIX:-chore(auto): savepoint}"

echo "Autocommit watcher started in $(pwd)"
echo "Interval: ${interval}s"
echo "Message prefix: ${prefix}"
echo "Press Ctrl+C to stop."

while true; do
  if ! git diff --quiet || ! git diff --cached --quiet; then
    ts="$(date '+%Y-%m-%d %H:%M:%S')"
    git add -A

    # Avoid failing when add doesn't produce staged content.
    if ! git diff --cached --quiet; then
      git commit -m "${prefix} ${ts}" >/dev/null 2>&1 || true
      echo "[autocommit] committed at ${ts}"
    fi
  fi

  sleep "${interval}"
done
