# Feature Specification: Migración y convivencia con sistemas PHP

**Feature Branch**: `021-migration-coexistence`
**Created**: 2026-10-12
**Status**: Draft — **bloqueada para diseño detallado** hasta inspección de origen (abajo). No bloquea el corte de specs MVP.
**Fase**: Fase 0 diagnóstico; cargas por fase (blueprint §13)
**Fuente**: `docs/blueprint-plataforma-laboratorios-mg.md` (Blueprint Laboratorios M&G).
**Idioma**: spec funcional en español. Código/API en inglés.
**Dominios**: ver constitution Product **I** de `labsmyg-core-api` — no inventar dominios.

## Positioning vs MVP

Plan **paralelo** al MVP: las specs de producto Fase 1 pueden cerrarse sin el ETL.
Este slice **no** se detalla ni se implementa hasta tener acceso/lectura al legado.

## Pending — inspección de origen (gate)

Hasta completar esto, no inventar mapeos de tablas ni scripts de carga:

| # | Qué inspeccionar | Para qué |
|---|------------------|----------|
| 1 | **Código PHP** actual (apps/módulos en uso) | Flujos reales, acoplamientos, qué se digita hoy |
| 2 | **Base de datos** de lo montado por ahora | Inventario de tablas, calidad, PKs/FKs, volumen |
| 3 | **Metrología** (equipos/calibraciones en legado) | Alcance fase 4; no forzar al MVP |

Salidas esperadas del diagnóstico: inventario tablas → entidades Labs MYG, gaps de calidad, orden de cargas, riesgos de convivencia.

## User Scenarios & Testing

### User Story 1 - Diagnóstico fase 0 (Priority: P1)

Tras NDA/acceso lectura: código PHP + DB montada + metrología legado → inventario, calidad de datos, plan de carga versionado. Sin eso, US2 y ETL quedan en espera.

### User Story 2 - Corte por laboratorio (Priority: P1)

Piloto primero; sin doble digitación; órdenes abiertas migran; cerradas como histórico. **Solo después** del diagnóstico.

## Requirements

- **FR-001**: Spec y runbooks de migración viven en este repo (tools/scripts), no inventan un dominio.
- **FR-002**: Cargas (tras diagnóstico): clientes (fase 1), catálogo/precios (1–2), ingreso absorbido (1–2), **metrología (fase 4 / post inspección)**, SharePoint informes (fase 4), usuarios → Keycloak (fase 1).
- **FR-003**: Validación: conteos, muestreo, aprobación firmada antes de cada corte.
- **FR-004**: Job de sync de convivencia mientras dure (`011`), solo lectura del origen.
- **FR-005**: No inventar esquema origen ni scripts hasta cerrar la inspección (código + DB + metrología).
- **FR-006**: No bloquea Aprobada de specs MVP de producto; sí bloquea implementación de migración.

## Related

005 · 006 · 007 · 012 · 015 · idm 002 · iac
