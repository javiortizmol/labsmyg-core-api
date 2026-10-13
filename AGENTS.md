# Labs MYG Core API — agent entry

Cursor loads this file and `.cursor/rules/*.mdc` (`alwaysApply`). You do **not**
need the user to run `/speckit-*`.

## SDD (mandatory)

1. Read `.specify/memory/constitution.md`.
2. Resolve `.specify/feature.json` → `specs/<feature>/`.
3. specify → plan (**Product Conflict Check**) → tasks → implement.
4. Playbooks: `.cursor/skills/speckit-*/SKILL.md`.
5. Harness: `.cursor/rules/speckit-harness.mdc`.

## Transversal (every generated solution)

- Delivery / idempotency: `docs/event-delivery-reliability.md` + spec `011`.
- Brand (if UI-adjacent copy): `docs/brand/look-and-feel.md`.
- **Code shape**: spirit is transversal; **limits by type** (`docs/code-shape.md`).
  This repo = Python 350/50. Front/agents use their own table.

## Quality

`make quality` before claiming done. Do not weaken tests to go green.
