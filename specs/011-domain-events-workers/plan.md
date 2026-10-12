# Implementation Plan: Eventos de dominio, outbox y workers

**Branch**: `011-domain-events-workers` | **Date**: 2026-10-12 | **Spec**: [spec.md](./spec.md)

**Input**: Blueprint octubre 2026 y `specs/011-domain-events-workers/spec.md`.

## Summary

Outbox + publisher + workers Python del mismo repo. Local: bus/colas emulados o LocalStack.

## Product Conflict Check

| Check | Result | Evidence |
|---|---|---|
| Sync vs async | Pass | Criterio blueprint §6 respetado |
| notifications | Pass | Comandos de envío van a cola directa, no al bus |

**Unresolved conflicts**: none.
