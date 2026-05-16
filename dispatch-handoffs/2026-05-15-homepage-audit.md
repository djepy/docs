# Dispatch Packet — Pre-cutover Homepage Audit + Cleanup

**From:** Claude planner on `djepy/docs`
**To:** Claude dispatch on `C:\Users\Gefte Debreus\myproject`
**Issued:** 2026-05-15
**Phase:** Pre-cutover — verification + fabricated-content cleanup
**Estimated time:** 30–45 minutes
**Paste-ready:** yes, no founder prefill needed

## Why this exists

I audited the preview URL (`https://dreamy-ptolemy-d624d6.vercel.app`) from the planner side and found:

- Memorial Day banner: ✅ live
- Removed fabricated social proof (50k customers / 4.7★ / trend-verified): ✅ gone
- BUT — products didn't appear in the static HTML I fetched ("Loading products…" shown), category counts all showed "(0)", a "203 sold today" badge appears on K-Beauty Serum, and the testimonial section shows handles `@sofiar__beauty` and `@marcust_fit` that look AI-generated.

My fetch cannot run JavaScript, so the product-loading issue might just be SSR vs CSR. The fabricated-stat patterns I found are the same kind of generated copy that produced the "50,000+ customers" claim earlier — they need to go before cutover.

## Hard rules

- Do NOT cut over the domain or touch Vercel project settings.
- Do NOT request a Vercel API token.
- If you find a real product-loading bug, **REPORT before fixing.** The founder approves the fix direction. Don't refactor a Storefront API integration without checking in.
- For testimonials and the "203 sold today" counter: **audit first, propose removal, do NOT delete until founder confirms.** Quote the exact content you find.
- Fail loudly. No `|| true`.

## Task 1 — Verify products render in a real browser

Open Chrome (via the browser extension) and load `https://dreamy-ptolemy-d624d6.vercel.app`.

1. **Visual check, above the fold:** is there a "Shop Trending Products" or product grid section? If so, do products appear with images, names, and prices within 5 seconds of page load? Take a screenshot.
2. **Category counts:** open the nav menu. Are category counts like "Skincare (4)" or "Tech Gadgets (1)" showing real numbers, or "(0)"?
3. **Network tab:** open dev tools → Network → reload page. Note:
   - Any requests with HTTP 4xx or 5xx responses (red rows)
   - Requests to `*.myshopify.com`, `*.shopifycdn.com`, or any Storefront API endpoint — are they 200 OK?
4. **Console tab:** note any errors, especially anything mentioning `fetch`, `storefront`, `products`, `collections`, or `undefined`.

**Report back in Task 5:** are products actually loading or is this a real bug?

## Task 2 — Audit the "203 sold today" badge

In the codebase, search for the source of this badge:

```sh
cd "C:\Users\Gefte Debreus\myproject"
git checkout claude/dreamy-ptolemy-d624d6
git pull origin claude/dreamy-ptolemy-d624d6 --ff-only

grep -rniE "sold today|sold this|just sold|people sold|recently sold|203" src/ app/ 2>/dev/null
```

For every match: read the surrounding code and report whether the number is:

- **Real** — pulled from Shopify Orders API / a real metrics endpoint
- **Hardcoded** — a literal `203` or similar in the JSX
- **Random** — generated client-side with `Math.random()` or a similar trick

If hardcoded or random: that's fabricated social proof, same category as the "50k customers" claim. **Report what you find, but do NOT delete until founder confirms.** Quote the exact code snippet.

## Task 3 — Audit the testimonials

Find the testimonials section. Search:

```sh
grep -rniE "testimonial|sofiar|marcust|@\w+_\w+" src/ app/ 2>/dev/null
```

For each testimonial:
1. Report the full quote, the attributed name, and the social handle.
2. Try to verify if the handle is real:
   - Open `https://instagram.com/<handle>` (e.g. `instagram.com/sofiar__beauty`)
   - Open `https://tiktok.com/@<handle>`
   - Note whether the account exists, whether it has any posts, whether it's related to NOVIQE's niche
3. Report: real / probably fake / unverifiable.

**Do NOT delete the testimonials yet.** Founder reviews your audit and decides which (if any) to keep. The default position for unverified testimonials is "they go" — but founder makes the call.

## Task 4 — Fix the footer contact email mismatch

The footer currently shows `hello@noviqe.com`. The Shopify contact email was updated to `gefte@noviqe.com` in a previous round. The footer should match.

```sh
grep -rni "hello@noviqe" src/ app/ 2>/dev/null
```

For every match, replace `hello@noviqe.com` with `gefte@noviqe.com`.

```sh
grep -rni "hello@noviqe" src/ app/ 2>/dev/null
# expected: no output
```

## Task 5 — Commit + push + verify

If you made changes in Task 4 (and only Task 4 — Tasks 2 and 3 are audit-only, no edits):

```sh
git add -A
git commit -m "fix: footer contact email gefte@noviqe.com matches Shopify settings"
git push origin claude/dreamy-ptolemy-d624d6
```

Wait 60–120 sec for Vercel preview redeploy. Reload the preview URL, verify footer shows `gefte@noviqe.com`.

## Report back

Save to `dispatch-handoffs/2026-05-15-homepage-audit-RESULT.md` and paste here:

```
# Homepage Audit Result

**Completed at:** <timestamp>

## Task 1 — Real-browser product loading
- Products visible on homepage within 5 sec: <yes — N products shown | no — what shows>
- Category counts showing real numbers: <yes — examples | no — all (0)>
- Network errors: <none | list>
- Console errors: <none | list>
- Screenshot saved: <path or attached>
- Verdict: <products load fine — planner's static-fetch caveat explained it | REAL BUG — describe>

## Task 2 — "203 sold today" badge audit
- Source location: <file path:line>
- Type: <real Shopify data | hardcoded | random>
- Quoted snippet:
  ```
  <code snippet>
  ```
- Recommendation: <keep | remove>

## Task 3 — Testimonials audit
For each testimonial found:

| Name | Handle | Real? | Notes |
|---|---|---|---|
| ... | @... | real / fake / unverifiable | ... |

- Recommendation: <keep all | keep N | remove all>

## Task 4 — Footer email fix
- Matches found: <count and files>
- Replacement applied: <yes | no>
- Commit SHA: <sha>
- Push status: <success | failure>
- Vercel preview redeploy: <success | failure>
- Footer verified showing gefte@noviqe.com: <yes | no>

## Issues / blockers
<none | describe>
```
