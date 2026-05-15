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

### Noviqe — cutover blockers (must do before flipping noviqe.com)

- [ ] **You personally** click-through preview URL end-to-end (homepage → product → cart → checkout) (@founder) [due: 2026-05-16]
- [ ] Create new Vercel API token in dashboard, save to password manager (NEVER paste to any AI session) (@founder) [due: 2026-05-16]
- [ ] Screenshot current `noviqe.com` for rollback reference (@founder) [due: 2026-05-16]

### Noviqe — can happen before OR shortly after cutover

- [ ] Install Meta + TikTok pixels — packet ready at `dispatch-handoffs/2026-05-15-pixel-install.md`, needs founder to fetch Meta Pixel ID first (@founder + @dispatch via packet) [due: 2026-05-16]
- [ ] Add a **backup AliExpress supplier** for either the Collagen Sleeping Mask or the Galaxy Projector (currently both single-mapped to "Stone's Store" — single point of failure) (@dispatch via packet) [due: 2026-05-22]
- [ ] Watch the first 10 reviews on the $1.39-cost Collagen Sleeping Mask carefully — quality risk; swap supplier if reviews cluster around skin reactions (@founder) [due: ongoing]

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
- [x] Remove fabricated social-proof copy (50k customers / 4.7★ / trend-verified) from redesigned codebase — commit `4c0c80f` on `claude/dreamy-ptolemy-d624d6` — 2026-05-15
- [x] Visual verification on preview URL (home + /about) confirmed: Memorial Day banner present, fabricated stats gone — 2026-05-15
- [x] DSers map Products 4, 5, 6 to AliExpress suppliers (Foreverlily LC, Stone's Store, Stone's Store) — 2026-05-15

## Margin reference (captured from DSers mapping 2026-05-15)

| Product | Cost | Sale | Real margin |
|---|---|---|---|
| Smart Posture Corrector | (existing) | $34.99 | 98% |
| K-Beauty Collagen Sleeping Mask | $1.39 | $29.99 | ~95% |
| LED Galaxy Projector | $2.73–$4.27 | $49.99 | 91–95% |
| LED Red Light Therapy Face Mask | (existing) | $79.99 | 83% |
| LED Blue Light Therapy Device | $10.11–$16.15 | $39.99 | 60–75% |
