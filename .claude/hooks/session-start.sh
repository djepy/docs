#!/bin/bash
# SessionStart hook: install @intentsolutionsio/ccpi globally via pnpm so it is
# available from the start of every Claude Code on the web session.
#
# Idempotent: subsequent runs are no-ops once ccpi is installed.

set -euo pipefail

# Only act inside Claude Code on the web. Local CLI sessions skip this.
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Locate pnpm. The sandbox image ships it at /opt/node22/bin/pnpm; fall back
# to whatever is on PATH.
if [ -x /opt/node22/bin/pnpm ]; then
  PNPM=/opt/node22/bin/pnpm
elif command -v pnpm >/dev/null 2>&1; then
  PNPM="$(command -v pnpm)"
else
  echo "session-start.sh: pnpm not found; cannot install ccpi" >&2
  exit 1
fi

# Initialise pnpm's global bin directory if needed (idempotent).
"$PNPM" setup >/dev/null 2>&1 || true

export PNPM_HOME="${PNPM_HOME:-$HOME/.local/share/pnpm}"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Install ccpi only if it is not already on PATH.
if ! command -v ccpi >/dev/null 2>&1; then
  "$PNPM" add -g @intentsolutionsio/ccpi
fi

# Persist PNPM_HOME and PATH so every subsequent command in the session sees
# the ccpi binary.
if [ -n "${CLAUDE_ENV_FILE:-}" ]; then
  {
    echo "export PNPM_HOME=\"$PNPM_HOME\""
    echo 'export PATH="$PNPM_HOME:$PATH"'
  } >> "$CLAUDE_ENV_FILE"
fi
