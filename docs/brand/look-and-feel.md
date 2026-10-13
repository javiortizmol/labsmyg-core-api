# Laboratorios M&G — Look & Feel

Canonical visual language for Labs MYG surfaces (web apps, Keycloak themes,
transactional email chrome, future marketing). Extracted from
[laboratoriosmyg.com](https://laboratoriosmyg.com/) (Elementor theme tokens +
rendered UI) and the official logo lockups under `docs/brand/`.

Other Labs MYG repos **MUST** align to this kit. Product UI MUST NOT invent a
second brand palette (no purple SaaS defaults, no Mandado gold/ink, no cream
serif newspaper look).

**Git source of truth (binaries + this doc):** `labsmyg-core-api/docs/brand/`  
**Runtime CSS tokens (front):** `labsmyg-core-front/src/styles/brand-tokens.css`  
**Spec:** `specs/028-brand-look-and-feel`

---

## Brand display vs domain (locked)

| Layer | Value |
|-------|--------|
| **Display name (short)** | **Laboratorios MYG** — chrome titles, nav, SMS/email From display when space is tight |
| **Display name (lockup)** | **Laboratorios M&G S.A.S** — matches the official logo type |
| **Legal entity** | Laboratorios M&G S.A.S |
| **Domain** | `laboratoriosmyg.com` — HTTPS hosts, `@laboratoriosmyg.com` addresses |
| **Slogan** | *Porque siempre es mejor, Probar!* — optional under lockup; do not invent alternate taglines |

Do not render the bare domain string as the typographic logo. Prefer the
supplied PNG lockups over reconstructing “M&G” in CSS.

---

## 1. Color tokens

Site globals (Elementor) and logo sampling agree on a **cyan/teal primary** with
**navy headings** and a **bright cyan** mark (measuring tape). Locked product
tokens:

| Token | Hex | Role | Source |
|-------|-----|------|--------|
| `brand` | `#017EA0` | Primary CTA fill, accents, focus rings | Elementor `--e-global-color-primary` / `.btn` |
| `brand-bright` | `#00CCEC` | Logo tape highlight, strong accents on dark | Dominant cyan in HQ logo |
| `brand-deep` | `#005080` | CTA hover, tape shadow, deep accent | Logo shadow blues |
| `navy` | `#012C47` | Headings (H2-class) | Site `h2` |
| `ink` | `#181B31` | Dark text / dense chrome | Site `h1` / link hover |
| `steel` | `#C0C0C0` | Metallic “Laboratorios” wordmark accents | Logo silver |
| `muted` | `#808291` | Secondary body on paper | Site body |
| `secondary` | `#5684EC` | Soft link/info accent (sparingly) | Elementor secondary |
| `mist` | `#F5F7FA` | Light workspace / section fill | Product (clean light) |
| `paper` | `#FFFFFF` | Elevated surfaces, page background | Site |

CSS variables (front `:root` / any themed surface):

```css
--color-brand: #017ea0;
--color-brand-bright: #00ccec;
--color-brand-deep: #005080;
--color-navy: #012c47;
--color-ink: #181b31;
--color-steel: #c0c0c0;
--color-muted: #808291;
--color-secondary: #5684ec;
--color-mist: #f5f7fa;
--color-paper: #ffffff;
```

### Semantic (supporting — not brand primaries)

| Token | Hex | Role |
|-------|-----|------|
| `success` | `#46B450` | Positive / OK |
| `warning` | `#F5B028` | Caution |
| `danger` | `#DC3232` | Error / destructive |
| `whatsapp` | `#25D366` | WhatsApp FAB only — do not reuse as brand green |

### Contrast rules

- On **mist** / **paper**: body in **ink** or **navy** for headings. Brand cyan
  for CTAs, links, icons — not small cyan body copy.
- On **ink** / dark chrome: body in **paper** / muted light; CTAs in **brand**
  or outline **brand-bright**.
- Selection / focus: brand cyan (see focus rings).
- Do **not** use Mandado gold (`#FFD95A`) or Mandado ink (`#151515`) as Labs MYG
  brand tokens.

### Focus rings (locked)

| Rule | Value |
|------|--------|
| When | `:focus-visible` only |
| Color | **brand** `#017EA0` on paper/mist; **brand-bright** on dark chrome |
| Shape | ~2px solid outline, offset ~3px |
| Forbidden | Browser-default blue outline left as sole focus; `outline: none` with no replacement |

---

## 2. Typography

