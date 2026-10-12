# Feature Specification: Idempotencia en creaciones críticas

**Feature Branch**: `022-endpoint-idempotency`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 1 (transversal; patrón Mandado 002)
**Fuente**: `docs/blueprint-plataforma-laboratorios-mg.md` (Blueprint Laboratorios M&G).
**Idioma**: spec funcional en español. Código/API en inglés.
**Dominios**: ver constitution Product **I** de `labsmyg-core-api` — no inventar dominios.

## User Scenarios & Testing

### User Story 1 - Reintento seguro (Priority: P1)

Creaciones críticas (órdenes, aceptaciones, pagos, envíos COM) aceptan `Idempotency-Key`; el mismo key no duplica.

## Requirements

- **FR-001**: Soporte transversal en shared para claves de idempotencia.
- **FR-002**: Obligatorio en aceptaciones (009), altas de orden/muestra críticas, comandos de envío.
- **FR-003**: Respuesta replay del primer resultado exitoso.

## Related

002 Mandado pattern · 007 · 009 · 008
