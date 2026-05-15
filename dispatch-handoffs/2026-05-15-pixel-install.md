# Dispatch Packet — Meta + TikTok Pixel Installation

**From:** Claude planner on `djepy/docs`
**To:** Claude dispatch on `C:\Users\Gefte Debreus\myproject`
**Issued:** 2026-05-15
**Phase:** Pre-cutover — analytics tracking
**Estimated time:** 25–40 minutes (longer if Meta Pixel needs to be created from scratch)

---

## ⚠ FOUNDER PRE-FILL (do this BEFORE pasting to dispatch)

This packet has one placeholder you must replace yourself. Dispatch cannot fetch your Meta Pixel ID — you have to grab it.

### Get your Meta Pixel ID

If you already have a pixel:
1. Go to https://business.facebook.com → Events Manager
2. Click your pixel in the left sidebar
3. Pixel ID is a 15-16 digit number at the top, e.g. `1234567890123456`

If you don't have one yet:
1. Go to https://business.facebook.com → Events Manager
2. "Connect Data Sources" → Web → Meta Pixel → Connect
3. Name it `Noviqe` → Continue → "Skip" the prompts about API access (we install via Shopify, not API)
4. Copy the 15-16 digit Pixel ID

Then replace this placeholder below before pasting the packet:

```
META_PIXEL_ID_PLACEHOLDER  ← replace this with your actual ID (the bare digits, no quotes)
```

The TikTok Pixel ID is *not* a prefill — dispatch will capture it after installing the TikTok Shopify app in Phase 1.

---

## Hard rules

- Do NOT cut over the domain. Do NOT touch Vercel project settings beyond what this packet requires.
- Do NOT request a Vercel API token.
- For TikTok: install the Shopify app and use OAuth — do NOT paste TikTok API keys.
- If the founder isn't logged into their TikTok ads account in this browser, pause the OAuth flow and request a log-in (one-time interruption, then resume).
- Fail loudly. No silent retries.

## Phase 1 — Install TikTok pixel (Shopify-side)

1. Open Shopify admin → Apps → "Visit Shopify App Store".
2. Search `TikTok`.
3. Click **TikTok for Shopify** (by TikTok Inc. — verify the publisher, do not install lookalikes).
4. Click Install.
5. Click through the connect flow:
   - "Connect TikTok account"
   - TikTok OAuth — log in if not logged in, approve permissions
   - Pixel auto-installs on Shopify checkout pages
6. Capture the TikTok Pixel ID:
   - In the TikTok app inside Shopify, look for "Pixel ID"
   - OR visit https://ads.tiktok.com → Events Manager → Web Events → your new pixel
   - The ID looks like a 20-character alphanumeric string, e.g. `CMHV1JBC77UDC8AKDP00`
   - Record this — Phase 3 needs it.

## Phase 2 — Install Meta pixel (Shopify-side)

1. Shopify admin → Online Store → Preferences.
2. Scroll to "Facebook pixel" section.
3. Paste the Meta Pixel ID (the one the founder filled in at the top).
4. Click Save.
5. Confirm the section shows "Pixel connected" or equivalent.

## Phase 3 — Embed both pixels in the Next.js storefront

The Shopify-side installs only cover checkout pages. The Next.js storefront at `noviqe.com` (currently the preview URL) needs the pixels embedded in code to track PageView, AddToCart, ViewContent etc. on the storefront pages.

```sh
cd "C:\Users\Gefte Debreus\myproject"
git fetch origin
git checkout claude/dreamy-ptolemy-d624d6
git pull origin claude/dreamy-ptolemy-d624d6 --ff-only
```

Open `src/app/layout.tsx` (or whichever file is the App Router root layout — confirm by checking which file contains the root `<html>` and `<body>` tags).

### 3a. Ensure the import exists at the top

```tsx
import Script from "next/script"
```

If the import is already present, leave it. If not, add it.

### 3b. Insert pixel scripts inside the `<body>`, before the existing children

Use this block exactly. Replace **`META_PIXEL_ID`** (two occurrences) with the founder's Meta Pixel ID. Replace **`TIKTOK_PIXEL_ID`** (one occurrence) with the ID you captured in Phase 1.

