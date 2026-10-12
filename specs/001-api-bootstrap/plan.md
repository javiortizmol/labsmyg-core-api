# Implementation Plan: API Bootstrap

**Branch**: `001-api-bootstrap` | **Date**: 2026-10-12 | **Spec**: [spec.md](./spec.md)

**Input**: Blueprint octubre 2026 y `specs/001-api-bootstrap/spec.md`.

## Summary

Monolito modular FastAPI con fronteras vacías, JWT Keycloak, salud, RFC 9457 y OpenAPI. Sin reglas de negocio.

## Technical Context

**Language**: Python 3.12 · **Deps**: FastAPI, Pydantic v2, SQLAlchemy 2, Alembic · **DB**: MySQL/MariaDB local · **Tests**: pytest + prueba de imports entre dominios

## Approach

1. Paquetes de dominio + shared + workers.
2. `/v1/health` público y `/v1/me` protegido.
3. Correlación, CORS, security headers, JWKS cacheado.
4. Problem Details; Alembic inicial; calidad enganchada a pipe-templates.

## Out of scope

Persistencia de negocio, numeración, auditoría, permisos, S3, EventBridge, IA, PDF.

## Product Conflict Check

| Check | Result | Evidence |
|---|---|---|
| Ownership API | Pass | Núcleo en este repo; envío en notifications |
| Auth | Pass | Keycloak JWKS; audiencia `labsmyg-api` |
| Vocabulario | Pass | Código EN, mensajes usuario ES; glosario `docs/domain-glossary.md` |
| Motor DB | Pass | Pendiente marcado; no inventado |
| Seven domains | Pass | Constitution 1.1.0 Product **I** — packages must be the seven domains only |
| Domain boundaries | Pass | Bootstrap creates empty packages + architecture import test; no cross-domain rules |

**Constitution amend (2026-10-12):** `labsmyg-core-api` constitution **1.0.0 → 1.1.0**
(Product domain model + architecture). Front **1.2.0** and notifications **1.1.0**
aligned. Domain map changes are MAJOR thereafter.

**Unresolved conflicts**: none.
