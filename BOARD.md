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

### Noviqe — pre-cutover preconditions (must all be done before cutover)

- [ ] **Remove the "50,000+ happy customers / 4.7★ / 100% trend-verified" placeholder block from the redesigned codebase** — grep for "50,000", "4.7", "trend-verified" in `myproject/src/`; commit and push (@dispatch via packet) [due: 2026-05-15]
- [ ] Verify whether LED Blue Light Therapy Device and K-Beauty Collagen Sleeping Mask exist in Shopify Products; create any missing (@dispatch + @founder) [due: 2026-05-15]
- [ ] DSers-map Products 4, 5, 6 to AliExpress suppliers (after Products 4 & 5 confirmed/created) (@founder via browser extension) [due: 2026-05-16]
- [ ] Install Meta + TikTok pixels in Shopify (@founder via browser extension) [due: 2026-05-16]
- [ ] Founder personally click-through preview URL end-to-end (homepage → product → cart → checkout) (@founder) [due: 2026-05-17]
- [ ] Create new Vercel API token in dashboard, save to password manager (NEVER paste to any AI session) (@founder) [due: 2026-05-17]
- [ ] Screenshot current `noviqe.com` for rollback reference (@founder) [due: 2026-05-17]

### Noviqe — cutover and post-cutover

- [ ] Cutover noviqe.com to the `dreamy-ptolemy-d624d6` Vercel project (founder clicks in dashboard, OR runs PowerShell script locally with token in env var) (@founder) [due: 2026-05-18]
- [ ] End-to-end smoke test on live noviqe.com after cutover (homepage, cart, checkout) (@founder) [due: 2026-05-18]
- [ ] Send Memorial Day email blast (@founder from Shopify) [due: 2026-05-20]
- [ ] Replace `{{LINK}}` in `marketing/memday20-email.md` before send (@founder) [due: 2026-05-20]
- [ ] Resolve `[CHECK]` items in `marketing/blog-red-light-therapy-mask.md` (cite real studies, verify FDA-clearance language) before publishing (@founder + @content-creator) [due: 2026-05-22]
- [ ] Decide single sub-category to lead with for first 90 days (skincare tools / glow supplements / facial devices) (@founder) [due: 2026-05-21]
- [ ] Validate / replace remaining AI-generated placeholder copy (About, founder bio, FAQs) (@content-creator) [due: 2026-05-21]
- [ ] Audit and delete stale Vercel tokens (`noviqe-deploy` from 2026-04-16, `NOVIQE Deploy` team-scope from 2026-04-27) if no CI uses them (@founder) [due: 2026-05-22]
- [ ] Confirm Vercel account email mismatch — `proshinycleaningservices@gmail.com` is correct owner (vs `djepy10@gmail.com` listed in build report) (@founder) [due: 2026-05-16]

## Doing

Things actively being worked on this week. Cap at 3-5 items.

_(empty — assign yourself items here as you start them)_

## Waiting

Things blocked on someone or something external. Always note what we're waiting on.

- [ ] Founder writing samples — needed to recalibrate content-creator voice (@founder) — waiting since 2026-05-15

## Done

Things shipped. Keep the last 30 days here; older items move to `BOARD-archive.md`.

- [x] Revoke leaked Vercel API token via API — 2026-05-15
- [x] Build the docs-repo agent scaffold (manager + 6 specialists, BOARD.md, MIGRATION.md, nightly cron template) — 2026-05-14
- [x] First marketing-strategist test-drive: Noviqe ICP analysis — 2026-05-15
- [x] Memorial Day Phase A dispatch packet (banner JSX + email + blog) drafted, committed, executed by dispatch, deployed to preview URL — 2026-05-15
- [x] Discount code `GLOWDROP15` (15% off Skincare + Tech) created in Shopify — 2026-05-15
- [x] Discount code `MEMDAY20` (20% off $75+, May 20–26) scheduled in Shopify — 2026-05-15
- [x] Store contact email updated to `gefte@noviqe.com` in Shopify — 2026-05-15
- [x] LED Galaxy Projector ($49.99 / $89.99) added to Shopify Tech Gadgets collection — 2026-05-15
