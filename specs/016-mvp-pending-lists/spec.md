# Feature Specification: Listas básicas de pendientes (MVP analítica)

**Feature Branch**: `016-mvp-pending-lists`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 1 — MVP (blueprint §3 Analítica + fase 1)
**Fuente**: `docs/blueprint-plataforma-laboratorios-mg.md` (Blueprint Laboratorios M&G).
**Idioma**: spec funcional en español. Código/API en inglés.
**Dominios**: ver constitution Product **I** de `labsmyg-core-api` — no inventar dominios.

## User Scenarios & Testing

### User Story 1 - Vencido / para hoy / próximo (Priority: P1)

Cada rol ve listas de solo lectura: órdenes vencidas, para hoy y próximas (default 3 días), filtradas por sede/laboratorio/permisos. Desde una fila abre la vista de la orden.

**Why this priority**: El hito MVP exige listas básicas de pendientes, no el tablero completo.

**Independent Test**: Con órdenes de prueba en tres estados temporales, cada lista muestra solo las que corresponden.

## Requirements

- **FR-001**: Capacidad de **analítica de solo lectura** — MUST NOT ser un octavo dominio ni escribir estado de negocio.
- **FR-002**: Bandejas MVP: `overdue`, `due_today`, `due_soon` a nivel de **orden**.
- **FR-003**: Filtro por sede activa, laboratorio y permisos del usuario.
- **FR-004**: Conteos simples; sin gráficos ni KPIs de gestión (fase 2/4/5).
- **FR-005**: Leer de la base operativa al inicio; réplica de lectura cuando iac la provea.

## Related

015 · 018-order-complete-view · front 010-mvp-pending-lists-ui
