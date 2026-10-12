# Feature Specification: Eventos de dominio, outbox y workers

**Feature Branch**: `011-domain-events-workers`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 1 base; tareas programadas crecen por fase
**Fuente**: Blueprint «Plataforma de gestión de Laboratorios M&G», octubre 2026, versión preliminar. Se cierra al final de la fase 0.
**Idioma**: spec funcional en español. Código, API, tablas, eventos y docs técnicas en inglés.

## User Scenarios & Testing

### User Story 1 - Outbox transaccional (Priority: P1)

Al cambiar estado, el dominio escribe el evento en outbox en la misma transacción; un publicador lo envía a EventBridge.

### User Story 2 - Consumidores idempotentes (Priority: P1)

Cada consumidor tiene cola SQS; procesar dos veces no duplica efectos; eventos atrasados se descartan por versión.

### User Story 3 - Vencimientos y tareas (Priority: P2)

Tabla de vencimientos revisada periódicamente (no miles de schedules AWS). Jobs idempotentes, visibles y reejecutables desde backoffice.

## Requirements

- **FR-001**: Outbox en misma transacción que el cambio de estado.
- **FR-002**: Bus EventBridge propio; regla por consumidor → SQS + DLQ.
- **FR-003**: Eventos versionados e idempotentes; esquema documentado.
- **FR-004**: No event sourcing completo: estado en DB, historial en auditoría.
- **FR-005**: Vencimientos en tabla; scheduler periódico.
- **FR-006**: Primera ola: no concretada, copia auditoría a S3 (cuando iac listo), recordatorios básicos.

## Related

008 · 003 · iac EventBridge/SQS · workers en este repo  
ER: [`docs/domain-er-model.md`](../../docs/domain-er-model.md) (outbox_message) · `025-domain-er-model`
