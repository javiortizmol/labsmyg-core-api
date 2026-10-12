# Feature Specification: Auditoría encadenada y borrado lógico

**Feature Branch**: `003-audit-trail`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 1 — Plataforma
**Fuente**: Blueprint «Plataforma de gestión de Laboratorios M&G», octubre 2026, versión preliminar. Se cierra al final de la fase 0.
**Idioma**: spec funcional en español. Código, API, tablas, eventos y docs técnicas en inglés.

## User Scenarios & Testing

### User Story 1 - Toda escritura deja rastro (Priority: P1)

Cada escritura registra actor, acción, entidad, instante, sede, valor anterior/nuevo. Nadie edita ni borra la fila.

### User Story 2 - Cadena verificable (Priority: P1)

Cada registro incluye huella del anterior; un verificador detecta alteración.

### User Story 3 - Consulta para auditor (Priority: P2)

Filtrar por orden/muestra/cliente/usuario/fechas y exportar CSV.

### User Story 4 - Borrar es cambiar estado (Priority: P1)

Estados: inactive, deleted, voided (documentos emitidos). Sin borrado físico desde la app.

## Requirements

- **FR-001**: Tabla solo inserción en schema/database lógico `audit` (mismo servidor); app sin update/delete.
- **FR-002**: Campos de actor, acción, entidad, sede, before/after; si IA: modelo + quien aprobó.
- **FR-003**: Hash encadenado + verificador.
- **FR-004**: Misma transacción que la escritura de negocio.
- **FR-005**: Ciclo de vida lógico; consultas normales solo activos.
- **FR-006**: Consulta/exportación autorizada.
- **FR-007**: Anonimización por retención/Ley 1581 deja constancia; no borra auditoría.

## Pending

Años de retención por tipo de registro.

## Related

Todos los dominios · copia S3 vía 011 + iac · front 011-audit-explorer-ui  
ER: [`docs/domain-er-model.md`](../../docs/domain-er-model.md) (schema `audit`) · `025-domain-er-model`
