# Tasks: API Bootstrap

**Input**: `specs/001-api-bootstrap/spec.md` y plan.md
**Prerequisites**: spec en estado Aprobada antes de implementar (blueprint §15).
**Tests**: las historias con código llevan pruebas automáticas. No se debilitan para verlas en verde.

- [ ] T001 [US1] App FastAPI, config, correlación, CORS y security headers
- [ ] T002 [US1] GET /v1/health sin auth
- [ ] T003 [US2] Paquetes de exactamente los 7 dominios de la constitution (platform, customers, catalog, samples, laboratory, reports, communications) + shared + workers — sin un octavo dominio
- [ ] T004 [US2] JWT JWKS (audiencia labsmyg-api) y GET /v1/me
- [ ] T005 [US2] Errores Problem Details en español
- [ ] T006 Alembic + Compose MySQL/MariaDB
- [ ] T007 Prueba de arquitectura de imports entre dominios
- [ ] T008 OpenAPI en desarrollo; apagado en producción
- [ ] T009 Enganche Ruff/mypy/pytest/audit a pipe-templates
