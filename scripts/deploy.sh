#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TARGET_DIR="${TARGET_DIR:-/var/www/reseptor.no/current}"
SOURCE_DIR="$REPO_ROOT/public/"

if ! command -v rsync >/dev/null 2>&1; then
    echo "rsync is required to publish the site." >&2
    exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo "Missing public/ directory at $SOURCE_DIR" >&2
    exit 1
fi

mkdir -p "$TARGET_DIR"
rsync -av --delete "$SOURCE_DIR" "$TARGET_DIR/"
