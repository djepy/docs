# BOARD

The single source of truth for what's being worked on. Edit this file directly,
or ask the `manager` agent to update it. Format is intentionally plain Markdown.

## Format

Each item is one line:

    - [ ] <task description> (@<agent>) [due: YYYY-MM-DD]

- `(@<agent>)` — optional but strongly encouraged. Without it, the manager has
  to guess who owns the item.
- `[due: YYYY-MM-DD]` — optional. Without it, the item has no deadline.
- `[x]` instead of `[ ]` marks the item done.

The four columns below are read as state by the manager agent. Move items
between columns by cut/paste.

## Inbox

Things added but not yet started. The manager triages from here.

- [ ] (example) Define ICP for the next 3 months (@marketing-strategist)
- [ ] (example) Categorize April expenses (@finance-bookkeeper) [due: 2026-05-31]
- [ ] (example) Draft contractor NDA template (@legal-prep)

## Doing

Things actively being worked on this week. Cap at 3-5 items.

- [ ] (example) Write the launch blog post (@content-creator) [due: 2026-05-20]

## Waiting

Things blocked on someone or something external. Always note what we're waiting on.

- [ ] (example) Trademark filing — waiting on attorney response since 2026-05-10

## Done

Things shipped. Keep the last 30 days here; older items move to `BOARD-archive.md`.

- [x] (example) Set up monthly P&L workflow (@finance-bookkeeper)
