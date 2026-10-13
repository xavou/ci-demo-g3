#!/usr/bin/env bash
set -euo pipefail

BASE="${1%/}"

for i in $(seq 1 20); do
  if curl -fsS "$BASE/health" > /dev/null 2>&1; then
    break
  fi
  if [ "$i" = 20 ]; then
    echo "No answer from $BASE/health"
    exit 1
  fi
  sleep 1
done

curl -fsS "$BASE/fine?days=5" | jq -e '.fee == 1.5'
curl -fsS "$BASE/fine?days=30&deluxe=1" | jq -e '.fee == 5.0'
