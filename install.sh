#!/usr/bin/env bash
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
dest="${HERMES_HOME:-$HOME/.hermes}/skills/software-development/spec-to-ship"
mkdir -p "$(dirname "$dest")"
rm -rf "$dest"
cp -r "$here/skills/spec-to-ship" "$dest"
echo "installed to $dest"
bash "$dest/scripts/check.sh" || echo "Some dependencies are missing; see README Requirements."
