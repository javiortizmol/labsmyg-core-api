# Feature Specification: NFR de partida y validación ISO 17025 7.11

**Feature Branch**: `023-nfr-and-validation`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 0–1 (living; valores a validar en fase 0)
**Fuente**: `docs/blueprint-plataforma-laboratorios-mg.md` (Blueprint Laboratorios M&G).
**Idioma**: spec funcional en español. Código/API en inglés.
**Dominios**: ver constitution Product **I** de `labsmyg-core-api` — no inventar dominios.

## User Scenarios & Testing

### User Story 1 - Objetivos NFR visibles (Priority: P2)

El equipo conoce RPO 15m, RTO 4h, 99.5% laboral, p95 <2s, volumen ×5, recepción usable en tablet/celular (responsive MVP; PWA/offline post-MVP) — y los ajusta tras fase 0.

## Requirements

- **FR-001**: Registrar NFR del blueprint §12 como targets; marcar cuáles están medidos.
- **FR-002**: Cada módulo a producción lleva paquete de validación (requisitos, pruebas, resultados, firma laboratorio) — proceso + plantilla en repo.
- **FR-003**: Criterio de salida: quality verde, sin críticos, aceptación firmada, pentest en primera salida.
- **FR-004**: E2E de los 12 pasos del flujo (§4) como suite acumulativa por fase.

## Related

015 · pipe-templates quality · iac backup
