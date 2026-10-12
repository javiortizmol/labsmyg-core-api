# Tasks: Eventos de dominio, outbox y workers

**Input**: `specs/011-domain-events-workers/spec.md` y plan.md
**Prerequisites**: spec en estado Aprobada antes de implementar (blueprint §15).
**Tests**: las historias con código llevan pruebas automáticas. No se debilitan para verlas en verde.

- [ ] T001 [US1] Tabla outbox + publisher
- [ ] T002 [US2] Consumidor ejemplo (avisos) idempotente
- [ ] T003 [US2] Descarte por versión atrasada
- [ ] T004 [US3] Tabla vencimientos + runner
- [ ] T005 Job no concretada + verificación cadena auditoría
