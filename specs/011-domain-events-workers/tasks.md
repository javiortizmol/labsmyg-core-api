# Tasks: Eventos de dominio, outbox y workers

**Input**: [spec.md](./spec.md) · [plan.md](./plan.md)

- [x] T000 Evaluation + reliability FRs (`docs/event-delivery-reliability.md`)
- [x] T000b Mark delivery/idempotency **transversal** (constitution, conflict gate, cursor rule, plan template)
- [x] T000c AGENTS.md + code-shape (spirit transversal; **limits by artifact type**)
- [ ] T001 [US1] Tabla outbox (event_id, attempts, next_retry) + publisher ACK-then-mark
- [ ] T002 [US2] Inbox `UNIQUE (consumer_id, event_id)` + consumidor ejemplo
- [ ] T003 [US2] Descarte por `aggregate_version` atrasada
- [ ] T004 [US3] Tabla vencimientos + runner con lease
- [ ] T005 Job no concretada + verificación cadena auditoría
- [ ] T006 Tests: crash post-commit, reentrega, dual-write ausente
- [ ] T007 Command outbox hacia cola notifications (Q-04)
- [ ] T008 DLQ + archive wiring notes (iac Q-01/Q-03)
