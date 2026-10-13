# Implementation Plan: Organización, configuración y numeración

**Branch**: `002-platform-organization` | **Date**: 2026-10-12 | **Spec**: [spec.md](./spec.md)

## Summary

Dominio `platform`: company / site / **laboratory_type** / laboratory,
settings y `NumberService` atómico. M&G multi-tipo de lab = catálogo de datos
(no hardcode); instancias CRUD sin redeploy.

## Approach

Secuencias con bloqueo de fila; settings por clave/alcance; OpenAPI admin
`/v1/companies|sites|laboratory-types|laboratories|settings`.

## Constitution Check

| Gate | Status | Notes |
|------|--------|-------|
| Platform owns org | Pass | |
| Logical delete | Pass | inactive labs/types |
| Delivery / idempotency | Pass | FR-011 |

## Product Conflict Check

| Conflict area | Check | Status | Notes / resolution |
|---------------|-------|--------|--------------------|
| Constitution | Seven domains; platform owns labs | Pass | |
| Vocabulary | `laboratory_type` ≠ test type | Pass | Documented |
| Ownership | API platform; UI front `002` | Pass | |
| Auth / roles | Admin + authz `004` by lab | Pass | New lab joins matrix |
| Cross-feature | Signers `017` by laboratory | Pass | Uses laboratory_id |
| Sibling | front CRUD types + labs | Pass | Amended front `002` |
| Delivery / idempotency | Writes + audit + outbox | Pass | |
| Quality / TDD | Concurrent numbering + CRUD tests | Pass | |
| Breaking | Softens ER: add type entity | Pass | Draft ER |

**Related specs reviewed**: `003`, `004`, `017`, front `002`, `025`

**Unresolved conflicts**: none
