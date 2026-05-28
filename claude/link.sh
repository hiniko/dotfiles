#!/usr/bin/env bash
# Per-file symlinker for Claude Code config.
#
# Why per-file (not a whole-dir link like the rest of these dotfiles):
# ~/.claude holds machine-only state (sessions, history, plugin cache, creds).
# We only want to track/sync config artifacts (settings.json, hooks, skills,
# agents, commands). Linking per file means a machine can ALSO drop local-only
# hooks/skills straight into ~/.claude/... and they sit beside the tracked
# (symlinked) ones without ever touching this repo.
#
# Idempotent: re-running re-points existing symlinks and leaves untracked
# local files untouched. Conflicting real files are backed up as <name>.bk.

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SRC="${DIR}/.claude"          # tracked source tree
DEST="${HOME}/.claude"        # live config dir (a REAL dir, never a symlink)

[ -d "$SRC" ] || { echo "No source tree at $SRC" >&2; exit 1; }

link_file() {
  local src="$1" dest="$2"
  # If something real (not already our symlink) is in the way, back it up.
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "Backing up existing $dest -> ${dest}.bk"
    cp "$dest" "${dest}.bk"
    rm "$dest"
  elif [ -L "$dest" ]; then
    rm "$dest"
  fi
  echo "Linking $dest"
  ln -s "$src" "$dest"
}

# Recreate the directory structure as REAL dirs, then symlink each file.
while IFS= read -r -d '' src; do
  rel="${src#"$SRC"/}"
  dest="${DEST}/${rel}"
  mkdir -p "$(dirname "$dest")"
  link_file "$src" "$dest"
done < <(find "$SRC" -type f -print0)

echo "Done. Restart Claude Code to load hooks."
