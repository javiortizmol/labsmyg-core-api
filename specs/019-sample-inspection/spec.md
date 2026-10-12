# Feature Specification: Inspección de la muestra

**Feature Branch**: `019-sample-inspection`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 1–2 (flujo E2E paso 4)
**Fuente**: `docs/blueprint-plataforma-laboratorios-mg.md` (Blueprint Laboratorios M&G).
**Idioma**: spec funcional en español. Código/API en inglés.
**Dominios**: ver constitution Product **I** de `labsmyg-core-api` — no inventar dominios.

## User Scenarios & Testing

### User Story 1 - Registrar inspección (Priority: P1)

Recepción técnica registra apta o con condición; se avisa al cliente; constancia en hoja de vida e informe. Aceptación tácita si no responde: **configurable / pendiente §17**.

## Requirements

- **FR-001**: Inspección en dominio **samples**.
- **FR-002**: Condición informada al cliente vía communications (comando).
- **FR-003**: No detener el flujo por defecto salvo reglas configurables (pending).
- **FR-004**: Evidencia en sample history + audit.

## Pending

Si ciertas condiciones detienen el ensayo hasta respuesta del cliente.

## Related

007 · 008 · 009
