# Tasks: Clientes, solicitudes y cotizaciones

**Input**: `specs/005-customers-quotes/spec.md` y plan.md
**Prerequisites**: spec en estado Aprobada antes de implementar (blueprint §15).
**Tests**: las historias con código llevan pruebas automáticas. No se debilitan para verlas en verde.

- [ ] T001 [US1] Modelo cliente/sede/contacto/documento
- [ ] T002 [US1] Búsqueda coincidencias + 409 NIT activo duplicado
- [ ] T003 [US2] Cotización con líneas congeladas
- [ ] T004 [US2] Aceptación idempotente vía 009 + regla por llegada de muestra
- [ ] T005 [US3] Solicitud de cambio que versiona cotización
- [ ] T006 Puertos a catalog y samples sin imports cruzados
