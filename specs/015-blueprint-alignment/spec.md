# Feature Specification: Alineación al blueprint y scorecard MVP

**Feature Branch**: `015-blueprint-alignment`
**Created**: 2026-10-12
**Status**: Draft — living doc (no “implementación” de código propia)
**Fase**: Fase 0–1
**Fuente**: [`docs/blueprint-plataforma-laboratorios-mg.md`](../../docs/blueprint-plataforma-laboratorios-mg.md)
**Idioma**: español (negocio). Dominios: constitution Product **I**.

## User Scenarios & Testing

### User Story 1 - Inventario de cobertura (Priority: P1)

El equipo ve, por sección del blueprint y por capacidad, qué spec/repo la cubre y en qué fase.

**Independent Test**: Esta tabla se actualiza cuando se mergea o aprueba una capacidad.

## Requirements

- **FR-001**: Mantener matrices de cobertura blueprint → specs/repos.
- **FR-002**: Citar IDs de specs; no duplicar reglas de negocio aquí.
- **FR-003**: Decisiones §17 con dueño; no inventar respuestas.
- **FR-004**: Fallar Product Conflict Check si se inventa un 8º dominio o se mueven reglas a notifications.

## Blueprint § → cobertura

| § Blueprint | Tema | Cobertura | Dónde |
|---|---|---|---|
| 1 | Visión / principios | Constitution Product **I-c** | `core-api` constitution |
| 2 | 7 dominios + numeración + fronteras | Constitution Product **I**, **I-a**, **I-b** | `core-api` + glosario |
| 3.1 | Plataforma | Specs | `002`, `003`, `004`, `017` |
| 3.2 | Clientes y comercial | Specs | `005` (+ fase 2 segmentación/inactivos en follow-ups) |
| 3.3 | Normas y catálogo | Specs | `006` (+ vigilancia/IA fase 2 vía `014`) |
| 3.4 | Muestras | Specs | `007`, `019`, `020` (contramuestras fase 4) |
| 3.5 | Laboratorio | Specs | `012` (fase 4) |
| 3.6 | Informes y entrega | Specs | `013` (+ preliminares en spec) |
| 3.7 | Comunicaciones | Specs | `008` + `notifications` 001–005 |
| 3 Analítica | Listas MVP / tableros | Specs | `016` + front `010`; tableros 2/4/5 después |
| 4 | Flujo 12 pasos | Mapa E2E | `023` + specs por paso |
| 5 | Modelo de datos | ER por dominio + glosario | `025` · [`docs/domain-er-model.md`](../../docs/domain-er-model.md) · `docs/domain-glossary.md` |
| 6 | Arquitectura / stack | Constitution **II** + plans | `001`, `011`, `010`, `014` |
| 7 | Lineamientos / monorepo→repos | READMEs specs + constitution | multi-repo map |
| 8 | AWS / operación | Specs | `iac` 001–002, `tf-modules` 001 |
| 9 | Integraciones | Specs + pending §17 | ports en API; adapters por fase |
| 10 | IA | Specs | `014` |
| 11 | Seguridad / permisos / auditoría | Specs + constitution Identity | `003`, `004`, `009`, `idm` |
| 12 | NFR | Specs | `023` |
| 13 | Migración | Specs | `021` |
| 14 | Calidad / validación 17025 | Specs + quality gates | `023`, constitutions Quality |
| 15 | Forma de trabajo SDD | Speckit harness | `.specify` + constitutions |
| 16 | Fases | Scorecard abajo | esta spec |
| 17 | Decisiones pendientes | Pending en specs hijas | no inventar |

## Ecosistema repos (vs Mandado)

| Mandado | Labs MYG | Notas |
|---|---|---|
| `mandado-api` | `labsmyg-core-api` | 7 dominios LIMS vs marketplace |
| `mandado-frontend` + `mandado-backoffice` | `labsmyg-core-front` | App interna + portal en un repo, dos deploys |
| `mandado-landing` / `mandado-mobile` | — | PWA recepción; sin landing/móvil nativo en blueprint |
| `mandado-idm` | `labsmyg-idm` | Realms `myg` / `cloud` |
| (envío en API o lateral) | `labsmyg-notifications` | Servicio de envío explícito del blueprint |
| `mandado-infrastructure` | `labsmyg-iac` | MySQL/MariaDB, no Postgres |
| `mandado-tf-modules` | `labsmyg-tf-modules` | Mismos patrones de módulo |
| `mandado-github-templates` | `labsmyg-pipe-templates` | Quality + deploy OIDC |
| `mandado-mocks` | — | No aplica aún |

## Gap inventory (capacidad)

| Capacidad | Estado | Fase | Spec |
|---|---|---|---|
| Constitution Product (7 dominios) | Presente 1.2.0 | 0 | constitution |
| Glosario ES→EN + blueprint en docs/ | Presente | 0 | `docs/*` |
| ER preliminar por dominios | Presente (doc) | 0 | `025` · `docs/domain-er-model.md` |
| Andamiaje API | Ausente (código) | 1 | `001` |
| Plataforma org/numeración | Ausente | 1 | `002` |
| Auditoría encadenada | Ausente | 1 | `003` |
| Autorización / confidencialidad | Ausente | 1 | `004` |
| Firmantes | Ausente | 1 | `017` |
| Clientes + cotización | Ausente | 1 | `005` |
| Catálogo mínimo | Ausente | 1 | `006` |
| Ingreso muestras | Ausente | 1 | `007` |
| Inspección | Ausente | 1–2 | `019` |
| Vista completa orden | Ausente | 1 | `018` |
| COM + correo | Ausente | 1 | `008` + notif |
| Aprobaciones enlace+OTP | Ausente | 1 | `009` |
| Archivos / PDF | Ausente | 1 | `010` |
| Outbox / workers | Ausente | 1 | `011` |
| Idempotencia | Ausente | 1 | `022` |
| Listas pendientes MVP | Ausente | 1 | `016` + front `010` |
| Portal público | Ausente | 1 | front `007` |
| Migración / convivencia | Ausente | 0–4 | `021` |
| NFR / validación 17025 | Ausente (doc) | 0–1 | `023` |
| Vigilancia normas + IA catálogo | Ausente | 2 | `006`/`014` |
| WhatsApp + asistente | Ausente | 3 | `008` + notif |
| Laboratorio | Ausente | 4 | `012` |
| Informes + firma + preliminares | Ausente | 4 | `013` |
| Contramuestras | Ausente | 4 | `020` |
| Analítica completa / KPIs | Ausente | 2–5 | follow-ups |
| Evoluciones (insumos, QC, lago) | Fuera 10 meses | post | blueprint §16 |

**Regla:** inventar un dominio fuera de los siete, o mover reglas de negocio a `labsmyg-notifications`, **falla** el Product Conflict Check hasta enmendar la constitution (MAJOR).

## Pending §17 (dueños)

| Tema | Dueño |
|---|---|
| Fecha emisión informe (R3) | Calidad / legal |
| Federación Entra vs AD | TI (sync M365?) |
| Factura electrónica / firma digital | Contador / calidad |
| Motor DB versión | Assessment fase 0 |
| Normas en curso / precios / no responde | Calidad / comercial |
| Laboratorio piloto | Gerencia |
| Clientes exterior | Gerencia / contador |
| Retención registros | Política laboratorio |
| Informes preliminares (aprobador, logo, costo) | Calidad / comercial |
| Segmentación / inactivos umbrales | Gerencia / comercial |
| Sedes otros países | Gerencia |
| Dominio DNS correo | TI |
| Código muestra / stickers | Calidad / recepción / TI |
