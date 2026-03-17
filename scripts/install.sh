#!/usr/bin/env bash
set -euo pipefail

RAW_BASE="https://raw.githubusercontent.com/This-Is-NPC/assisted_workflow/master"
SKILLS=(commit implement planning prepare requirements summarize)
VALID_AGENTS=(claude codex github opencode)

# --- Argument parsing ---

AGENT=""
UPDATE=false

usage() {
  cat <<'USAGE'
Usage: install.sh --agent <name> [--update]

  --agent <name>   Agent to configure (claude|codex|github|opencode)
  --update         Update mode: preserve CONTRIBUTING.md, refresh everything else

Examples:
  bash install.sh --agent claude
  bash install.sh --agent codex --update
USAGE
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --agent)
      [[ $# -lt 2 ]] && { echo "Error: --agent requires a value"; usage; }
      AGENT="$2"; shift 2 ;;
    --update)
      UPDATE=true; shift ;;
    -h|--help)
      usage ;;
    *)
      echo "Error: unknown argument '$1'"; usage ;;
  esac
done

if [[ -z "$AGENT" ]]; then
  echo "Error: --agent is required"
  usage
fi

agent_valid=false
for valid in "${VALID_AGENTS[@]}"; do
  [[ "$AGENT" == "$valid" ]] && agent_valid=true
done
if ! $agent_valid; then
  echo "Error: invalid agent '$AGENT'. Must be one of: ${VALID_AGENTS[*]}"
  exit 1
fi

# --- Detect directory layout ---

if [[ -d ".docs" ]]; then
  DOCS_DIR=".docs"
elif [[ -d "docs" ]]; then
  DOCS_DIR="docs"
else
  DOCS_DIR=".docs"
fi

if [[ -d "workflow" ]]; then
  WORKFLOW_DIR="workflow"
elif [[ -d ".workflow" ]]; then
  WORKFLOW_DIR=".workflow"
elif [[ -d "$DOCS_DIR/workflow" ]]; then
  WORKFLOW_DIR="$DOCS_DIR/workflow"
elif [[ -d "$DOCS_DIR/.workflow" ]]; then
  WORKFLOW_DIR="$DOCS_DIR/.workflow"
else
  WORKFLOW_DIR=".workflow"
fi

# --- Agent directory ---

case "$AGENT" in
  claude)  AGENT_DIR=".claude" ;;
  codex)   AGENT_DIR=".codex" ;;
  github)  AGENT_DIR=".github" ;;
  opencode) AGENT_DIR=".opencode" ;;
esac

# --- Download helper ---

download() {
  local remote_path="$1"
  local local_path="$2"
  local dir
  dir="$(dirname "$local_path")"
  mkdir -p "$dir"
  if ! curl -fsSL "$RAW_BASE/$remote_path" -o "$local_path"; then
    echo "Error: failed to download $remote_path"
    return 1
  fi
}

# --- Path replacement helper ---

sed_paths() {
  local file="$1"
  if [[ "$DOCS_DIR" != ".docs" ]]; then
    sed -i "s|\.docs/|${DOCS_DIR}/|g" "$file"
  fi
  if [[ "$WORKFLOW_DIR" != "workflow" ]]; then
    sed -i "s|workflow/|${WORKFLOW_DIR}/|g" "$file"
  fi
}

# --- 1. Copy templates ---

echo "Installing templates..."
TEMPLATES=(contributing_template.md plan_template.md summary_template.md user_story_template.md)
for tmpl in "${TEMPLATES[@]}"; do
  download ".docs/templates/$tmpl" "$DOCS_DIR/templates/$tmpl"
  sed_paths "$DOCS_DIR/templates/$tmpl"
done

# --- 2. Copy CONTRIBUTING.md ---

if $UPDATE && [[ -f "CONTRIBUTING.md" ]]; then
  echo "CONTRIBUTING.md preserved (update mode)"
else
  echo "Installing CONTRIBUTING.md..."
  download ".docs/templates/contributing_template.md" "CONTRIBUTING.md"
  sed_paths "CONTRIBUTING.md"
fi

# --- 3. Create workflow structure ---

echo "Installing workflow structure..."
download "workflow/README.md" "$WORKFLOW_DIR/README.md"
sed_paths "$WORKFLOW_DIR/README.md"

for subdir in requirements plans summaries; do
  mkdir -p "$WORKFLOW_DIR/$subdir"
  touch "$WORKFLOW_DIR/$subdir/.gitkeep"
done

# --- 4. Copy agent skills ---

echo "Installing $AGENT skills..."
for skill in "${SKILLS[@]}"; do
  download ".$AGENT/skills/$skill/SKILL.md" "$AGENT_DIR/skills/$skill/SKILL.md"
  sed_paths "$AGENT_DIR/skills/$skill/SKILL.md"
done

# Agent-specific extras
case "$AGENT" in
  codex)
    echo "Installing codex agent configs..."
    for skill in "${SKILLS[@]}"; do
      download ".codex/skills/$skill/agents/openai.yaml" "$AGENT_DIR/skills/$skill/agents/openai.yaml"
      sed_paths "$AGENT_DIR/skills/$skill/agents/openai.yaml"
    done
    ;;
  opencode)
    echo "Installing opencode commands..."
    for skill in "${SKILLS[@]}"; do
      download ".opencode/commands/$skill.md" "$AGENT_DIR/commands/$skill.md"
      sed_paths "$AGENT_DIR/commands/$skill.md"
    done
    ;;
esac

# --- 5. Configure .gitignore ---

MARKER_START="# >>> assisted_workflow >>>"
MARKER_END="# <<< assisted_workflow <<<"

gitignore_block="$MARKER_START
${WORKFLOW_DIR}/requirements/*
!${WORKFLOW_DIR}/requirements/.gitkeep
${WORKFLOW_DIR}/plans/*
!${WORKFLOW_DIR}/plans/.gitkeep
${WORKFLOW_DIR}/summaries/*
!${WORKFLOW_DIR}/summaries/.gitkeep
$MARKER_END"

if [[ -f ".gitignore" ]] && grep -qF "$MARKER_START" ".gitignore"; then
  if $UPDATE; then
    echo "Updating .gitignore rules..."
    # Remove old block and write new one
    sed -i "/$MARKER_START/,/$MARKER_END/d" ".gitignore"
    printf '%s\n' "$gitignore_block" >> ".gitignore"
  else
    echo ".gitignore already configured"
  fi
else
  echo "Configuring .gitignore..."
  printf '\n%s\n' "$gitignore_block" >> ".gitignore"
fi

# --- 6. Summary ---

cat <<EOF

assisted_workflow installed!
  Docs:     $DOCS_DIR/
  Workflow: $WORKFLOW_DIR/
  Agent:    $AGENT_DIR/

Next steps:
  1. Edit CONTRIBUTING.md with your project settings
  2. Start with: /requirements <your task>
EOF
