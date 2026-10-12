# Implementation Plan: Organización, configuración y numeración

**Branch**: `002-platform-organization` | **Date**: 2026-10-12 | **Spec**: [spec.md](./spec.md)

**Input**: Blueprint octubre 2026 y `specs/002-platform-organization/spec.md`.

## Summary

Dominio `platform`: company/site/laboratory, settings y `NumberService` atómico.

## Approach

Secuencias con bloqueo de fila; settings por clave/alcance; OpenAPI admin `/v1/companies|sites|laboratories|settings`.

## Product Conflict Check

| Check | Result | Evidence |
|---|---|---|
| Numeración global | Pass | Orden única M&G; factura por empresa diferida |
| Ownership | Pass | Plataforma en API; usuarios Keycloak en idm |

**Unresolved conflicts**: none.