| Role | Family (site today) | Product guidance |
|------|---------------------|------------------|
| UI / body | Be Vietnam, Roboto | Prefer a single modern sans (Be Vietnam or system stack with Latin support) |
| Headings | Montserrat (Elementor primary) | Semibold/bold; navy or ink |
| Display / marketing | Same sans family | No decorative serif as brand |

Tone: technical confidence, laboratory precision. Prefer title case for Spanish
headings already used on the public site; do not invent an all-caps brand voice
except on short CTA labels (e.g. **DESCUBRE LO QUE HACEMOS**).

---

## 3. Surfaces & atmosphere

### Marketing / public (aligned with laboratoriosmyg.com)

1. Base **paper** / soft light blue-gray washes
2. Hero may use light cyan photographic / hexagonal product mosaics
3. Primary CTA: filled **brand** (`#017EA0`), white label, generous padding,
   rounded (~10–16px on marketing; `rounded-lg` ~8px in dense apps)

### Authenticated app shell (portal / internal)

Dense operate UIs MUST use:

1. Persistent chrome (sidebar or topbar) in **navy** / **ink**
2. **Mist** main workspace + sticky top bar
3. Same tokens/CTAs as §1–§4

### Alternating marketing surfaces

- Light blocks: `bg-paper` / `bg-mist` + `text-ink` / `text-navy`
- Dark blocks: `bg-ink` or `bg-navy` + light text + **brand** / **brand-bright** accents
- Do not invent a third brand palette

---

## 4. Components (shared)

### Primary CTA

```
inline-flex min-h-11 items-center justify-center
rounded-lg bg-brand px-6 py-3
text-sm font-semibold text-paper
transition hover:bg-brand-deep
```

### Secondary CTA (on paper)

```
inline-flex min-h-11 items-center justify-center
rounded-lg border border-brand/40 px-6 py-3
text-sm font-semibold text-brand
transition hover:border-brand hover:bg-brand/10
```

### Radius & hit targets

- Default control radius: `rounded-lg` (~8px); marketing CTAs MAY be rounder
- Minimum tap height: `min-h-11` (44px)

### Cards

Prefer **no decorative cards**. Use bordered/shadowed containers only when they
hold interaction or dense data.

### Responsive

All Labs MYG web surfaces MUST be responsive (phone → tablet → desktop). Core
flows usable without a desktop-only layout.

---

## 5. Logo lockups (locked)

| Asset (under `docs/brand/`) | Use |
|-----------------------------|-----|
| `logo-myg-hq-transparent.png` | Full lockup on **dark** chrome (transparent; cyan + silver + slogan) |
| `logo-myg-on-light-transparent.png` | Full lockup on **light** / paper |
| `logo_myg_150x110.png` | Compact mark (header / favicon source candidate) |
| `logo-myg-hq.png` / `.jpg` | Master raster sources (edit here; regenerate derivatives) |
| `preview-*.png` | Review aids only — **not** runtime chrome |

### Lockup geometry

| Rule | Value |
|------|--------|
| Order | Measuring-tape mark **above** (or left of, when compact) the wordmark |
| Wordmark | “Laboratorios” (steel/ink) + “M&G S.A.S” (brand cyan gradient) |
| Slogan | Optional white/ink line under separator — do not retypeset in a new font |
| Forbidden | Recolor tape to gold/purple; crop slogan into a second competing logo; use kitchen sketches as chrome |

Until a public CDN exists, apps MAY load from this git path in docs or copy
approved binaries into an app `public/brand/` **only** as a temporary mirror of
these files — do not invent alternate artwork.

---

## 6. Voice (short)

- Spanish by default for user-facing copy
- Precise, professional, laboratory / quality assurance tone
- Prefer “pruebas”, “ensayos”, “acreditación” vocabulary from the public site
- Do not brand UI with “IA/AI/Gemini” in customer-facing chrome (constitution)

---

## 7. Adoption checklist

| Surface | Must |
|---------|------|
| `labsmyg-core-front` | Import `brand-tokens.css`; CTAs/focus use `brand`; logos from kit |
| `labsmyg-idm` | Keycloak login theme uses brand + navy/paper |
| `labsmyg-notifications` | Email chrome uses kit colors + light lockup |
| `labsmyg-core-api` | Owns this doc + binaries; transactional HTML consumers follow kit |
| Agents / ops UIs | Same tokens if user-facing |

---

## 8. Anti-patterns

- Mandado gold/ink palette reused “because the stack is the same”
- Purple-on-white AI SaaS defaults
- Cream background + terracotta serif newspaper look
- Reconstructing the tape mark from emoji or SVG approximations when a PNG exists
- Small cyan body text on cyan backgrounds (contrast failure)
