# Feature Specification: Local Floci AWS Emulator

**Feature Branch**: `024-local-floci`
**Created**: 2026-10-12
**Status**: Aprobada (dev tooling)
**Fase**: Fase 0 / andamiaje local
**Fuente**: [floci-io/floci](https://github.com/floci-io/floci); patrón Mandado (`mandado-api` compose profile `aws-emulator`).
**Idioma**: spec funcional en español. Código, paths Compose, env vars y docs técnicas en inglés.

## User Scenarios & Testing

### User Story 1 - Emulador AWS local con un comando (Priority: P1)

Un desarrollador levanta Floci en Docker y apunta el AWS CLI / SDK a `http://localhost:4566` sin cuenta AWS ni token.

**Why this priority**: Sin emulador local no se pueden integrar S3, SQS, EventBridge, Secrets Manager, etc. antes de cloud.

**Independent Test**: `make floci-up` → health en `:4566` → `aws s3 mb` con endpoint local crea un bucket.

**Acceptance Scenarios**:

1. **Given** Docker disponible, **When** `make floci-up`, **Then** Floci escucha en `localhost:4566`.
2. **Given** Floci arriba y vars de `make floci-env`, **When** se crea un bus EventBridge, una regla hacia SQS y se publica `sample.received`, **Then** el mensaje llega a la cola (forma del blueprint).
3. **Given** Floci no arrancado, **When** la API corre sin `AWS_ENDPOINT_URL`, **Then** no hay dependencia obligatoria del emulador (perfil opcional).

### User Story 2 - Misma convención que Mandado (Priority: P1)

El compose usa perfil `aws-emulator`, imagen `floci/floci`, puerto `4566` y `AWS_ENDPOINT_URL` opcional en `.env.example`.

**Why this priority**: Un solo mental model entre productos Labs/Mandado.

**Independent Test**: Diff conceptual con `mandado-api/docker-compose.yml` service `floci`.

**Acceptance Scenarios**:

1. **Given** el repo, **When** se inspecciona Compose, **Then** el servicio `floci` está bajo `profiles: ["aws-emulator"]`.
2. **Given** `.env.example`, **When** se copia a `.env`, **Then** documenta `AWS_ENDPOINT_URL=http://localhost:4566` y credenciales de prueba.

### User Story 3 - Consola web opcional (Priority: P2)

El desarrollador abre la UI Floci para inspeccionar recursos locales.

**Why this priority**: Facilita depuración; no bloquea SDK/CLI.

**Independent Test**: Con Docker socket montado, abrir `http://localhost:4566/_floci/ui`.

**Acceptance Scenarios**:

1. **Given** Floci con socket Docker, **When** se visita `/_floci/ui`, **Then** la consola carga o redirige al sidecar.

### Edge Cases

- Puerto `4566` ocupado → Compose falla con error claro; documentar cambio de host port.
- Sin Docker → `make floci-up` falla; no se mockea en proceso Python.
- Credenciales: cualquier valor no vacío (`test`/`test`); no secretos reales en `.env.example`.
- Persistencia: volumen nombrado; `make floci-down` no borra el volumen salvo `make floci-reset`.

## Requirements

- **FR-001**: `docker-compose.yml` (o `compose.yaml`) con servicio `floci` imagen `floci/floci:latest`, puerto host `4566`, perfil `aws-emulator`.
- **FR-002**: Variables documentadas: `AWS_ENDPOINT_URL`, `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_DEFAULT_REGION` (default `us-east-1` hasta decisión IaC fase 0).
- **FR-003**: `Makefile` targets `floci-up`, `floci-down`, `floci-logs`, `floci-env`, `floci-reset`.
- **FR-004**: README (o quickstart) con smoke **EventBridge → SQS** (y S3 opcional).
- **FR-005**: Floci es **solo local/CI opcional**; producción usa AWS real vía IaC (`labsmyg-iac` / módulos). No sustituye cloud.
- **FR-006**: Montar Docker socket para servicios container-backed y UI (alineado a docs Floci).
- **FR-007**: `FLOCI_HOSTNAME=floci` y `FLOCI_STORAGE_MODE=hybrid` para desarrollo local.

## Success Criteria

- **SC-001**: En máquina con Docker, Floci responde en &lt; 30 s tras `make floci-up`.
- **SC-002**: Smoke CLI publica en EventBridge y el evento llega a SQS; S3 opcional.
- **SC-003**: Sin perfil `aws-emulator`, Compose no arranca Floci por defecto.

## Assumptions

- Patrón tomado de Mandado; Labs MYG no usa LocalStack.
- Región local provisional `us-east-1` (IaC aún decide us-east-1 vs sa-east-1).
- MariaDB/Keycloak locales son features aparte; este slice solo cubre el emulador AWS.
