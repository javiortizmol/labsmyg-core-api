# Feature Specification: Planificación, ensayos y resultados

**Feature Branch**: `012-laboratory`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 4 (meses 7–10); contratos de frontera desde fase 1
**Fuente**: Blueprint «Plataforma de gestión de Laboratorios M&G», octubre 2026, versión preliminar. Se cierra al final de la fase 0.
**Idioma**: spec funcional en español. Código, API, tablas, eventos y docs técnicas en inglés.

## User Scenarios & Testing

### User Story 1 - Asignar ensayo (Priority: P1 en fase 4)

Director/coordinador asigna ensayo a analista autorizado; sistema sugiere por autorización, carga y equipo libre.

### User Story 2 - Flujo del analista (Priority: P1 en fase 4)

Descarga plantilla Excel prellenada (sin cliente), carga resultados, validación por mapeo fijo (no IA).

### User Story 3 - Metrología y trazabilidad de equipo (Priority: P2 en fase 4)

Equipos, calibraciones; bloquear equipo vencido; listar ensayos afectados si se descubre descalibración.

## Requirements

- **FR-001**: Bandeja por laboratorio; asignación o toma de trabajo según config.
- **FR-002**: No asignar a no autorizado (ISO 17025 6.2.6).
- **FR-003**: Analista ve código, equipo, plantilla — nunca cliente.
- **FR-004**: Extracción de resultados por mapeo fijo; IA solo ayuda a configurar mapeo (fase 4).
- **FR-005**: Equipo usado + estado calibración en el ensayo.
- **FR-006**: Identificador de ensayo (ej. 267498-03) vía numeración.

## Related

006 · 007 · 004 · 014 · front 008-laboratory-ui  
ER: [`docs/domain-er-model.md`](../../docs/domain-er-model.md) (lab_assignment, sample_test, result — F4) · `025-domain-er-model`
