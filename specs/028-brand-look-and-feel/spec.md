# Feature Specification: Brand look & feel (transversal)

**Feature Branch**: `028-brand-look-and-feel`  
**Created**: 2026-10-12  
**Status**: Active (convention)  
**Scope**: All Labs MYG user-facing repos (API docs/brand SoT, front, IdM, notifications; agents when UI-facing)  
**Related**: Mandado pattern `mandado-landing/brand/look-and-feel.md`; public site [laboratoriosmyg.com](https://laboratoriosmyg.com/)  
**Input**: Lock a single brand kit (palette, type, lockups, CTAs) extracted from the public site and official logos already under `docs/brand/`.

## Problem

Without a shared kit, each app invents cyan/blue hexes or inherits Mandado gold
tokens. Logos already live in `docs/brand/` but have no locked roles or CSS
contract for portal, IdM, and email.

## Goals

1. One **look-and-feel** document as cross-app SoT under `docs/brand/`.
2. Locked CSS token names + hex values for product UI.
3. Locked logo asset roles (dark lockup, light lockup, compact mark).
4. Constitutions and Cursor rules in sibling repos point at the SoT.
5. Front ships `brand-tokens.css` that implements the variables.

## Non-goals

- Redesigning the public WordPress site.
- Publishing a CDN/S3 brand bucket (MAY follow later, Mandado `027` style).
- Full component library / Storybook.
- Replacing domain Spanish copy with a new brand voice guide.

## Locked — Display & domain

| Layer | Value |
|-------|--------|
| Short display | Laboratorios MYG |
| Lockup / legal | Laboratorios M&G S.A.S |
| Domain | laboratoriosmyg.com |
| Slogan | Porque siempre es mejor, Probar! |

## Locked — Color tokens

| Token | Hex |
|-------|-----|
| `brand` | `#017EA0` |
| `brand-bright` | `#00CCEC` |
| `brand-deep` | `#005080` |
| `navy` | `#012C47` |
| `ink` | `#181B31` |
| `steel` | `#C0C0C0` |
| `muted` | `#808291` |
| `secondary` | `#5684EC` |
| `mist` | `#F5F7FA` |
| `paper` | `#FFFFFF` |

Full contrast/focus rules: `docs/brand/look-and-feel.md`.

## Locked — Logo roles

| Asset | Surface |
|-------|---------|
| `logo-myg-hq-transparent.png` | Dark chrome |
| `logo-myg-on-light-transparent.png` | Light / paper |
| `logo_myg_150x110.png` | Compact / favicon source |

MUST NOT reconstruct the measuring-tape lockup from unrelated artwork.

## User Scenarios & Testing

### User Story 1 - Agent / developer finds the kit (Priority: P1)

Someone building UI opens the SoT and uses the same hex tokens.

**Acceptance Scenarios**:

1. **Given** `docs/brand/look-and-feel.md`, **When** a plan touches UI chrome, **Then** Product Conflict Check cites the brand kit and does not invent new primaries.
2. **Given** front `brand-tokens.css`, **When** a CTA is styled, **Then** it uses `--color-brand` / `--color-brand-deep`.

### User Story 2 - Correct lockup on light and dark (Priority: P1)

Chrome shows the approved PNG for the surface.

**Acceptance Scenarios**:

1. **Given** a dark header, **When** the logo renders, **Then** it uses the dark-transparent lockup (or compact mark), not a recolored light asset.
2. **Given** email/paper, **When** the logo renders, **Then** it uses the light-transparent lockup.

### Edge Cases

- Preview PNGs under `docs/brand/preview-*` MUST NOT ship as runtime logos.
- WhatsApp green is channel-only, not a brand primary.

## Requirements

### Functional

- **FR-001**: `docs/brand/look-and-feel.md` is the SoT for palette, type, lockups, CTAs.
- **FR-002**: Front exposes CSS variables matching the locked table.
- **FR-003**: Sibling constitutions (front, IdM, notifications, agents) MUST require alignment to the kit.
- **FR-004**: Cursor `brand-look-and-feel` rules point every repo at the SoT.
- **FR-005**: Product Conflict Check includes a brand/vocabulary row referencing this kit.

### Non-functional

- **NFR-001**: Docs-only change; no coverage gate impact beyond front token file if tested later.
- **NFR-002**: Honest green — do not weaken contrast rules to fit arbitrary mock colors.

## Success Criteria

- **SC-001**: A new UI surface can copy tokens from the kit without scraping the WordPress theme.
- **SC-002**: No Mandado gold/ink tokens appear as Labs MYG brand primaries in front/IdM/email docs after adoption.
