# Implementation Plan: Permisos por rol, sede y confidencialidad

**Branch**: `004-authorization` | **Date**: 2026-10-12 | **Spec**: [spec.md](./spec.md)

**Input**: Blueprint octubre 2026 y `specs/004-authorization/spec.md`.

## Summary

Dependencias FastAPI `require(module, action)` + proyecciones por audiencia. Semilla de roles predefinidos.

## Product Conflict Check

| Check | Result | Evidence |
|---|---|---|
| Confidencialidad analista | Pass | Schemas separados + permiso aparte |
| Identidad | Pass | Password en Keycloak; asignaciones aquí |

**Unresolved conflicts**: none.
