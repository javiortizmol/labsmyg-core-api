# Specs — labsmyg-core-api

Corte inicial a partir del blueprint de octubre 2026. Cada carpeta tiene `spec.md`, `plan.md` y `tasks.md`.

Estado: **Draft**. El blueprint es preliminar y se cierra al final de la fase 0. En el refinamiento (§15) cada capacidad se parte en specs de una semana o menos antes de Aprobada.

El blueprint describe un monorepo (`backend/`, `frontend/`, `infra/`, `notifications/`, `specs/`). La entrega usa estos repositorios:

| Carpeta blueprint | Repositorio |
| --- | --- |
| `backend/` | `labsmyg-core-api` |
| `frontend/` | `labsmyg-core-front` |
| `infra/` | `labsmyg-iac` |
| módulos Terraform | `labsmyg-tf-modules` |
| Keycloak | `labsmyg-idm` |
| `notifications/` | `labsmyg-notifications` |
| agentes IA (defs / evals / MCP) | `labsmyg-agents` |
| workflows reutilizables | `labsmyg-pipe-templates` |

| Spec | Fase | Qué cubre en este repo |
| --- | --- | --- |
| [`001-api-bootstrap`](./001-api-bootstrap/spec.md) | 0–1 | Andamiaje FastAPI, JWT, OpenAPI |
| [`002-platform-organization`](./002-platform-organization/spec.md) | 1 | Empresa/sedes/labs + numeración + settings |
| [`003-audit-trail`](./003-audit-trail/spec.md) | 1 | Auditoría encadenada + borrado lógico |
| [`004-authorization`](./004-authorization/spec.md) | 1 | Permisos, roles, confidencialidad analista |
| [`005-customers-quotes`](./005-customers-quotes/spec.md) | 1 | Clientes y cotizaciones |
| [`006-catalog-standards`](./006-catalog-standards/spec.md) | 1 | Normas, ensayos, precios |
| [`007-samples-intake`](./007-samples-intake/spec.md) | 1 | Órdenes, recepción, hoja de vida |
| [`008-communications-registry`](./008-communications-registry/spec.md) | 1 | COM y avisos (decisión de envío) |
| [`009-approvals-engine`](./009-approvals-engine/spec.md) | 1 | Enlace + OTP de aprobación |
| [`010-files-documents`](./010-files-documents/spec.md) | 1 | S3/presigned + PDF |
| [`011-domain-events-workers`](./011-domain-events-workers/spec.md) | 1 | Outbox, EventBridge, jobs |
| [`012-laboratory`](./012-laboratory/spec.md) | 4 | Ensayos/resultados (contratos tempranos) |
| [`013-reports-delivery`](./013-reports-delivery/spec.md) | 4 | Informes, firma, entrega |
| [`014-ai-ports`](./014-ai-ports/spec.md) | 1–2 | Puertos IA; adaptadores desde fase 2 |
| [`015-blueprint-alignment`](./015-blueprint-alignment/spec.md) | 0 | Scorecard de gaps vivo |

| [`016-mvp-pending-lists`](./016-mvp-pending-lists/spec.md) | 1 | Listas vencido/hoy/próximo (analítica RO) |
| [`017-platform-signers`](./017-platform-signers/spec.md) | 1 | Firmantes |
| [`018-order-complete-view`](./018-order-complete-view/spec.md) | 1 | Vista completa de la orden |
| [`019-sample-inspection`](./019-sample-inspection/spec.md) | 1–2 | Inspección de muestra |
| [`020-retained-samples`](./020-retained-samples/spec.md) | 4 | Contramuestras |
| [`021-migration-coexistence`](./021-migration-coexistence/spec.md) | 0–4 | Migración PHP y cortes |
| [`022-endpoint-idempotency`](./022-endpoint-idempotency/spec.md) | 1 | Idempotencia transversal |
| [`023-nfr-and-validation`](./023-nfr-and-validation/spec.md) | 0–1 | NFR + validación 17025 7.11 |
| [`024-local-floci`](./024-local-floci/spec.md) | 0 | Emulador AWS local (Floci) |
| [`025-domain-er-model`](./025-domain-er-model/spec.md) | 0 | ER preliminar por dominio → [`docs/domain-er-model.md`](../docs/domain-er-model.md) |
| [`026-local-compose-stack`](./026-local-compose-stack/spec.md) | 0 | Compose local MySQL + Floci |
| [`027-shared-mailbox-email`](./027-shared-mailbox-email/spec.md) | 1 | Buzón operativo compartido (COM inbound + docs) |

Las decisiones de la sección 17 del blueprint quedan como pendientes dentro de la spec que las usa. No se inventan respuestas del cuestionario.
