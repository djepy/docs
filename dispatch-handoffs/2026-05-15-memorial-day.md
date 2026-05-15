# Dispatch Handoff — Noviqe Memorial Day Campaign (Phase A: file work)

**From:** Claude session on `djepy/docs` (the planner)
**To:** Claude on `C:\Users\Gefte Debreus\myproject` (dispatch — the hands)
**Founder:** Gefte Debreus
**Issued:** 2026-05-15
**Branch:** `claude/dreamy-ptolemy-d624d6`
**Phase:** A (file work only — no credentials, no production cutover)

---

## What this is

A complete work order for the Memorial Day campaign's **file-only** work.
Execute end-to-end without asking the founder for clarification on the
artifacts — they are spelled out below. Ask only if the codebase looks
unexpectedly different from what's described.

## Hard rules — read before you start

1. **Branch:** every git operation in this packet is against
   `claude/dreamy-ptolemy-d624d6`. Confirm you're on that branch before
   touching anything. Do **not** push to `main` or any production-aliased
   branch.
2. **No credentials.** This packet contains zero tokens, API keys, or
   passwords. If a step seems to need one, **stop** — the cutover work
   (Phase B) is a separate packet, not this one.
3. **No Shopify admin.** Pixel install, product creation, discount codes,
   contact-email change — all of those are founder-only Shopify clicks.
   Do not attempt them.
4. **No domain changes.** Do not run any script that points `noviqe.com`
   anywhere. The cutover is Phase B, gated on the founder rotating their
   Vercel token and finishing the Shopify-side work.
5. **Fail loudly.** If `git push` errors, `npm run build` errors, or the
   Vercel preview doesn't refresh — say so in the report at the bottom.
   No silent `|| true`.
6. **Voice samples pending.** The content below was written without the
   founder's writing samples. If they provide samples later, expect a
   Phase A2 revision packet that rewrites the email and blog in their
   voice.

---

## Step 1 — Confirm branch state

```sh
cd "C:\Users\Gefte Debreus\myproject"
git fetch origin
git checkout claude/dreamy-ptolemy-d624d6
git pull origin claude/dreamy-ptolemy-d624d6 --ff-only
git status      # expect: working tree clean
```

If the branch is dirty or has unpushed work, **stop** and tell the founder
before continuing.

---

## Step 2 — Create `marketing/memday20-email.md`

