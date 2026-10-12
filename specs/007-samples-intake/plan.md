# Implementation Plan: Órdenes, recepción y hoja de vida

**Branch**: `007-samples-intake` | **Date**: 2026-10-12 | **Spec**: [spec.md](./spec.md)

**Input**: Blueprint octubre 2026 y `specs/007-samples-intake/spec.md`.

## Summary

Dominio `samples` con máquina de estados explícita. Fase 1 sin traslados, contramuestras ni IA de guía.

## Product Conflict Check

| Check | Result | Evidence |
|---|---|---|
| Transiciones | Pass | POST de comando, 409 inválidas |
| Formato código | Pass | En settings, pendiente cuestionario |

**Unresolved conflicts**: none.
