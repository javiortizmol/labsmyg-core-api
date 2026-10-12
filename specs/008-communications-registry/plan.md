# Implementation Plan: Registro de comunicaciones y avisos

**Branch**: `008-communications-registry` | **Date**: 2026-10-12 | **Spec**: [spec.md](./spec.md)

**Input**: Blueprint octubre 2026 y `specs/008-communications-registry/spec.md`.

## Summary

Dominio `communications` dueño del COM y de la decisión. Adaptador SQS de salida; resultados por EventBridge.

## Product Conflict Check

| Check | Result | Evidence |
|---|---|---|
| Frontera notifications | Pass | Núcleo decide; servicio envía |
| Fase 3 | Pass | WhatsApp/asistente fuera |

**Unresolved conflicts**: none.
