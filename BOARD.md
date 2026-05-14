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

### Noviqe launch sequence (May 14, 2026)

Tasks live on the founder's Shopify admin / DSers / Vercel dashboard. Credentials
are NEVER stored in this file — they live in the founder's password manager.

- [ ] **SECURITY** Rotate the Vercel API token that leaked in the build report (@founder) [due: 2026-05-14]
- [ ] Install Meta + TikTok pixels on Shopify before any cutover or paid traffic (@founder) [due: 2026-05-15]
- [ ] Add Products 4, 5, 6 in Shopify — Blue Light Device, Collagen Sleeping Mask, Galaxy Projector (@founder) [due: 2026-05-15]
- [ ] DSers-map Products 4, 5, 6 to AliExpress suppliers (@founder) [due: 2026-05-16]
- [ ] Create discount codes `GLOWDROP15` (15% off Skincare + Tech) and `MEMDAY20` (20% off $75+, May 20–26) (@founder) [due: 2026-05-16]
- [ ] Update store contact email in Shopify to `gefte@noviqe.com` (@founder) [due: 2026-05-15]
- [ ] Draft Memorial Day content — email + SEO blog + homepage banner JSX (@content-creator) [due: 2026-05-16]
- [ ] Cutover noviqe.com to the new Vercel project (uses NEW rotated token, only after all above done) (@founder) [due: 2026-05-18]
- [ ] End-to-end smoke test on live noviqe.com after cutover (load, cart, checkout) (@founder) [due: 2026-05-18]
- [ ] Send Memorial Day email blast from Shopify to customer list (@founder) [due: 2026-05-20]

### Pre-launch / discovery

- [ ] **Delete the "50,000+ happy customers / 4.7★ / 100% trend-verified" placeholder block from the live site** (@founder) [due: 2026-05-14]
- [ ] Decide single sub-category to lead with for first 90 days (skincare tools / glow supplements / facial devices) (@founder) [due: 2026-05-21]
- [ ] Validate / replace any other AI-generated placeholder copy on the site (About page, founder bio, FAQs) (@content-creator) [due: 2026-05-21]

## Doing

Things actively being worked on this week. Cap at 3-5 items.

_(empty — assign yourself items here as you start them)_

## Waiting

Things blocked on someone or something external. Always note what we're waiting on.

_(empty)_

## Done

Things shipped. Keep the last 30 days here; older items move to `BOARD-archive.md`.

- [x] (example) Build the docs-repo agent scaffold (manager + 6 specialists, BOARD.md, MIGRATION.md, nightly cron template) — 2026-05-14
