# Dispatch Packet — DSers Mapping for Products 4, 5, 6

**From:** Claude planner on `djepy/docs`
**To:** Claude dispatch on `C:\Users\Gefte Debreus\myproject`
**Issued:** 2026-05-15
**Phase:** Pre-cutover — DSers fulfillment mapping
**Estimated time:** 10–15 minutes via browser extension
**Paste-ready:** yes, no founder pre-fill needed

## Hard rules

- Do NOT cut over the domain. Do NOT touch `noviqe.com` Vercel settings.
- Do NOT request a Vercel API token.
- Do NOT install pixels — that's a separate packet.
- ALWAYS access DSers via Shopify admin → Apps → DSers-AliExpress → Open app. NEVER direct login to `dsers.com`.
- DSers dropdowns require **real mouse clicks** with the screenshot → click-by-coordinates technique. JavaScript DOM manipulation does NOT work (confirmed in the build report — don't re-discover this the hard way).
- Fail loudly — no `|| true`, no silent retries on failure.

## Step 0 — Pre-check: confirm Products 4 & 5 are Active

The packet that asked you to verify these may have left them in draft. Confirm and activate before mapping.

1. Open Shopify admin → Products.
2. Find each of these two products:
   - **LED Blue Light Therapy Device**
   - **K-Beauty Collagen Sleeping Mask**
3. For each:
   - If status = **Draft**: change to **Active**, save
   - If status = **Active**: leave as-is, note it
   - If **not found**: STOP, report this back, do NOT proceed with mapping (means a previous packet didn't complete)
4. Also confirm **LED Galaxy Projector** is Active (created in a previous round).

After Step 0, all three of: LED Blue Light Therapy Device, K-Beauty Collagen Sleeping Mask, LED Galaxy Projector must be Active in Shopify.

## Step 1 — Open DSers

Shopify admin → Apps → DSers-AliExpress Dropshipping → Open app.

If DSers shows a login wall instead of the product list, the session expired — close, re-open via Apps, NEVER go to dsers.com directly.

## Step 2 — Map LED Blue Light Therapy Device

1. In DSers product list, find "LED Blue Light Therapy Device".
2. Click the globe/marketplace icon on the product card.
3. AliExpress search query: `blue light therapy acne device`
4. Filter to: 4+ stars, 1000+ orders, ships from China (or warehouse closest to North America if available).
5. Pick the top supplier matching those criteria. Record:
   - Supplier store name
   - Supplier product URL
   - Supplier price per unit
6. Map variants (if any color/size options): for each variant dropdown, use the screenshot → click-by-coordinates method. The options render at `document.body`, not inside the dialog.
7. Click Save.
8. Confirm the product card shows a "Mapped" indicator.

## Step 3 — Map K-Beauty Collagen Sleeping Mask

1. In DSers product list, find "K-Beauty Collagen Sleeping Mask".
2. AliExpress search query: `collagen sleeping mask Korean`
3. Filter: 4+ stars, 1000+ orders, ships from China.
4. Pick top supplier, record: store name, URL, price.
5. Map variants if any, save, confirm Mapped indicator.

## Step 4 — Map LED Galaxy Projector

1. In DSers product list, find "LED Galaxy Projector".
2. AliExpress search query: `LED galaxy projector star night light`
3. Filter: 4+ stars, 1000+ orders, ships from China.
4. Pick top supplier, record: store name, URL, price.
5. Map variants if any, save, confirm Mapped indicator.

## Step 5 — Final verification

1. Return to the DSers product list.
2. Confirm all three new products show as Mapped.
3. Also visually confirm the three previously-mapped products (LED Red Light Face Mask, Smart Posture Corrector, K-Beauty Gentle Foam Cleanser) still show as Mapped — i.e. nothing was broken in this session.

## Report back

Save to `dispatch-handoffs/2026-05-15-dsers-mapping-RESULT.md` in the project repo and paste here:

```
# DSers Mapping Result

**Completed at:** <timestamp>

## Step 0 — pre-check
- LED Blue Light Therapy Device: <was active | was draft, now active | missing — stopped>
- K-Beauty Collagen Sleeping Mask: <was active | was draft, now active | missing — stopped>
- LED Galaxy Projector: <was active | other>

## Mapping results

| Product | Supplier name | Supplier URL | Cost USD | Implied margin vs retail | Status |
|---|---|---|---|---|---|
| LED Blue Light Therapy Device ($39.99) | | | | | mapped / failed |
| K-Beauty Collagen Sleeping Mask ($29.99) | | | | | mapped / failed |
| LED Galaxy Projector ($49.99) | | | | | mapped / failed |

## Existing mappings unchanged
- LED Red Light Face Mask: <still mapped | broken>
- Smart Posture Corrector: <still mapped | broken>
- K-Beauty Gentle Foam Cleanser: <still mapped | broken>

## Issues / blockers
<none | describe>
```
