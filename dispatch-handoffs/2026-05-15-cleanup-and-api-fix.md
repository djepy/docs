# Dispatch Packet — Cleanup + /api/products bug investigation

**From:** Claude planner on `djepy/docs`
**To:** Claude dispatch on `C:\Users\Gefte Debreus\myproject`
**Issued:** 2026-05-15
**Phase:** Pre-cutover — fabricated-content removal + critical-path bug fix
**Estimated time:** 60–120 minutes (cleanup is fast; the bug could go quickly or take a few cycles)
**Paste-ready:** yes, no founder prefill needed

## Why this exists

Audit packet just confirmed:
1. "203 sold today" is hardcoded fabrication (`src/lib/trending-data.ts:160`) — founder approves removal.
2. All 5 testimonials are unverifiable AI-pattern handles — founder approves removal.
3. `/api/products` has a 75% failure rate (1 success / 1 503 / 2 hangs in 4 calls) — this is the cutover blocker. Investigate root cause before fixing.

## Hard rules

- Do NOT cut over the domain or touch Vercel project settings beyond reading logs / env-var names.
- Do NOT request a Vercel API token. Use the Vercel dashboard via the browser extension (founder is presumably logged in).
- For the API bug: **diagnose, report findings, propose a fix, WAIT for founder approval** before applying any non-trivial change. A 30-minute env-var typo fix can go immediately; an architecture refactor needs founder sign-off first.
- Fail loudly. No `|| true`. If a commit or push fails, report and stop.

## Task 1 — Remove the "203 sold today" hardcoded badge

```sh
cd "C:\Users\Gefte Debreus\myproject"
git fetch origin
git checkout claude/dreamy-ptolemy-d624d6
git pull origin claude/dreamy-ptolemy-d624d6 --ff-only
```

### 1a. Remove the data field

In `src/lib/trending-data.ts`:

