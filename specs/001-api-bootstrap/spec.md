# Feature Specification: API Bootstrap

**Feature Branch**: `001-api-bootstrap`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 1 — andamiaje (adelantable en fase 0)
**Fuente**: Blueprint «Plataforma de gestión de Laboratorios M&G», octubre 2026, versión preliminar. Se cierra al final de la fase 0.
**Idioma**: spec funcional en español. Código, API, tablas, eventos y docs técnicas en inglés.

## User Scenarios & Testing

### User Story 1 - Salud del servicio (Priority: P1)

Operaciones consulta si la API responde, sin autenticación.

**Why this priority**: Sin un servicio arrancable no hay MVP.

**Independent Test**: `GET /v1/health` responde 200 sin token.

**Acceptance Scenarios**:

1. **Given** la API en marcha, **When** se consulta `/v1/health`, **Then** responde 200 sin auth.
2. **Given** la base inalcanzable, **When** se consulta la salud, **Then** reporta no listo sin secretos ni trazas.

### User Story 2 - Dominios vacíos y autenticación (Priority: P1)

Con token Keycloak se llama `GET /v1/me` y se reciben sujeto y roles. Los siete dominios existen como paquetes.

**Why this priority**: Fija fronteras, OpenAPI y auth antes de crecer cada dominio.

**Independent Test**: JWT con audiencia `labsmyg-api` y `sub` → 200; sin token o audiencia incorrecta → 401.

**Acceptance Scenarios**:

1. **Given** token válido del realm `myg`, **When** `GET /v1/me`, **Then** incluye `sub` y roles.
2. **Given** token sin `sub` u otra audiencia, **When** recurso protegido, **Then** 401.
3. **Given** OpenAPI en desarrollo, **When** se genera el cliente front, **Then** describe `/v1` y el formato de error.

### Edge Cases

- `AUTH_DISABLED` solo en pruebas locales, nunca en producción.
- Un dominio no importa el interior de otro (prueba de arquitectura).
- `/docs` en desarrollo; apagado en producción.

## Requirements

- **FR-001**: Prefijo `/v1` (el host ya es la API).
- **FR-002**: Paquetes `app/domains/{platform,customers,catalog,samples,laboratory,reports,communications}` con `api/application/domain/infrastructure`, más `shared` y `workers`.
- **FR-003**: JWT vía JWKS Keycloak; `sub` no vacío; audiencia `labsmyg-api`.
- **FR-004**: CORS solo orígenes configurados; encabezados de seguridad.
- **FR-005**: Errores Problem Details (RFC 9457), mensaje en español, id de correlación, sin trazas.
- **FR-006**: OpenAPI desde FastAPI en desarrollo.
- **FR-007**: Logs JSON con id de petición; sin datos personales.
- **FR-008**: Ruff, mypy, pytest y análisis de dependencias en cada cambio.

## Success Criteria

- **SC-001**: Levantar API + MySQL local + realm → salud anónima y `/v1/me` autenticado.
- **SC-002**: La prueba de arquitectura falla si un dominio importa el interior de otro.
- **SC-003**: OpenAPI genera un cliente TypeScript del andamiaje.

## Assumptions

Python 3.12+, FastAPI, Pydantic, SQLAlchemy 2, Alembic. Motor MySQL/MariaDB (versión exacta pendiente del assessment fase 0).

## Related

`labsmyg-idm` 001 · `labsmyg-core-front` 001 · `labsmyg-pipe-templates` 002
