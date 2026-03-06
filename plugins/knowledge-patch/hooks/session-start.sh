#!/usr/bin/env bash
# SessionStart hook for knowledge-patch plugin
# Detects enabled knowledge patches and injects enforcement context

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
PLUGIN_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

PROJECT_ROOT="${CLAUDE_PROJECT_ROOT:-$(pwd)}"
HOME_DIR="${HOME:-$HOME}"

# Settings file locations (all three scopes)
USER_SETTINGS="${HOME_DIR}/.claude/settings.json"
PROJECT_SETTINGS="${PROJECT_ROOT}/.claude/settings.json"
LOCAL_SETTINGS="${PROJECT_ROOT}/.claude/settings.local.json"

# Extract enabled knowledge patches from a settings file
extract_patches() {
  local file="$1"
  if [ -f "$file" ]; then
    jq -r '
      .enabledPlugins // {} |
      to_entries[] |
      select(.value == true) |
      select(.key | test("-knowledge-patch@")) |
      .key |
      split("@")[0]
    ' "$file" 2>/dev/null || true
  fi
}

# Collect from all scopes, deduplicate
PATCHES=$(
  {
    extract_patches "$USER_SETTINGS"
    extract_patches "$PROJECT_SETTINGS"
    extract_patches "$LOCAL_SETTINGS"
  } | sort -u
)

# No patches found — exit silently
if [ -z "$PATCHES" ]; then
  exit 0
fi

# Map patch IDs to display names
display_name() {
  case "$1" in
    bun-knowledge-patch)        echo "Bun" ;;
    typescript-knowledge-patch) echo "TypeScript" ;;
    nextjs-knowledge-patch)     echo "Next.js" ;;
    nodejs-knowledge-patch)     echo "Node.js" ;;
    postgresql-knowledge-patch) echo "PostgreSQL" ;;
    postgis-knowledge-patch)    echo "PostGIS" ;;
    rust-knowledge-patch)       echo "Rust" ;;
    dioxus-knowledge-patch)     echo "Dioxus" ;;
    python-knowledge-patch)     echo "Python" ;;
    *)                          echo "${1%-knowledge-patch}" ;;
  esac
}

# Build patch list
PATCH_LIST=""
while IFS= read -r patch; do
  [ -z "$patch" ] && continue
  NAME=$(display_name "$patch")
  PATCH_LIST="${PATCH_LIST}- ${NAME} (\`${patch}\`)\n"
done <<< "$PATCHES"

# Read the using-knowledge-patches skill content (skip frontmatter)
SKILL_CONTENT=$(sed '1{/^---$/!q;};1,/^---$/d' "${PLUGIN_ROOT}/skills/using-knowledge-patches/SKILL.md" 2>/dev/null || echo "Error reading skill")

# Build context — modeled after superpowers' aggressive injection
CONTEXT="<EXTREMELY_IMPORTANT>
You have knowledge patches loaded.

**The following knowledge patches are enabled and contain information BEYOND your training data:**

${PATCH_LIST}
**Below is the full content of your 'knowledge-patch:using-knowledge-patches' skill. For patch content, use the Skill tool with the patch name (e.g. \`Skill: bun-knowledge-patch\`):**

${SKILL_CONTENT}
</EXTREMELY_IMPORTANT>"

# Escape for JSON using fast bash parameter substitution (from superpowers)
escape_for_json() {
  local s="$1"
  s="${s//\\/\\\\}"
  s="${s//\"/\\\"}"
  s="${s//$'\n'/\\n}"
  s="${s//$'\r'/\\r}"
  s="${s//$'\t'/\\t}"
  printf '%s' "$s"
}

ESCAPED=$(escape_for_json "$CONTEXT")

# Output JSON — both shapes for compatibility (Claude Code + Cursor)
cat <<EOF
{
  "additional_context": "${ESCAPED}",
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "${ESCAPED}"
  }
}
EOF

exit 0
