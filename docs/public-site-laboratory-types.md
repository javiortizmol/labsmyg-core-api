# Public site → laboratory types (analysis note)

**Source**: [laboratoriosmyg.com](https://laboratoriosmyg.com/) (fetched 2026-10-12)  
**Consumes**: api `002-platform-organization` (`laboratory_type` seed)

## What the site is

Marketing / institutional WordPress (Elementor) site for **Laboratorios MYG**
(legal **Laboratorios M&G S.A.S**). Not the product backoffice. Brand kit for
apps already extracted in `docs/brand/look-and-feel.md` (spec `028`).

## Org / contact (public)

| Item | Value |
|------|--------|
| Address | Calle 65A Nº 74 – 54, Bogotá, Colombia |
| PBX | (+57) 601 3004756 |
| Mobile | (+57) 310 806 6036 · (+57) 315 086 4957 |
| Email | gerencia@… · servicioalcliente@laboratoriosmyg.com |
| Positioning | Multi-lab testing + accreditation; ~15 years; slogan line *¿Por qué siempre es mejor probar?* |

## Laboratory types (menu «Laboratorios»)

These are the **business laboratory kinds** M&G advertises — map 1:1 to
`laboratory_type` seed in `002` (not “tipo de ensayo”):

1. Juguetes  
2. Fisicoquímica  
3. Microbiología  
4. Alimentos  
5. Textil  
6. Vehículos  
7. Plásticos, Cauchos y Cuero  
8. Cascos  
9. Eléctrico  
10. Calibración  

«Nuestras soluciones» lists the same areas (Alimentos, Eléctrica-Electrónica,
Fisicoquímica, Juguetes, Microbiología, Plásticos/Cauchos/Cueros, Textiles,
Vehículos-Carrocerías, Calibración en Presión). Cascos appears in the nav
even when not always repeated in the solutions blurb — keep as its own type
until ops says otherwise.

## Implications for the product

| Topic | Implication |
|-------|-------------|
| Platform model | Multi-type is **current state**, not future scale |
| Catalog / quotes | Prices, norms, signers often scoped by laboratory type/instance |
| Reception / samples | Sede + laboratory (type/instance) can differ per essay |
| Authz | Role × site × laboratory × test type (`004`) |
| Brand | Cyan/navy kit from this site → apps/IdM/email (`028`) |
| Portal | Public “Portal del cliente” / solicitud is marketing; product portal is separate (OTP) |

## Out of scope for this note

- Scraping WordPress content into the app  
- Recreating the marketing site  
- Inventing accreditation scope rows (see site Acreditaciones; catalog owns that later)
