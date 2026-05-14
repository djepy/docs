# Migrating the ops scaffold to its own repo

This scaffold (`.claude/agents/`, `BOARD.md`, `.claude/templates/`) was built
inside `djepy/docs` because Claude Code's GitHub access from a session is
scoped to one repo, and `djepy/docs` is what we had. Once you've created the
destination repo, follow the steps below to move it.

## Step 1 — Create the new repo (you do this)

1. Visit https://github.com/new.
2. Owner: your account. Name: `ops` (or whatever you prefer). Private. No
   template. No README — we'll add our own.
3. Click "Create repository". Don't push anything to it yet.

## Step 2 — Bootstrap the new repo (Claude does this in a fresh session)

Close this Claude tab. Open a new Claude Code on the web session on the new
repo. Say:

> Bootstrap from the docs scaffold.

In that session, Claude should:

1. Create `.claude/marketplaces.txt` mirroring the one in `djepy/docs`.
2. Create `.claude/plugins.txt` mirroring the post-cleanup version (Ruflo
   already removed).
3. Copy `.claude/hooks/session-start.sh` and `.claude/settings.json` so the
   SessionStart hook works there.
4. Copy `.claude/user-profile.md`.
5. Copy the 7 agent definitions from `.claude/agents/`.
6. Copy `BOARD.md` (the example items can stay as a tutorial, or be wiped
   if the user prefers a clean board).
7. Copy `.claude/templates/nightly-board-review.yml` to
   `.github/workflows/nightly-board-review.yml` (this is where it becomes
   an active cron, not a template).
8. Open and merge a PR titled "Bootstrap ops repo from docs scaffold".

## Step 3 — Smoke test

Same session, immediately after merge:

> Use the manager agent to give me a status.

Manager should read `BOARD.md`, see the example items, and produce a status
report. If it complains about a missing file, the migration is incomplete.

## Step 4 — Optional: delete the scaffold from djepy/docs

Once the ops repo is working, you can remove `.claude/agents/`,
`.claude/templates/`, `.claude/MIGRATION.md`, and `BOARD.md` from
`djepy/docs` to keep the docs fork clean. The plugins / marketplaces config
in `djepy/docs/.claude/` should stay — it's useful for any session on this
repo too.

## Step 5 — Diverging the two repos

After migration, the docs repo and ops repo are independent. Agent updates
in one don't propagate to the other. If you want them to stay in sync,
either:

- Keep agents in one repo only (the ops repo) and don't use them in the docs
  repo, or
- Set up a sync script (in automation-engineer's territory) — but honestly,
  just pick one home.
