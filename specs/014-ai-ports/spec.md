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

### User Story 3 - IA primero, manual si falla (Priority: P1)

Solo en flujos donde el blueprint o la spec de feature **marcan asistencia IA**
(no en todos los procesos). Esos flujos asistidos **se inician por IA** (camino
feliz / aceleración). Si la IA falla, expira, no está disponible, devuelve baja
confianza o el usuario rechaza la propuesta, el mismo proceso **continúa por la
ruta manual** (formularios, confirmaciones, cargas) sin esperar al agente ni
quedar bloqueado. La IA no es un hard gate; el manual es fallback obligatorio
(y puede elegirse de entrada cuando el producto permita omitir IA). Flujos
solo manuales no tienen puerta IA ni obligación de intentar IA primero.

**Independent Test**: Simular timeout o error del puerto de texto/documento en un flujo con asistencia IA; verificar que la transición de dominio sigue disponible vía API/UI manual.

**Acceptance Scenarios**:

1. **Given** un flujo con extracción asistida por IA, **When** el puerto devuelve error o timeout, **Then** el usuario puede ingresar los mismos datos manualmente y confirmar sin depender de reintentos de IA.
2. **Given** un job asíncrono de agente en curso, **When** el job falla o se agota el tiempo, **Then** el agregado no queda en un estado que solo la IA puede desbloquear; la máquina de estados admite la ruta manual equivalente.
3. **Given** baja confianza en una propuesta de IA, **When** el usuario la rechaza o ignora, **Then** puede completar la acción editando campos a mano como si no hubiera usado IA.

## Requirements

- **FR-001**: Cuatro puertos hexagonales + adaptadores AWS en los 10 meses (Bedrock, Textract, Knowledge Bases, Guardrails).
- **FR-002**: Config por tarea (modelo pinneado a versión exacta + alterno) desde backoffice.
- **FR-003**: Herramientas de agentes vía MCP con permisos del conversador.
- **FR-004**: ChromaDB en dev/pruebas; KB Bedrock en AWS.
- **FR-005**: Auditoría de cada uso (entrada, salida, modelo, versión, quien aprobó).
- **FR-006**: Extracción Excel de resultados NO es IA (mapeo fijo).
- **FR-007**: Asistente cliente solo datos del sistema del contacto verificado; sin resultados ni opiniones técnicas.
- **FR-008**: **AI-first** aplica solo donde blueprint/spec define asistencia IA; los demás casos de uso no tienen gate IA. En capacidades asistidas: se inicia por IA; ningún flujo exige éxito de IA para avanzar. Cada capacidad asistida MUST exponer equivalente manual en la API y UI del dominio dueño (formularios, confirmaciones, cargas); skip/upfront manual cuando el producto lo permita. MUST NOT añadir pasos IA a flujos deterministas/manuales sin enmienda de spec.
- **FR-009**: Fallos, timeouts, indisponibilidad del proveedor, rechazo del usuario y propuestas de baja confianza MUST continuar por la **ruta manual obligatoria** (sin estados bloqueados ni espera obligatoria de workers/agentes).
- **FR-010**: Jobs asíncronos que invocan IA MUST NOT ser la única vía a una transición de estado válida; errores de job MUST liberar el flujo manual documentado en el caso de uso (mismo resultado que vía IA exitosa).

## Related

006/007/008 fases 2–3 · constitution de producto · notificaciones push “listo”  
Agent definitions / prompts / evals / MCP contracts → sibling repo `labsmyg-agents`
(ports and adapters stay here).
