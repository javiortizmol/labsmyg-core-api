# Implementation Plan: Brand look & feel (transversal)

**Branch**: `028-brand-look-and-feel` | **Date**: 2026-10-12 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `/specs/028-brand-look-and-feel/spec.md`

## Summary

Lock Laboratorios M&G visual language from laboratoriosmyg.com + official logos
into `docs/brand/look-and-feel.md`, wire CSS tokens in the front, and make
sibling constitutions/Cursor rules point at that SoT (Mandado-style transversal kit).

## Technical Context

**Language/Version**: Markdown SoT + CSS variables (front Node 26)  
**Primary Dependencies**: Existing `docs/brand/*` PNG lockups  
**Storage**: N/A (git binaries)  
**Testing**: Docs/chore; front token file MAY be smoke-imported later  
**Target Platform**: All Labs MYG user-facing surfaces  
**Project Type**: Cross-repo design contract  
**Constraints**: No second palette; no Mandado gold inheritance  
**Scale/Scope**: API docs + front tokens + IdM/notifications/agents pointers

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Gate | Status | Notes |
|------|--------|-------|
| Speckit trail | Pass | New `028` slice; active feature for this change |
| Seven domains | N/A | Brand is transversal, not an 8th domain |
| English source / ES UI | Pass | Doc bilingual headings OK; token names English |
| Quality | Pass | Docs + CSS tokens; no honest-green shortcuts |

## Product Conflict Check

*GATE: Must pass before tasks/implement.*

| Conflict area | Check | Status | Notes / resolution |
|---------------|-------|--------|--------------------|
| Constitution | No principle diluted | Pass | Ownership of kit in core-api docs; siblings MUST follow |
| Vocabulary | Display Laboratorios MYG / M&G S.A.S vs domain | Pass | Locked in look-and-feel |
| Ownership | Kit SoT in `labsmyg-core-api/docs/brand` | Pass | No landing repo yet (unlike Mandado landing) |
| Auth / roles | N/A for palette | N/A | IdM theme follows kit colors only |
| Application security | N/A | N/A | |
| Cross-feature FR/SC | No contradiction with UI specs | Pass | Front specs consume kit going forward |
| Sibling repos | Front/IdM/notifications/agents get pointers | Pass | Tasks update constitutions + rules |
| Quality / TDD | Docs-only + CSS tokens | Pass | |
| Brand / look-and-feel | This feature **is** the kit | Pass | |
| Breaking UX / API | None | Pass | Additive |

**Related specs reviewed**: front UI specs `001`–`010` (consume kit later); Mandado landing brand pattern (reference only)

**Unresolved conflicts**: none

## Project Structure

### Documentation (this feature)

```text
specs/028-brand-look-and-feel/
├── plan.md
├── spec.md
└── tasks.md
docs/brand/
├── look-and-feel.md
├── README.md
└── (existing logo binaries)
```

### Source Code

```text
labsmyg-core-front/src/styles/brand-tokens.css
*/.cursor/rules/brand-look-and-feel.mdc
*/.specify/memory/constitution.md  # brand pointer
```

## Complexity Tracking

| Decision | Why |
|----------|-----|
| SoT in core-api `docs/brand` (not a landing repo) | No Labs MYG marketing repo yet; logos already live here |
| Bright cyan + brand teal both locked | Logo tape ≠ Elementor primary CTA; both appear on the public brand |
