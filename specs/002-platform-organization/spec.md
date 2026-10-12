# Feature Specification: Organización, configuración y numeración

**Feature Branch**: `002-platform-organization`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 1 — Plataforma
**Fuente**: Blueprint «Plataforma de gestión de Laboratorios M&G», octubre 2026, versión preliminar. Se cierra al final de la fase 0.
**Idioma**: spec funcional en español. Código, API, tablas, eventos y docs técnicas en inglés.

## User Scenarios & Testing

### User Story 1 - Empresa, sedes y laboratorios (Priority: P1)

Administrador registra empresa legal, sedes y laboratorios con país, moneda, zona horaria e idioma, sin redeploy.

**Independent Test**: Crear empresa, dos sedes y un laboratorio en ambas.

### User Story 2 - Números únicos (Priority: P1)

Cualquier dominio pide un número (cotización, orden, muestra, ensayo, informe, COM, recepción) y recibe el siguiente de una secuencia global, concurrente e independiente de sede.

**Independent Test**: Dos peticiones concurrentes → valores distintos.

### User Story 3 - Parámetros operativos (Priority: P2)

Ajustar plazos y políticas (sesión 8h, inactividad 60 días) desde datos.

## Requirements

- **FR-001**: Modelo Empresa › Sedes › Laboratorios.
- **FR-002**: Config por sede: país, moneda, impuestos, TZ, idioma, ubicaciones de contramuestras; facturador/firma/acreditación como config aunque adaptadores lleguen en fase 4.
- **FR-003**: Laboratorio puede operar en una/varias/todas las sedes.
- **FR-004**: Numeración configurable, única en todo M&G, segura ante concurrencia. Facturas se numeran por empresa (fase 4).
- **FR-005**: UUID técnico distinto del código legible.
- **FR-006**: Settings con defaults (inactividad 60 días, sesión 8h, alerta firmante 1 día hábil).
- **FR-007**: Escrituras pasan por caso de uso + auditoría (`003`).

## Pending

Laboratorio piloto · formato código de muestra · sedes en otros países.

## Related

003-audit-trail · 004-authorization · front 002-platform-admin-ui
