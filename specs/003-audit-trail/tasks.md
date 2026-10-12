# Tasks: Auditoría encadenada y borrado lógico

**Input**: `specs/003-audit-trail/spec.md` y plan.md
**Prerequisites**: spec en estado Aprobada antes de implementar (blueprint §15).
**Tests**: las historias con código llevan pruebas automáticas. No se debilitan para verlas en verde.

- [ ] T001 [US1] Tabla audit_records + puerto AuditWriter
- [ ] T002 [US2] Hash encadenado + verificador
- [ ] T003 [US4] Mixin lifecycle y unicidad entre activos
- [ ] T004 [US3] GET /v1/audit-records + export CSV
- [ ] T005 Integrar patrón en primer caso de uso de platform
