# Implementation Plan: Listas básicas de pendientes (MVP analítica)

**Branch**: `016-mvp-pending-lists` | **Date**: 2026-10-12 | **Spec**: [spec.md](./spec.md)

## Summary

Endpoints de lectura bajo un seam neutro (p.ej. `/v1/workspace/pending` o consultas en samples) que **no** crean `app/domains/analytics`. Product Conflict: analítica transversal.

## Product Conflict Check

| Check | Result | Evidence |
|---|---|---|
| No 8º dominio | Pass | Sin package analytics |
| Solo lectura | Pass | GET only |

**Unresolved conflicts**: none.
