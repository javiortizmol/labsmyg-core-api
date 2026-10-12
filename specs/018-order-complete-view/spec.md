# Feature Specification: Vista completa de la orden

**Feature Branch**: `018-order-complete-view`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 1 mínimo; se enriquece por fase
**Fuente**: `docs/blueprint-plataforma-laboratorios-mg.md` (Blueprint Laboratorios M&G).
**Idioma**: spec funcional en español. Código/API en inglés.
**Dominios**: ver constitution Product **I** de `labsmyg-core-api` — no inventar dominios.

## User Scenarios & Testing

### User Story 1 - Una pantalla / un recurso de orden (Priority: P1)

Consultar la orden con su estado, cotización vinculada, muestras/recepciones, comunicaciones COM y permisos de lo que el rol puede ver (analista: sin cliente).

## Requirements

- **FR-001**: Recurso de lectura agregado owned by **samples** (order), ensamblando proyecciones de otros dominios vía application services — sin joins ilegales a infrastructure ajena.
- **FR-002**: Proyección distinta por rol (constitution I-a).
- **FR-003**: Debe ser el destino de las listas de pendientes y de la ficha de cliente.

## Related

007 · 005 · 008 · 016 · front 011
