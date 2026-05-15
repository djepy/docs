# Dispatch Mini-Packet — Pre-Cutover Verification

**From:** Claude planner on `djepy/docs`
**To:** Claude dispatch on `C:\Users\Gefte Debreus\myproject`
**Issued:** 2026-05-15
**Branch:** `claude/dreamy-ptolemy-d624d6`
**Phase:** Pre-cutover (file work + browser-extension Shopify check only)

Two tasks. Execute both before any cutover work. Report back per the format at the bottom.

## Hard rules

- Do NOT touch `noviqe.com` (no domain changes, no Vercel project settings).
- Do NOT install Meta or TikTok pixels — that's a separate founder task.
- Do NOT request or paste any Vercel API tokens. The cutover is gated on the founder doing it themselves.
- If `git push` fails, report the exact error. Do not force-push, do not push to a different branch.
- Fail loudly. No `|| true` swallowing.

## Task 1 — Verify Products 4 & 5 in Shopify

Use the browser extension (the one connected during the previous round).
Open Shopify admin → Products.

Check whether these two products exist:

- **LED Blue Light Therapy Device** ($39.99 / compare $69.99)
- **K-Beauty Collagen Sleeping Mask** ($29.99 / compare $54.99)

For each one, report exactly one of: `EXISTS (active)`, `EXISTS (draft)`, or `MISSING`.

If MISSING, create it with this spec:

**LED Blue Light Therapy Device**
- Title: `LED Blue Light Therapy Device`
- Price: $39.99
- Compare-at price: $69.99
- Collection: Skincare
- Tags: `LED, blue light, acne, skincare, beauty-tech`
- Status: Active
- Track inventory: No (dropship)
- Physical product: Yes
- Description: short, factual, mentions wavelength range (415-430 nm) and use case (acne / blemish-prone skin)

**K-Beauty Collagen Sleeping Mask**
- Title: `K-Beauty Collagen Sleeping Mask`
- Price: $29.99
- Compare-at price: $54.99
- Collection: Skincare
- Tags: `K-beauty, collagen, sleeping mask, skincare, overnight`
- Status: Active
- Track inventory: No (dropship)
- Physical product: Yes
- Description: short, factual, mentions overnight use and hydration claims (no medical claims)

**Do NOT DSers-map them in this task.** Mapping is a separate step gated on the founder.

## Task 2 — Remove fabricated social-proof copy from the redesigned codebase

Run the search-and-remove cleanly:

```sh
cd "C:\Users\Gefte Debreus\myproject"
git fetch origin
git checkout claude/dreamy-ptolemy-d624d6
git pull origin claude/dreamy-ptolemy-d624d6 --ff-only

# Find every instance of the placeholder claims
grep -rniE "50,?000|4\.7\s*★|4\.7\s*stars?|trend.?verified|happy customers" src/ public/ app/ 2>/dev/null
```

For every match: read the surrounding JSX block and remove the **whole element** (the stat card, the badge, the testimonial block — not just the number). These are fabricated metrics; nothing referencing them should survive.

Specifically, look in:
- `src/components/Hero.tsx` (the build report mentioned "stat cards" in the hero)
- `src/components/Footer.tsx`
- `src/app/page.tsx` (the "Why NOVIQE" section, stats bar, testimonials carousel)
- Anywhere else the grep finds matches

After removing, re-grep to confirm zero matches:

```sh
grep -rniE "50,?000|4\.7\s*★|4\.7\s*stars?|trend.?verified|happy customers" src/ public/ app/ 2>/dev/null
# Expected output: nothing (silent)
```

If the result is still non-empty, find and remove the remaining matches before continuing.

Then commit and push:

```sh
git add -A
git commit -m "remove fabricated social-proof copy (50k customers, 4.7-star, trend-verified)"
git push origin claude/dreamy-ptolemy-d624d6
```

Wait for the Vercel preview to redeploy (60–120 seconds). Then load `https://dreamy-ptolemy-d624d6.vercel.app` and verify by eye:
- The "50,000+ happy customers" block is gone
- The "4.7★ average rating" badge is gone
- The "100% trend-verified" badge is gone
- The Memorial Day banner is still present (don't accidentally delete it)
- The page still renders without errors

## Report back

Paste this filled-in report when done. Save a copy to `dispatch-handoffs/2026-05-15-pre-cutover-verify-RESULT.md` in the project repo if convenient.

```
# Pre-cutover verification result

**Completed at:** <timestamp>

## Task 1: Products 4 & 5
- LED Blue Light Therapy Device: <EXISTS active | EXISTS draft | MISSING (now CREATED) | other>
- K-Beauty Collagen Sleeping Mask: <EXISTS active | EXISTS draft | MISSING (now CREATED) | other>

## Task 2: Placeholder copy removal
- grep matches found before removal: <number>
- Files touched: <list>
- grep matches found after removal: <number — must be 0>
- Commit SHA: <sha>
- Push status: <success | failure with exact error>
- Vercel preview redeploy: <success | failure>
- Visual verification on preview URL:
  - "50,000+ happy customers" gone: <yes | no — what still shows>
  - "4.7★" badge gone: <yes | no>
  - "Trend-verified" badge gone: <yes | no>
  - Memorial Day banner still present: <yes | no — concerning>
  - Console errors: <none | list>

## Issues / blockers
<none | describe>
```
