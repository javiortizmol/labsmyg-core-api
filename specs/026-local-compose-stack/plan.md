# Implementation Plan: Local Docker Compose stack

**Branch**: `026-local-compose-stack` | **Date**: 2026-10-12 | **Spec**: [spec.md](./spec.md)

## Summary

Expand `docker-compose.yml` with MySQL 8.4 (schemas `labsmyg` + `labsmyg_audit`), keep Floci on profile `aws-emulator`, document env and Makefile targets. No API image until health exists.

## Technical Context

**Language/Version**: Compose v2; MySQL 8.4  
**Primary Dependencies**: Docker / Colima; existing Floci image  
**Storage**: named volume `labsmyg_mysql_data`  
**Testing**: manual smoke (`mysqladmin ping` / client); quality gate unchanged  
**Target Platform**: local macOS/Linux developer machines  
**Project Type**: API repo local tooling  
**Performance Goals**: MySQL healthy &lt; 60s  
**Constraints**: host MySQL may use 3306 → default host port `3307`; Floci host port via `FLOCI_HOST_PORT`  
**Scale/Scope**: single-node local only

## Constitution Check

| Gate | Status | Notes |
|------|--------|-------|
| Speckit + quality | Pass | Docs/compose only; `make quality` unchanged |
| Ownership | Pass | core-api owns app DB + local Floci; IdM Keycloak stays out |
| Auth / security | Pass | Local weak passwords in `.env.example` only; never commit `.env` |
| English identifiers | Pass | Service/env names in English |
| TDD / coverage | N/A | No app code |
| Sibling repos | Pass | Front/IdM may later point `DATABASE_URL` / Floci endpoint |

## Product Conflict Check

| Check | Result | Evidence / resolution |
|-------|--------|------------------------|
| Constitution / vocabulary | Pass | Engine locked to MySQL (constitution II); English compose keys |
| Repo ownership | Pass | core-api local stack only |
| Auth / roles / realms | Pass | No Keycloak in this compose |
| Application security | Pass | Local credentials; audit DB separate |
| Related specs | Pass | Extends `024`; schemas match `025` / `003` |
| Sibling coherence | Pass | Front uses env later; no IdM change |
| Quality / TDD | Pass | No production code |
| Spec ↔ code | Pass | Compose + docs deliver FR-* |
| Breaking changes | Pass | Additive; Floci profile preserved |

**Unresolved conflicts**: none

## Project Structure

```text
docker-compose.yml
.env.example
docker/mysql/init/01-schemas.sql
docs/local-compose.md
Makefile
specs/026-local-compose-stack/
```

## Complexity Tracking

| Violation | Why needed | Simpler alternative rejected because |
|-----------|------------|-------------------------------------|
| — | — | — |
