#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="/srv/reseptor/repo"

if [ ! -d "$REPO_DIR/.git" ]; then
    echo "Missing git repo at $REPO_DIR" >&2
    exit 1
fi

git -C "$REPO_DIR" pull --ff-only
bash "$REPO_DIR/scripts/deploy.sh"
nginx -t
systemctl reload nginx

echo
echo "Reseptor deployed at commit $(git -C "$REPO_DIR" rev-parse --short HEAD)"
