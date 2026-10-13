# Feature Specification: Eventos de dominio, outbox y workers

**Feature Branch**: `011-domain-events-workers`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 1 base; tareas programadas crecen por fase
**Fuente**: Blueprint §6–§7; evaluación [`docs/event-delivery-reliability.md`](../../docs/event-delivery-reliability.md).
**Alcance**: **Transversal** — aplica a **toda solución generada** (cualquier
dominio, worker, comando a notifications, jobs). No es un feature opcional
por módulo.
**Idioma**: spec funcional en español. Código, API, tablas, eventos y docs técnicas en inglés.

## User Scenarios & Testing

### User Story 1 - Outbox transaccional (Priority: P1)

Al cambiar estado, el dominio escribe el evento (o comando de envío) en outbox
**en la misma transacción** que el agregado y la auditoría. Un publicador lo
envía a EventBridge o a la cola de comando. Si el proceso muere tras el
commit, el evento **no se pierde**.

**Independent Test**: Simular crash post-commit: fila `pending` se publica; no
hay `PutEvents` en el request HTTP.

### User Story 2 - Consumidores idempotentes (Priority: P1)

Cada consumidor tiene cola SQS + DLQ. Procesar dos veces el mismo `event_id`
no duplica efectos. Eventos atrasados (versión ≤ aplicada) se descartan
sin error de negocio.

**Independent Test**: Reentregar el mismo mensaje → inbox unique, un solo
efecto; versión vieja no pisa estado.

### User Story 3 - Vencimientos y tareas (Priority: P2)

Tabla de vencimientos revisada periódicamente (no miles de schedules AWS).
Jobs con **lease** (no dos runners a la vez), idempotentes, visibles y
reejecutables desde backoffice.

### User Story 4 - No se pierde una transacción de negocio (Priority: P1)

Compromiso: escritura confirmada ⇒ outbox durable ⇒ reintento hasta ACK o
DLQ alarmada. No hay drop silencioso. Replay desde archivo del bus / outbox /
DLQ. Duplicados se toleran (at-least-once); **no** se promete exactly-once
del broker.

## Requirements

- **FR-001**: Outbox (evento de dominio o comando) en la **misma** transacción
  MySQL que el cambio de estado y el audit append.
- **FR-002**: Bus EventBridge propio; regla por consumidor → SQS + DLQ;
  archivo (archive) del bus para replay.
- **FR-003**: Cada mensaje lleva `event_id` estable (UUID = id de outbox),
  `event_type`, `occurred_at`, `aggregate_type`, `aggregate_id`,
  `aggregate_version`, schema version. Esquema documentado.
- **FR-004**: No event sourcing completo: estado en DB, historial en auditoría.
- **FR-005**: Vencimientos en tabla; scheduler periódico; lock/lease por job.
- **FR-006**: Primera ola: no concretada, copia auditoría a S3 (cuando iac
  listo), recordatorios básicos.
- **FR-007**: **MUST NOT** publicar al bus ni a SQS desde el use case HTTP
  (dual-write prohibido). Solo el publisher lee `pending`.
- **FR-008**: Publisher marca `published` **solo tras ACK** del broker. Fallo
  o crash tras ACK y antes de marcar ⇒ reenvío (consumidor idempotente).
- **FR-009**: Reintentos con backoff; `attempts` / `last_error` / `next_retry`;
  **MUST NOT** borrar ni ignorar filas failed sin DLQ/ops.
- **FR-010**: Consumidor: tabla inbox `UNIQUE (consumer_id, event_id)`;
  duplicado = ACK sin segundo efecto (efecto-una-vez).
- **FR-011**: Entrega **at-least-once**. Exactly-once del bus está fuera de
  alcance. “No perder transacción” = commit+outbox+retry+DLQ+replay.
- **FR-012**: Comandos a `labsmyg-notifications` usan el mismo patrón
  (command outbox → SQS Q-04), no `SendMessage` antes del commit.
- **FR-013**: Visibility timeout de cada cola ≥ tiempo de trabajo p95 +
  margen; extender si el trabajo es largo.
- **FR-014**: DLQ con alarma; runbook de replay (DLQ, archive, outbox
  `pending`/`failed`).
- **FR-015**: `022` (`Idempotency-Key` HTTP) cubre reintento de usuario; **no**
  sustituye inbox ni outbox.
- **FR-016**: Outbox/inbox/DLQ son **transversales**: todo spec/plan nuevo que
  escriba o publique **MUST** reutilizarlos (Conflict Check «Delivery /
  idempotency»). N/A solo si no hay write ni mensaje.

## Assumptions

EventBridge no garantiza orden global; el consumidor usa `aggregate_version`.
Notifications y agents-runtime aplican inbox/outbox en **su** base para
eventos que ellos emiten (p. ej. resultado de envío).

## Success Criteria

- **SC-001**: Crash post-commit no pierde el evento (publisher lo reenvía).
- **SC-002**: Reentrega no duplica COM / aviso / transición.
- **SC-003**: Dual-write ausente en tests de contrato del publisher.
- **SC-004**: DLQ + archive definidos con iac (`Q-01`, `Q-03`, `Q-04`).

## Related

008 · 003 · 022 · 025 · iac `002` / inventario Q-* · notifications `001`/`006`  
Eval: [`docs/event-delivery-reliability.md`](../../docs/event-delivery-reliability.md)  
ER: [`docs/domain-er-model.md`](../../docs/domain-er-model.md)
