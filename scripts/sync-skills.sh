#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC_DIR="$REPO_ROOT/src/skills"
AGENTS=(.opencode .github .claude .codex)

count=0

for skill_dir in "$SRC_DIR"/*/; do
  skill="$(basename "$skill_dir")"
  src_file="$skill_dir/SKILL.md"

  if [[ ! -f "$src_file" ]]; then
    echo "WARN: $src_file not found, skipping"
    continue
  fi

  for agent in "${AGENTS[@]}"; do
    dest_dir="$REPO_ROOT/$agent/skills/$skill"
    dest_file="$dest_dir/SKILL.md"

    mkdir -p "$dest_dir"
    cp "$src_file" "$dest_file"
    echo "  $src_file -> $dest_file"
    count=$((count + 1))
  done
done

echo ""
echo "Synced $count skill files ($(ls -d "$SRC_DIR"/*/ 2>/dev/null | wc -l) skills × ${#AGENTS[@]} agents)"
