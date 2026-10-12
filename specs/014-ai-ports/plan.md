# Implementation Plan: Puertos de IA y reglas de uso

**Branch**: `014-ai-ports` | **Date**: 2026-10-12 | **Spec**: [spec.md](./spec.md)

**Input**: Blueprint octubre 2026 y `specs/014-ai-ports/spec.md`.

## Summary

Paquete `app/shared/ai` con puertos y stubs. Adaptadores AWS cuando iac habilite Bedrock. Prueba de arquitectura: agentes sin imports de proveedor.

## Product Conflict Check

| Check | Result | Evidence |
|---|---|---|
| Humano decide | Pass | FR-005/reglas blueprint §10 |
| Vendor lock | Pass | Puertos + prueba arquitectura |

**Unresolved conflicts**: none.
