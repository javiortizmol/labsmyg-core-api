# Feature Specification: Firmantes por laboratorio y tipo de ensayo

**Feature Branch**: `017-platform-signers`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 1 (config); uso en firma fase 4
**Fuente**: `docs/blueprint-plataforma-laboratorios-mg.md` (Blueprint Laboratorios M&G).
**Idioma**: spec funcional en español. Código/API en inglés.
**Dominios**: ver constitution Product **I** de `labsmyg-core-api` — no inventar dominios.

## User Scenarios & Testing

### User Story 1 - Designar firmante (Priority: P1)

Gerencia designa y retira firmantes por laboratorio o tipo de ensayo. Default: gerencia general. Alerta un día hábil antes (configurable).

## Requirements

- **FR-001**: Entidad signer assignment en **platform** (no en reports hasta emitir).
- **FR-002**: Gerencia puede firmar cualquier informe (regla de autorización).
- **FR-003**: Historial de designación auditado.
- **FR-004**: Quien ejecutó el ensayo no firma su propio informe (constitution / 004).

## Related

002 · 004 · 013
