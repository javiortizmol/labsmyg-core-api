# Feature Specification: Migración y convivencia con sistemas PHP

**Feature Branch**: `021-migration-coexistence`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 0 diagnóstico; cargas por fase (blueprint §13)
**Fuente**: `docs/blueprint-plataforma-laboratorios-mg.md` (Blueprint Laboratorios M&G).
**Idioma**: spec funcional en español. Código/API en inglés.
**Dominios**: ver constitution Product **I** de `labsmyg-core-api` — no inventar dominios.

## User Scenarios & Testing

### User Story 1 - Diagnóstico fase 0 (Priority: P1)

Tras NDA: acceso lectura a código/DB actuales, inventario de tablas, calidad de datos, plan de carga.

### User Story 2 - Corte por laboratorio (Priority: P1)

Piloto primero; sin doble digitación; órdenes abiertas migran; cerradas como histórico.

## Requirements

- **FR-001**: Spec y runbooks de migración viven en este repo (tools/scripts), no inventan un dominio.
- **FR-002**: Cargas: clientes (fase 1), catálogo/precios (1–2), ingreso absorbido (1–2), metrología (fase 4), SharePoint informes (fase 4), usuarios → Keycloak (fase 1).
- **FR-003**: Validación: conteos, muestreo, aprobación firmada antes de cada corte.
- **FR-004**: Job de sync de convivencia mientras dure (011), solo lectura del origen.

## Related

005 · 006 · 007 · 012 · idm 002 · iac