- Find the `soldToday` property at line ~160 (or wherever it's defined across products).
- **Remove every occurrence of `soldToday` from every product object in that file.** Not just zero it out — delete the key entirely so no fallback can display a placeholder.

### 1b. Remove the render in Hero

In `src/components/Hero.tsx` (~line 236):

- Find the JSX element that displays `soldToday` or "sold today" / "people just bought" / similar.
- Remove the entire element (the wrapping `<div>` / `<span>` block), not just the value.
- If the surrounding hero layout depends on this element for spacing, leave a small comment placeholder noting "intentionally removed — re-add when real metrics available" so future me doesn't wonder.

### 1c. Re-grep to confirm zero matches

```sh
grep -rniE "sold today|sold this|just sold|people sold|recently sold|soldToday" src/ app/ 2>/dev/null
# Expected: nothing
```

If anything remains, find and remove it before continuing.

## Task 2 — Remove all 5 testimonials

In `src/app/page.tsx` (and any other file the audit found):

- Find the testimonials section/component.
- Remove all 5 testimonials AND the section heading that introduces them.
- If the page layout uses a grid/section structure where removing the testimonial section breaks the visual flow: leave a one-line comment placeholder (`{/* testimonials section removed — re-add when real customer quotes exist */}`).
- Do NOT replace with "coming soon" copy. The cleanest legal posture is no testimonial section at all until real ones exist.

If the testimonials are defined in a data file (e.g. `src/lib/testimonials.ts`):

- Empty the testimonial array (`export const testimonials = []`) OR delete the data file and its imports. Either works — choose whichever causes the least collateral.

Re-grep:

```sh
grep -rniE "testimonial|sofiar|marcust|jadew" src/ app/ 2>/dev/null
# Expected: nothing (or only an unrelated word "testimonial" in a comment, which is fine)
```

## Task 3 — Commit cleanup changes (Tasks 1 + 2)

```sh
git add -A
git commit -m "remove fabricated marketing content (203 sold today, 5 fake testimonials)"
git push origin claude/dreamy-ptolemy-d624d6
```

Wait 60–120 sec for Vercel preview redeploy. Reload `https://dreamy-ptolemy-d624d6.vercel.app`. Verify:

- "203 sold today" badge is gone
- Testimonials section is gone (or empty)

## Task 4 — Investigate the /api/products 503 (DO NOT FIX YET)

**This is diagnostics only. Report root cause; founder approves the fix before you implement it.**

### 4a. Read the API route code

Find the route handler:

```sh
ls src/app/api/products/ 2>/dev/null || find . -path "*api/products*" -name "*.ts" -o -name "*.tsx" 2>/dev/null
```

Read the route handler file (likely `src/app/api/products/route.ts` or `pages/api/products.ts`). Note:

- Which Shopify endpoint it calls (Storefront API GraphQL? Admin API? a third-party wrapper?)
- Which env vars it reads (`SHOPIFY_STOREFRONT_ACCESS_TOKEN`, `SHOPIFY_STORE_DOMAIN`, `SHOPIFY_API_VERSION`, etc.)
- Whether it has retry logic, timeout config, error handling
- Whether it's running on Edge runtime, Node runtime, or default

### 4b. Check the Vercel project's environment variables

Open https://vercel.com → log into the `dreamy-ptolemy-d624d6` project → Settings → Environment Variables.

List every env var defined (names only — DO NOT copy values to chat). Note for each:

- Which environment(s) it's set in (Production / Preview / Development)
- Whether the value field is non-empty (Vercel shows the length or partial preview)

Specifically confirm these exist with non-empty values in the **Production** environment:

- `SHOPIFY_STOREFRONT_ACCESS_TOKEN` (the public Storefront API token)
- `SHOPIFY_STORE_DOMAIN` (should be `noviqe-2.myshopify.com` per the build report)
- Possibly `SHOPIFY_API_VERSION` if the route specifies one

### 4c. Read recent runtime logs

Vercel project → Logs → Runtime Logs → filter to the `dreamy-ptolemy-d624d6` deployment → look for entries on `/api/products`.

Report:

- The most recent 5 entries: timestamp, HTTP code, error message (if any), function duration
- Any pattern in failures: do they all return the same error? Do they correlate with cold starts (long durations)?

### 4d. Test the Shopify Storefront API directly

From the browser dev console (no terminal needed via the extension), test a direct call to the Storefront API to see if Shopify-side is the problem:

```js
// In browser console (any tab):
const domain = '<value-of-SHOPIFY_STORE_DOMAIN>';   // founder fills this in if needed
const token = '<the storefront token>';  // founder fills this in if needed
const r = await fetch(`https://${domain}/api/2024-04/graphql.json`, {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-Shopify-Storefront-Access-Token': token,
  },
  body: JSON.stringify({ query: `{ products(first: 3) { edges { node { id title handle } } } }` }),
});
console.log(r.status, await r.json());
```

**If the founder isn't comfortable pasting their Storefront token into the console: skip this step.** It's a nice-to-have for diagnostics, not required.

If you DO run this: report the HTTP status and whether products came back. If yes → Shopify-side is fine, the bug is in the Next.js route. If 401/403 → token is invalid. If 5xx from Shopify → Shopify-side rate limiting or outage.

### 4e. Diagnose and propose

Based on 4a–4d, propose a root cause in the report. Common hypotheses to evaluate:

- **Missing/wrong env var on Production:** the most common cause. Easy fix: add the env var, redeploy.
- **Wrong env scope:** env var defined in Preview but not Production (or vice versa).
- **Edge runtime + Node-only library:** if the route uses something that only works on Node runtime but is configured for Edge.
- **Function timeout:** if the route takes >10s default on Vercel, it returns 504/503. Could indicate slow Shopify response or infinite retries in the code.
- **Bug in route handler:** wrong path, wrong method, missing JSON parsing, etc.
- **Rate limiting:** if the route fires many parallel requests on every page load, Shopify Storefront API rate limits could be hit.

**Do NOT apply any fix yet.** Report findings and proposed fix. Founder approves direction before you implement.

## Report back

Save to `dispatch-handoffs/2026-05-15-cleanup-and-api-fix-RESULT.md` and paste here:

```
# Cleanup + API Investigation Result

**Completed at:** <timestamp>

## Tasks 1 + 2 — Fabricated content removal
- Files modified: <list>
- grep checks (post-removal):
  - "203 / soldToday" matches: <0 | non-zero>
  - "testimonial / @handle" matches: <0 | non-zero>
- Commit SHA: <sha>
- Push status: <success | failure>
- Vercel preview redeploy: <success | failure>
- Visual confirmation on preview URL:
  - "203 sold today" badge gone: <yes | no>
  - Testimonials section gone/empty: <yes | no>

## Task 4 — /api/products investigation

### 4a. Route handler
- File path: <path>
- Shopify endpoint called: <Storefront GraphQL / Admin REST / other>
- Env vars read: <list>
- Runtime: <Edge | Node | default>
- Retry / timeout config: <describe or none>

### 4b. Vercel env vars (Production)
- SHOPIFY_STOREFRONT_ACCESS_TOKEN: <set with value | missing | set but empty>
- SHOPIFY_STORE_DOMAIN: <value visible: noviqe-2.myshopify.com / other / missing>
- SHOPIFY_API_VERSION: <value or not set>
- Other Shopify-related env vars: <list>

### 4c. Recent runtime logs (last 5 /api/products entries)
| Timestamp | HTTP | Duration | Error |
|---|---|---|---|
| ... | ... | ... | ... |
- Pattern: <describe>

### 4d. Direct Shopify Storefront API test
- Run: <yes | skipped — founder declined>
- If yes: HTTP status: <200 | other>, products returned: <count or error>

### 4e. Proposed root cause + fix
- Root cause hypothesis: <one sentence>
- Confidence: <high | medium | low>
- Proposed fix: <describe specifically — what file, what change, why>
- Estimated fix time: <minutes>
- Risk if fix is wrong: <describe>

## Issues / blockers
<none | describe>
```
