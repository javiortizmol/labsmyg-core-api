# Feature Specification: Modelo ER alineado a dominios

**Feature Branch**: `025-domain-er-model`
**Created**: 2026-10-12
**Status**: Aprobada (diseño preliminar fase 0)
**Fase**: Fase 0 — diseño; migraciones en fase 1 por dominio
**Fuente**: Blueprint § modelo de datos; constitución Product I; decisión de schema `audit`.
**Idioma**: spec funcional en español. Nombres de tablas/columnas en inglés.

## User Scenarios & Testing

### User Story 1 - ER por dominio (Priority: P1)

Arquitectura y desarrollo consultan un modelo entidad-relación agrupado por los siete dominios + transversales, con el MVP marcado y TBD del cuestionario explícitos.

**Independent Test**: Existe `docs/domain-er-model.md` con diagramas Mermaid por dominio y leyenda MVP/fase 4/TBD.

### User Story 2 - Auditoría en schema propio (Priority: P1)

`audit_event` vive en schema/database lógico `audit` (mismo servidor); solo INSERT desde la app.

### User Story 3 - Documentos con dueño en DB (Priority: P1)

Metadatos de archivo referencian reception/sample/order/customer; keys S3 estables por `document_id`.

## Requirements

- **FR-001**: Documento canónico `docs/domain-er-model.md` alineado a los 7 dominios.
- **FR-002**: Transversales: `audit`, `documents`, `approvals`, `outbox`,
  `inbox` — no son dominio. Platform ER incluye `laboratory_type` +
  `laboratory_site` (api `002`).
- **FR-003**: Laboratory sin columnas de identidad de cliente.
- **FR-004**: Catalog versions frozen en quotes/tests/reports (FK a version, no a “current”).
- **FR-005**: TBD del cuestionario listados (retención auditoría, etc.); no inventar respuestas.
- **FR-006**: MVP vs fase 4 marcado en el diagrama (laboratory/reports detalle / retained samples).

## Success Criteria

- **SC-001**: Un lector ubica el dueño de cada agregación en &lt; 2 min.
- **SC-002**: Ninguna tabla de negocio sin dominio dueño (salvo transversales documentados).

## Related

003 · 010 · 011 · 015 · blueprint § modelo de datos