```tsx
{/* Meta Pixel */}
<Script
  id="meta-pixel"
  strategy="afterInteractive"
  dangerouslySetInnerHTML={{
    __html: `
      !function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
      n.callMethod.apply(n,arguments):n.queue.push(arguments)};
      if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
      n.queue=[];t=b.createElement(e);t.async=!0;
      t.src=v;s=b.getElementsByTagName(e)[0];
      s.parentNode.insertBefore(t,s)}(window,document,'script',
      'https://connect.facebook.net/en_US/fbevents.js');
      fbq('init','META_PIXEL_ID');
      fbq('track','PageView');
    `,
  }}
/>
<noscript>
  <img
    height="1"
    width="1"
    style={{ display: "none" }}
    src="https://www.facebook.com/tr?id=META_PIXEL_ID&ev=PageView&noscript=1"
    alt=""
  />
</noscript>

{/* TikTok Pixel */}
<Script
  id="tiktok-pixel"
  strategy="afterInteractive"
  dangerouslySetInnerHTML={{
    __html: `
      !function (w, d, t) {
        w.TiktokAnalyticsObject=t;var ttq=w[t]=w[t]||[];ttq.methods=["page","track","identify","instances","debug","on","off","once","ready","alias","group","enableCookie","disableCookie"],ttq.setAndDefer=function(t,e){t[e]=function(){t.push([e].concat(Array.prototype.slice.call(arguments,0)))}};for(var i=0;i<ttq.methods.length;i++)ttq.setAndDefer(ttq,ttq.methods[i]);ttq.instance=function(t){for(var e=ttq._i[t]||[],n=0;n<ttq.methods.length;n++)ttq.setAndDefer(e,ttq.methods[n]);return e},ttq.load=function(e,n){var i="https://analytics.tiktok.com/i18n/pixel/events.js";ttq._i=ttq._i||{},ttq._i[e]=[],ttq._i[e]._u=i,ttq._t=ttq._t||{},ttq._t[e]=+new Date,ttq._o=ttq._o||{},ttq._o[e]=n||{};var o=document.createElement("script");o.type="text/javascript",o.async=!0,o.src=i+"?sdkid="+e+"&lib="+t;var a=document.getElementsByTagName("script")[0];a.parentNode.insertBefore(o,a)};
        ttq.load('TIKTOK_PIXEL_ID');
        ttq.page();
      }(window, document, 'ttq');
    `,
  }}
/>
```

After replacing the IDs, re-grep to confirm no literal placeholder strings remain:

```sh
grep -n "META_PIXEL_ID\|TIKTOK_PIXEL_ID" src/app/layout.tsx
# Expected: nothing (the placeholders are gone, replaced with real IDs)
```

### 3c. Commit and push

```sh
git add src/app/layout.tsx
git commit -m "analytics: embed Meta + TikTok pixels in Next.js root layout"
git push origin claude/dreamy-ptolemy-d624d6
```

If push fails, report the exact error. Do NOT force-push.

Wait 60–120 seconds for the Vercel preview to redeploy.

## Phase 4 — Verify pixels fire on the preview URL

Load `https://dreamy-ptolemy-d624d6.vercel.app` with browser dev tools open.

**Network tab → filter `facebook`:**
- [ ] `fbevents.js` loads with HTTP 200
- [ ] Request to `facebook.com/tr` with `ev=PageView` fires

**Network tab → filter `tiktok`:**
- [ ] `events.js` loads from `analytics.tiktok.com` with HTTP 200
- [ ] Request to `analytics.tiktok.com/api/v2/pixel/track` fires with the page event

**Console tab:**
- [ ] No errors related to `fbq` or `ttq`
- [ ] Typing `fbq` returns the function (not `undefined`)
- [ ] Typing `ttq` returns the object

**Meta verification (extra confidence):** open https://business.facebook.com → Events Manager → your pixel → Test Events tab → enter the preview URL. PageView should appear within 30 seconds.

**TikTok verification (extra confidence):** TikTok Events Manager → your pixel → Test Events. Same flow.

## Report back

Save to `dispatch-handoffs/2026-05-15-pixel-install-RESULT.md` in the project repo and paste here:

```
# Pixel Installation Result

**Completed at:** <timestamp>

## Phase 1 — TikTok (Shopify app)
- TikTok for Shopify installed: <yes | no — error>
- TikTok ads account connected via OAuth: <yes | no — error>
- TikTok Pixel ID captured: <pixel ID>

## Phase 2 — Meta pixel in Shopify Preferences
- Meta Pixel ID pasted and saved: <yes — saved | no — error>

## Phase 3 — Next.js code embedding
- Files modified: <list>
- Placeholder strings remaining (must be 0): <0 | non-zero — what>
- Commit SHA: <sha>
- Push status: <success | failure with exact error>
- Vercel preview redeploy: <success | failure>

## Phase 4 — Verification on preview URL
- fbevents.js loads: <yes | no>
- Meta PageView fires: <yes | no>
- TikTok events.js loads: <yes | no>
- TikTok page event fires: <yes | no>
- Console errors: <none | list>
- Meta Test Events tab shows PageView: <yes | no | didn't check>
- TikTok Test Events tab shows PageView: <yes | no | didn't check>

## Issues / blockers
<none | describe>
```
