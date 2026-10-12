# Feature Specification: Puertos de IA y reglas de uso

**Feature Branch**: `014-ai-ports`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 2+; puertos listos desde fase 1
**Fuente**: Blueprint «Plataforma de gestión de Laboratorios M&G», octubre 2026, versión preliminar. Se cierra al final de la fase 0.
**Idioma**: spec funcional en español. Código, API, tablas, eventos y docs técnicas en inglés.

## User Scenarios & Testing

### User Story 1 - Puertos sin acoplar proveedor (Priority: P1)

Cuatro puertos: texto/razonamiento, lectura de documentos, búsqueda semántica, filtros de seguridad. Agentes no importan SDKs de proveedor.

### User Story 2 - La IA propone, persona decide (Priority: P1)

Ninguna salida de IA aprueba, firma ni envía sola. Todo queda marcado como propuesta hasta confirmación humana; uso auditado.

## Requirements

- **FR-001**: Cuatro puertos hexagonales + adaptadores AWS en los 10 meses (Bedrock, Textract, Knowledge Bases, Guardrails).
- **FR-002**: Config por tarea (modelo pinneado a versión exacta + alterno) desde backoffice.
- **FR-003**: Herramientas de agentes vía MCP con permisos del conversador.
- **FR-004**: ChromaDB en dev/pruebas; KB Bedrock en AWS.
- **FR-005**: Auditoría de cada uso (entrada, salida, modelo, versión, quien aprobó).
- **FR-006**: Extracción Excel de resultados NO es IA (mapeo fijo).
- **FR-007**: Asistente cliente solo datos del sistema del contacto verificado; sin resultados ni opiniones técnicas.

## Related

006/007/008 fases 2–3 · constitution de producto · notificaciones push “listo”
