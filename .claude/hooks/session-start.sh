#!/bin/bash
# SessionStart hook: restore the tools and plugins this repo expects so each
# new Claude Code on the web sandbox starts with the same environment.
#
# What it does, in order:
#   1. Installs @intentsolutionsio/ccpi globally via pnpm.
#   2. Registers every marketplace listed in .claude/marketplaces.txt.
#   3. Installs every plugin listed in .claude/plugins.txt (user scope).
#
# Every step is idempotent — re-running the hook is a no-op once everything
# is in place. The script exits 0 even if individual plugins fail so a single
# broken entry never blocks the session.

set -uo pipefail

# Only act inside Claude Code on the web. Local CLI sessions skip this.
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"

# ---------- 1. Install ccpi via pnpm ----------------------------------------

if [ -x /opt/node22/bin/pnpm ]; then
  PNPM=/opt/node22/bin/pnpm
elif command -v pnpm >/dev/null 2>&1; then
  PNPM="$(command -v pnpm)"
else
  echo "session-start.sh: pnpm not found; skipping ccpi install" >&2
  PNPM=""
fi

if [ -n "$PNPM" ]; then
  "$PNPM" setup >/dev/null 2>&1 || true
  export PNPM_HOME="${PNPM_HOME:-$HOME/.local/share/pnpm}"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
  if ! command -v ccpi >/dev/null 2>&1; then
    "$PNPM" add -g @intentsolutionsio/ccpi || \
      echo "session-start.sh: ccpi install failed (continuing)" >&2
  fi
fi

# ---------- 2. Register marketplaces ----------------------------------------

MARKETPLACES_FILE="$PROJECT_DIR/.claude/marketplaces.txt"
if command -v claude >/dev/null 2>&1 && [ -f "$MARKETPLACES_FILE" ]; then
  while IFS= read -r line || [ -n "$line" ]; do
    line="${line%%#*}"
    line="$(echo "$line" | tr -d '[:space:]')"
    [ -z "$line" ] && continue
    claude plugin marketplace add "$line" >/dev/null 2>&1 || \
      echo "session-start.sh: failed to add marketplace '$line' (continuing)" >&2
  done < "$MARKETPLACES_FILE"
fi

# ---------- 3. Install plugins ----------------------------------------------

PLUGINS_FILE="$PROJECT_DIR/.claude/plugins.txt"
if command -v claude >/dev/null 2>&1 && [ -f "$PLUGINS_FILE" ]; then
  while IFS= read -r line || [ -n "$line" ]; do
    line="${line%%#*}"
    line="$(echo "$line" | tr -d '[:space:]')"
    [ -z "$line" ] && continue
    claude plugin install "$line" --scope user >/dev/null 2>&1 || \
      echo "session-start.sh: failed to install plugin '$line' (continuing)" >&2
  done < "$PLUGINS_FILE"
fi

# ---------- Persist env for the session -------------------------------------

if [ -n "${CLAUDE_ENV_FILE:-}" ] && [ -n "${PNPM_HOME:-}" ]; then
  {
    echo "export PNPM_HOME=\"$PNPM_HOME\""
    echo 'export PATH="$PNPM_HOME:$PATH"'
  } >> "$CLAUDE_ENV_FILE"
fi

exit 0
