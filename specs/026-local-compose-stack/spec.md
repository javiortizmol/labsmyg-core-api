# Feature Specification: Local Docker Compose stack

**Feature Branch**: `026-local-compose-stack`
**Created**: 2026-10-12
**Status**: Aprobada (dev tooling)
**Fase**: Fase 0 — andamiaje local
**Fuente**: Blueprint (MySQL, S3/EventBridge local vía Floci); `024-local-floci`; ER `025`.
**Idioma**: spec funcional en español. Compose/env en inglés.

## User Scenarios & Testing

### User Story 1 - Stack local con un comando (Priority: P1)

Desarrollador ejecuta `make up` y obtiene MySQL (app + audit) lista; Floci opcional con perfil.

**Independent Test**: `make up` → ping a `labsmyg` y `labsmyg_audit` en el puerto host.

### User Story 2 - Schemas alineados al ER (Priority: P1)

Dos databases lógicas en el mismo servidor: `labsmyg` (negocio) y `labsmyg_audit` (solo auditoría).

### User Story 3 - Parar y resetear (Priority: P2)

`make down` detiene; `make reset` borra volúmenes.

## Requirements

- **FR-001**: `docker-compose.yml` con servicio `mysql` (MySQL 8.4, healthcheck) e init que crea `labsmyg` + `labsmyg_audit`.
- **FR-002**: Floci sigue en profile `aws-emulator` (`024`).
- **FR-003**: `.env.example` con `DATABASE_URL`, `AUDIT_DATABASE_URL`, puertos, Floci.
- **FR-004**: Makefile: `up`, `up-aws`, `down`, `logs`, `ps`, `reset` (+ floci-* existentes).
- **FR-005**: Docs `docs/local-compose.md`.
- **FR-006**: API container deferred until `001` health exists; compose documents future `api` service.
- **FR-007**: `make quality` no requiere Docker.

## Success Criteria

- **SC-001**: `make up` deja MySQL healthy en &lt; 60 s (Docker/Colima up).
- **SC-002**: Conexión a ambos databases con el usuario de app.

## Related

024 · 025 · 001 · 003 · idm (Keycloak externo / futuro)
