# Feature Specification: Puertos de IA y reglas de uso

**Feature Branch**: `014-ai-ports`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Puertos + stubs desde fase 1; adaptadores AWS en los 10 meses; **segundo proveedor (p. ej. Vertex AI)** vía mismo puerto cuando se apruebe (post–AWS o failover)
**Fuente**: Blueprint §10 (hexagonal + cadena de respaldo multi-proveedor); agents `003`.
**Idioma**: spec funcional en español. Código, API, tablas, eventos y docs técnicas en inglés.

## Hexagonal model (provider-agnostic)

```
Use-cases / UI / agents-runtime
        │
        ▼
   Ports (this API)                    ← no AWS/GCP types in domain code
   • TextReasoningPort
   • DocumentReadPort
   • SemanticSearchPort
   • SafetyFilterPort
        │
        ├── Adapter AWS (primary, 10 months): Bedrock Converse, Textract,
        │     Bedrock Knowledge Bases, Bedrock Guardrails
        │
        └── Adapter Google (optional later / failover): Vertex AI (Gemini),
              Document AI, Vertex AI Search (or equivalent), safety via
              port capabilities + own checks
```

Agents and domain code **MUST NOT** import Bedrock/Vertex SDKs. Switching
provider = new adapter + config + eval suite, not rewriting agents
(`labsmyg-agents`).

| Port | AWS adapter (primary) | Google adapter (planned) |
|------|------------------------|---------------------------|
| Text / reasoning | Bedrock Converse | Vertex AI Gemini (Generative AI) |
| Document read | Textract (and/or Bedrock multimodal) | Document AI |
| Semantic search | Bedrock Knowledge Bases | Vertex AI Search / reindex |
| Safety filters | Bedrock Guardrails (+ own rules) | Port-level + own rules (provider-specific if needed) |

Local/dev: ChromaDB for semantic search tests; stubs for other ports.

## User Scenarios & Testing

### User Story 1 - Puertos sin acoplar proveedor (Priority: P1)

Cuatro puertos: texto/razonamiento, lectura de documentos, búsqueda semántica, filtros de seguridad. Agentes no importan SDKs de proveedor.

**Independent Test**: Architecture test fails if `agents` / domain packages import `boto3` Bedrock or `google.cloud.aiplatform` / Vertex client libs.

### User Story 2 - La IA propone, persona decide (Priority: P1)

Ninguna salida de IA aprueba, firma ni envía sola. Todo queda marcado como propuesta hasta confirmación humana; uso auditado.

### User Story 3 - IA primero, manual si falla (Priority: P1)

Solo en flujos donde el blueprint o la spec de feature **marcan asistencia IA**.
Esos flujos **se inician por IA**; si falla / timeout / baja confianza / rechazo → **ruta manual** obligatoria. Sin hard gate.

**Independent Test**: Timeout del puerto → mismo outcome vía formulario manual.

### User Story 4 - Cadena de respaldo / segundo proveedor (Priority: P2)

Por tarea se configura proveedor primario y opcional de respaldo (p. ej. AWS → Vertex). El puerto elige adaptador; capacidades no soportadas se degradan sin romper el contrato. Activar Vertex exige: adaptador + evals + revisión contrato datos / Ley 1581 + reindex semántico si aplica.

## Requirements

- **FR-001**: Cuatro puertos hexagonales **de dominio** (UI/use-cases). Adaptadores **AWS** (Bedrock, Textract, Knowledge Bases, Guardrails) en los 10 meses.
- **FR-001b**: Diseño MUST permitir adaptador **Google Vertex AI / Document AI / Vertex AI Search** detrás de los mismos puertos sin cambiar agentes ni use-cases. Implementación Vertex = slice aparte cuando se priorice (no bloquea MVP AWS).
- **FR-002**: Config por tarea: proveedor, modelo pinneado a versión exacta, región, parámetros, **cadena de respaldo** (puede cruzar proveedores).
- **FR-003**: Herramientas de agentes vía MCP con permisos del conversador (este API las sirve a `agents-runtime`).
- **FR-004**: ChromaDB en dev/pruebas; KB Bedrock en AWS; cambio de proveedor de búsqueda ⇒ reindex (vectores no son portables).
- **FR-005**: Auditoría de cada uso (entrada, salida, **proveedor**, modelo, versión, quien aprobó).
- **FR-006**: Extracción Excel de resultados NO es IA (mapeo fijo).
- **FR-007**: Asistente cliente solo datos del sistema del contacto verificado; sin resultados ni opiniones técnicas.
- **FR-008**: **AI-first** solo donde blueprint/spec define asistencia IA; fallback/skip manual obligatorio.
- **FR-009**: Fallos de cualquier proveedor → ruta manual; no estados bloqueados.
- **FR-010**: Jobs async de IA MUST NOT ser la única vía a una transición válida.
- **FR-011**: Orquestación de agentes en ECS **`agents-runtime`** (`labsmyg-agents` `003`). Este API encola `agent.task.requested` y consume `agent.task.proposed` / `failed`; sin auto-commit.
- **FR-012**: Bedrock/Vertex **no** hospedan el proceso del agente (solo inferencia). Interim: `core-worker` + puertos hasta existir `agents-runtime`.
- **FR-013**: Prueba de arquitectura automatizada: sin imports de SDK de proveedor en dominios / paquetes de agente consumidos desde defs.
- **FR-014**: Credenciales multi-cloud federadas (sin access keys largas en git) cuando exista adaptador Vertex; iac documenta wiring.

## Success Criteria

- **SC-001**: Stub ports + AWS adapter path green under `make quality` when coded.
- **SC-002**: Architecture test blocks provider SDK leaks into domain/agent code.
- **SC-003**: Spec/plan name Vertex (or equivalent) as second-adapter target; no rewrite of hexagonal ports required to add it.

## Related

`007` guía/foto · `006`/`008` · agents `001`/`003` · iac inventory (Bedrock; Vertex deferred) · iac **`006` FinOps** (alertas Bedrock + GCP cuando Vertex) · blueprint §10
