# Tasks: Brand look & feel (transversal)

**Input**: Design documents from `/specs/028-brand-look-and-feel/`  
**Prerequisites**: plan.md, spec.md  

**Tests**: Docs/chore — no mandatory automated tests. Front token file is the
implementation artifact.

## Phase 1 — SoT

- [x] T001 Write `docs/brand/look-and-feel.md` with locked tokens + lockup roles
- [x] T002 Write `docs/brand/README.md` asset index
- [x] T003 Write `specs/028-brand-look-and-feel/{spec,plan,tasks}.md`

## Phase 2 — Front tokens

- [x] T004 Add `labsmyg-core-front/src/styles/brand-tokens.css` with CSS variables
- [x] T005 Point front constitution + Cursor brand rule at core-api SoT
- [x] T006 Brand pointer in front constitution (`I-c`) — no separate companion spec needed

## Phase 3 — Sibling mandatories

- [x] T007 Cursor `brand-look-and-feel.mdc` + constitution pointer in `labsmyg-idm`
- [x] T008 Same for `labsmyg-notifications`
- [x] T009 Same for `labsmyg-agents`
- [x] T010 Same for `labsmyg-core-api` (rule + constitution Brand theme)
- [x] T011 Product Conflict Gate brand row in alwaysApply rules (repos touched)

## Phase 4 — Active feature

- [x] T012 Point `.specify/feature.json` at `specs/028-brand-look-and-feel`