Path: `marketing/memday20-email.md` (create the `marketing/` directory if
it doesn't exist).

Save **exactly** this content into the file:

````markdown
# Memorial Day email — MEMDAY20 (May 20–26, 2026)

**Subject:** 20% Off Everything This Memorial Day Weekend 🇺🇸

**Body:**

Hey,

Memorial Day weekend gives you a few extra hours that belong to you.
We're making the math easier.

May 20 through May 26, take 20% off any order over $75 with code
**MEMDAY20**.

Two we'd put at the top of your cart:

**LED Red Light Therapy Face Mask** — $79.99, after the code: $63.99.
Fifteen-minute sessions, three or four times a week. Most of our
customers come back for a second one as a gift.

**Smart Posture Corrector** — $34.99, after the code: $27.99. The kind
of thing you put on once and forget you're wearing, until you realize
you stopped slouching.

Stack either with anything else to clear the $75 threshold. Free
shipping already kicks in at $49 regardless.

Code expires Monday May 26 at midnight. After that, prices snap back.

→ **[Shop the Memorial Day Sale]({{LINK}})**

Enjoy the long weekend.

— NOVIQE

---

**Founder instructions:**
1. Replace `{{LINK}}` with the campaign landing URL before sending —
   typically `https://noviqe.com/?utm_source=email&utm_campaign=memday20`.
2. Send window: May 20 morning (Eastern), one resend May 25 afternoon to
   non-openers if list is large enough.
3. From: `gefte@noviqe.com` (the Zoho address).
````

---

## Step 3 — Create `marketing/blog-red-light-therapy-mask.md`

Path: `marketing/blog-red-light-therapy-mask.md`.

Save **exactly** this content into the file:

````markdown
# Red Light Therapy Masks: Complete Guide to Glowing Skin in 2026

**Target keywords:** red light therapy mask, best LED face mask 2026,
at home red light therapy
**Length:** ~950 words
**Status:** DRAFT — resolve `[CHECK]` items before publishing

---

A friend showed up to brunch last weekend looking different. Not "she
slept well" different — actually different. Brighter skin, less of the
drawn look most of us carry through a Tuesday. When I asked what
changed, she pointed to a $90 mask sitting on her bathroom shelf.

Here's the thing about red light therapy at home: ten years ago it was
a clinic-only treatment costing $150 per session. Now it ships in a
box. But the gap between marketing and science is wide enough to drive
a truck through, so let's talk about what the technology actually does
— and what to look for when you buy one.

## What red light therapy actually is

Red light therapy, technically called photobiomodulation, uses specific
wavelengths of light — usually red (around 630–660 nanometers) and
sometimes near-infrared (810–850 nm) — that penetrate the surface of
the skin and reach the cells underneath.

The mechanism isn't magic. Inside your cells are mitochondria, the
structures that produce energy. A protein inside mitochondria called
cytochrome c oxidase absorbs red and near-infrared light, and that
absorption increases cellular energy production. More cellular energy
means cells do their jobs better — including the ones responsible for
collagen production and skin repair.

That's the science. What it means in practice depends on the device,
the dose, and the consistency of use.

## How LED face masks work

A red light therapy face mask is essentially a panel of LEDs shaped to
fit your face. The mask delivers light for a fixed period — usually 10
to 20 minutes per session.

Three numbers actually matter when comparing masks:

1. **Wavelength.** Look for 630–660 nm red light. Higher-end masks add
   810–850 nm near-infrared, which penetrates deeper. Blue light masks
   target acne-causing bacteria, not collagen — different mechanism,
   don't confuse them.
2. **Irradiance.** Light intensity, measured in milliwatts per square
   centimeter. Most home masks fall between 4–100 mW/cm². Higher isn't
   always better.
3. **Session time.** Most clinical research uses 10–20-minute sessions,
   3–5 times per week, over 8–12 weeks before measuring results.

If a mask doesn't publish its wavelength and irradiance numbers,
that's a tell — they probably don't want you doing the math.

## What red light therapy actually does (and doesn't)

There is real research on red light therapy for skin. **[CHECK:** cite
specific studies from *Journal of Photochemistry and Photobiology B* or
*Lasers in Surgery and Medicine* — pull the strongest 2–3 references
before publishing.**]** The findings most consistently supported:

- **Collagen production.** Multiple studies show red light at
  therapeutic doses increases collagen density over 8–12 weeks of
  consistent use.
- **Fine line and wrinkle appearance.** Real improvement, moderate
  scale. Don't expect Botox results from a $90 mask.
- **Skin texture and tone.** Several studies report improved smoothness
  and brightness with consistent use over 8+ weeks.
- **Acne (with added blue light).** Combined red and blue light has
  been studied for acne reduction. **[CHECK:** confirm whether
  NOVIQE's specific mask carries FDA clearance for this use before
  stating it.**]**

What red light therapy isn't:

- A replacement for sunscreen, retinol, or a dermatologist
- A fix for deep wrinkles, scarring, or pigmentation issues that need
  professional treatment
- A quick win. Two weeks won't show measurable results. Most studies
  measure outcomes at 8 weeks minimum.

## How to actually use a red light mask

The protocol most studies use is straightforward:

1. Start with clean, dry skin. No moisturizer or serum during the
   session — they refract the light and absorb the wavelengths you paid
   for.
2. Wear the mask for 10–20 minutes. Going longer doesn't make it work
   faster; the research doesn't support that.
3. Run sessions 3–5 times per week, not daily. Skin needs recovery time.
4. Apply your skincare *after* the session — increased cellular
   activity actually helps active ingredients absorb.
5. Keep the schedule for at least 8 weeks before judging the result.

Eye protection: most masks include built-in coverage or come with
goggles. Use them. Red light is safe in normal use, but staring at
high-intensity LEDs for 15 minutes isn't great for retinas either.

## Why we built ours

The NOVIQE LED Red Light Therapy Face Mask runs at 630 nm red and
850 nm near-infrared, 15-minute sessions, with built-in eye protection.
We picked those specs because they're the ones with the most consistent
research behind them — not because they were cheapest to source. Three
or four sessions a week for at least two months. That's the only
honest pitch for a red light mask.

[Shop the NOVIQE LED Face Mask](/products/led-red-light-therapy-face-mask)
````

**Important:** before the founder publishes this blog post in Shopify,
the two `[CHECK]` items must be resolved. Either:
(a) cite 2–3 actual peer-reviewed studies with specific findings, or
(b) soften the claim language to remove anything not backed by real
research. Don't ship the post as-is.

---

## Step 4 — Insert the Memorial Day banner into `Hero.tsx`

File: `src/components/Hero.tsx` (or wherever the main hero component
lives — search for `Hero.tsx` if the path differs).

**Find** the main `<h1>` headline element. Insert the following JSX
fragment as a sibling **immediately after the closing `</h1>` tag**,
before any CTA buttons. If the surrounding markup uses a flex/grid
container, the fragment should sit inside that container as a new
child between the headline and the buttons.

**JSX to insert** (copy verbatim):

```jsx
{/* Memorial Day Sale banner — remove after 2026-05-26 */}
<div className="mt-6 mx-auto max-w-3xl rounded-full bg-[#00C2CB]/95 backdrop-blur-sm border border-white/10 px-6 py-3 text-center shadow-lg shadow-[#00C2CB]/30">
  <p className="text-[#F5A623] font-semibold text-sm sm:text-base tracking-wide">
    🇺🇸 Memorial Day Sale — 20% Off Orders $75+{" "}
    <span className="hidden sm:inline">|</span>{" "}
    <span className="font-bold">Code: MEMDAY20</span>{" "}
    <span className="hidden sm:inline">|</span>{" "}
    May 20–26 Only
  </p>
</div>
```

**Fallback if contrast looks too soft when rendered:** swap the inner
`<p>` className from `text-[#F5A623]` to `text-[#1B1F3B]` (navy on
teal — higher contrast, still on-brand).

**If `Hero.tsx` looks structurally different** from a "headline + CTAs"
hero and you can't find an obvious place to insert the fragment, **stop
and ask the founder** — don't guess at a position.

---

## Step 5 — Commit and push

Three separate commits for clean history:

```sh
git add marketing/memday20-email.md
git commit -m "marketing: add Memorial Day email draft (MEMDAY20)"

git add marketing/blog-red-light-therapy-mask.md
git commit -m "marketing: add red light therapy mask SEO blog draft (CHECKs pending)"

git add src/components/Hero.tsx
git commit -m "hero: add Memorial Day Sale banner (remove after 2026-05-26)"

git push origin claude/dreamy-ptolemy-d624d6
```

If push fails, **report the exact error** in Step 8 — don't retry with
force-push, don't push to a different branch.

---

## Step 6 — Wait for Vercel preview to redeploy

Push triggers an auto-deploy to the preview URL
`https://dreamy-ptolemy-d624d6.vercel.app`. Typical build time for the
existing Next.js 14 setup: 60–120 seconds.

Wait up to 3 minutes, then proceed to smoke test. If after 3 minutes
the homepage doesn't reflect the change, **report** in Step 8 — don't
assume Vercel will figure it out.

---

## Step 7 — Smoke test the preview URL

Run these checks against `https://dreamy-ptolemy-d624d6.vercel.app`:

1. **Banner visible on homepage.** Load the homepage. The Memorial Day
   banner appears below the hero headline. Take a screenshot.
2. **Banner copy is correct.** The text must read exactly:
   "🇺🇸 Memorial Day Sale — 20% Off Orders $75+ | Code: MEMDAY20 |
   May 20–26 Only"
3. **No console errors.** Open browser dev tools → Console. Note any
   red errors. Hydration warnings about the banner are a problem;
   warnings unrelated to the banner can be flagged but aren't blocking.
4. **Mobile responsive.** Resize the browser to ~375px wide (iPhone
   width). The `|` separators should hide on mobile (per the
   `hidden sm:inline` classes); the banner text should still be
   readable on one or two lines.
5. **Banner does NOT appear on noviqe.com (production).** That domain
   is still pointed at the old project, so the banner shouldn't be
   live yet. **Confirm this is the case.** If the banner is already
   on `noviqe.com`, something has gone wrong with the project
   configuration — stop and report.

---

## Step 8 — Report back to the founder

Append this report (filled in) to the same Claude conversation that
issued this packet, or save it to
`dispatch-handoffs/2026-05-15-memorial-day-RESULT.md` in the project
repo for the planner to read.

```
# Phase A result — Memorial Day campaign

**Completed at:** <timestamp>
**Commits pushed:**
- <sha> marketing: add Memorial Day email draft
- <sha> marketing: add red light therapy blog draft
- <sha> hero: add Memorial Day Sale banner

**Vercel preview redeploy:** <success | failed — error>
**Banner visible on preview:** <yes | no — what shows instead>
**Smoke test results:**
  1. Banner visible: <yes | no>
  2. Copy correct: <yes | no — actual copy>
  3. Console errors: <none | list them>
  4. Mobile responsive: <yes | no>
  5. noviqe.com still on OLD project: <yes — confirmed | NO, banner already on prod>

**Issues encountered:** <none | describe>
**Founder next steps:**
  - Review email body and replace {{LINK}}
  - Resolve [CHECK] items in blog post before publishing
  - Proceed with Shopify-side tasks (pixels, products, codes, contact email)
  - Issue Phase B packet when ready for domain cutover
```

---

## Phase B is NOT in this packet

Domain cutover (`noviqe.com` → `dreamy-ptolemy-d624d6` Vercel project)
requires:
1. The founder rotating their Vercel API token (the previous one was
   revoked on 2026-05-15 after leaking in plaintext).
2. The founder completing the Shopify-side launch tasks: Meta + TikTok
   pixels installed, products 4–6 live and DSers-mapped, discount codes
   `GLOWDROP15` + `MEMDAY20` created, store contact email updated to
   `gefte@noviqe.com`.
3. The "50,000+ happy customers / 4.7★ / 100% trend-verified" placeholder
   block removed from the site (it's generated copy, not real data).

When all three preconditions are met, the planner will issue a separate
Phase B handoff packet with the cutover script, smoke test for the live
domain, and rollback procedure.

**Do not attempt the cutover from this packet.**
