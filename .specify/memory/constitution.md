<!--
Sync Impact Report
- Version: 1.1.0 → 1.2.0 (MINOR: Identity & Access theme; blueprint path in docs/)
- Version: 1.0.0 → 1.1.0 (MINOR: Product domain model + architecture non-negotiables
  from Blueprint Laboratorios M&G; domains must be followed strictly)
-->

# labsmyg-core-api Constitution

Single source of non-negotiables for this repo. Speckit and agents read **this
file only** — themes below are navigation, not separate constitutions.

Specs in `specs/` carry feature detail. Speckit is mandatory for every change.

**Themes:** Product · Architecture & Data · Identity & Access · Quality ·
Ownership · Governance

**Version**: 1.2.0 | **Ratified**: 2026-10-12 | **Last Amended**: 2026-10-12

**Product source**: [`docs/blueprint-plataforma-laboratorios-mg.md`](../../docs/blueprint-plataforma-laboratorios-mg.md)
(Blueprint Laboratorios M&G, versión preliminar; se cierra al final de la fase 0).

---

## Product

### I. Seven domains — follow strictly

The API is a modular monolith of **exactly seven** business domains (bounded
contexts). Packages, HTTP seams, ownership of data/rules, and Speckit slices
MUST map to these names. Do **not** invent an eighth domain, merge two domains
into one package, or park business rules in `shared/` / `workers/` / a sibling
repo without an explicit constitution amend.

| # | Domain (ES) | Package / path | Owns |
|---|-------------|----------------|------|
| 1 | Plataforma | `app/domains/platform` · `/v1/...` under platform | Company, sites, laboratories, numbering sequences, settings, audit port consumption, signers config |
| 2 | Clientes y comercial | `app/domains/customers` | Customers, sites, contacts, documents, requests, quotes, change requests |
| 3 | Normas y catálogo | `app/domains/catalog` | Standards, versions, customer specifications (cuadernos), tests, prices, accreditations |
| 4 | Muestras | `app/domains/samples` | Orders, receptions (RCP), samples, sample lifecycle / sheet, transfers, retained samples |
| 5 | Laboratorio | `app/domains/laboratory` | Planning, assignment, equipment/metrology, Excel templates, test execution results |
| 6 | Informes y entrega | `app/domains/reports` | Report draft→sign→issue, QR, modified reports, delivery/payment ports, e-invoice ports |
| 7 | Comunicaciones | `app/domains/communications` | COM registry, association to orders, **who/channel/template** decisions, outbound **commands** to notifications |

**Not a domain**

- **Analytics** — read-only capability over domain data (MVP: basic pending lists).
  MUST NOT become `app/domains/analytics` with its own write model.
- **`labsmyg-notifications`** — delivery mechanics only (email, WhatsApp, SMS,
  Teams, push). MUST NOT decide recipients, business templates, or COM identity.
- **Keycloak / `labsmyg-idm`** — credentials and realms. Business role
  assignments (site, laboratory, test type) live in platform/authorization here.

**Transversal (shared, not domains):** files/documents, approvals engine (link +
OTP), AI ports, PDF generation helpers, domain events/outbox. They serve all
domains; they MUST NOT own sample/order/customer aggregates.

Rationale: Blueprint §2 — small team, clear ownership, phaseable delivery,
architecture test that one domain never imports another’s internals.

#### I-a. Hard boundary rules

1. **Laboratory never receives client identity.** Codes of sample/test only.
   Customer notebooks (cuadernos) show the laboratory-neutral version; original
   PDF only with “view confidential data”. API response models MUST enforce this.
2. **Audit is append-only.** Every write use case emits audit in the **same
   transaction**. Nobody — including admins — updates or deletes audit rows.
3. **Catalog publishes versions; consumers freeze them.** Quotes, tests, and
   reports store the version used; later catalog edits MUST NOT rewrite issued work.
4. **Customers signals “request registered”; Samples creates the order.** If a
   sample arrives without a request, Samples creates the order and asks Customers
   for the quote.
5. **Communications decides; notifications sends.** Outbound customer notices
   are a command to the notifications queue (not via the event bus). COM stays
   in this monolith.
6. **State changes are commands**, not a bare PATCH of a `status` field.
   Invalid transitions → 409 (or documented conflict).
7. **Logical delete / void only.** No physical delete of business rows from the
   app. Issued documents are **voided**, not erased. Retention / Ley 1581
   anonymization is a controlled exception with audit evidence.

#### I-b. Who issues which number

| Identifier | Owning domain | When |
|------------|---------------|------|
| Quote number | Customers | On quote create (even if never accepted) |
| Internal order number | Samples | On quote request, or on sample arrival without request |
| M&G sample code | Samples | On reception intake |
| Test id (e.g. 267498-03) | Laboratory | When planning tests |
| Report number | Reports | When issuing the report |
| COM-… | Communications | On send, receive, or manual register |
| RCP-… | Samples | On package reception |

Platform owns the **numbering service** (global sequences, concurrency-safe,
site-independent). Each domain asks for a number; it does not maintain a
private counter. Every record also has a technical UUID not shown to users.

#### I-c. Design principles (always on)

| Principle | Practice |
|-----------|----------|
| Traceable by design | Audit from day one; no silent writes |
| AI proposes, a person decides | AI never approves, signs, or sends compromising output alone |
| Configurable before coded | Sites, labs, roles, signers, deadlines, templates, policies in data |
| Confidentiality by default | Analyst without client identity; notebooks restricted |
| Coexist and absorb | Migrate in slices; absorb metrology/intake that works |
| Simple to operate | One modular core + notifications service; managed cloud |

#### I-d. Source language and glossary

Source (Python, SQL identifiers in new migrations, comments, logs, OpenAPI
operation ids / tags / property names, events e.g. `sample.received`,
`test.completed`, `report.issued`, test names) MUST be **English**.

User-facing errors and messages default to **Spanish** (i18n-ready).

Canonical glossary (UI/business ES → code EN) lives in
[`docs/domain-glossary.md`](../../docs/domain-glossary.md). New terms MUST be
added there in the same change that introduces them. Examples:

| ES | EN (code / API) |
|----|-----------------|
| Orden | `order` |
| Muestra | `sample` |
| Ensayo | `test` |
| Cotización | `quote` |
| Cuaderno de carga | `customer_specification` |
| Contramuestra | `retained_sample` |
| Sede | `site` |
| Informe | `report` |

Do not invent parallel English synonyms for the same concept (`assay` vs `test`).

#### I-e. Forbidden shortcuts

- No `/v1/ai`, `/v1/ops`, or grab-bag `/v1/misc` for business behavior.
- No cross-domain table joins that bypass the owning domain’s application
  service (workers consume **events** or call application services).
- No putting COM, quote, or order rules inside `labsmyg-notifications`.
- No new bounded context without amending **I** and the active feature’s
  Product Conflict Check.

---

## Architecture & Data

### II. Modular monolith + hexagonal ports

One deployable API (plus workers in this repo). Domain folders are the seams.
External systems (SES is **not** called from here — notifications is;
S3, Bedrock, e-invoice, signing, payment gateways, Keycloak Admin beyond JWT)
MUST use a **port + adapter**. Domain/use-case code depends only on the port.

MySQL/MariaDB is the system of record (exact engine version: phase-0 pending).
EventBridge + SQS via outbox; not full event sourcing. State in DB; history in
audit.

### II-b. Options before locking the plan

For new capabilities, specify/plan MUST surface options (owning domain, sync vs
async, port vs in-process, idempotency) and record the choice in `plan.md`.
Options MUST stay inside this constitution (seven domains, monolith, logical
delete, AI human-in-the-loop).

---

## Identity & Access

### II-c. JWT from Keycloak; business authz here

Authentication is OIDC/JWT from `labsmyg-idm`. Access tokens MUST carry a
non-empty `sub` and audience `labsmyg-api`. Realms:

| Realm | Who |
|-------|-----|
| `myg` | M&G laboratory users (MFA TOTP required) |
| `cloud` | Technical/ops tooling (e.g. Grafana) |
| customers | Deferred («mis informes») — not MVP |

Business authorization (module × action × site × laboratory × test type, and
“view confidential data”) lives in **this** API (platform / shared), not in
Keycloak mappers as the sole control. Keycloak roles may seed coarse groups;
fine-grained assignments are data here.

Staff/users are managed from the backoffice via Keycloak Admin API — the
Keycloak admin console is not the daily path (`labsmyg-idm` specs).

---

## Quality

### III. Spec-driven changes

Every product or code change attaches to a `specs/` slice (specify → plan, with
Product Conflict Check → tasks → implement). Do not land behavior that only
exists in chat. Product Conflict Check MUST fail if a change crosses domain
ownership or invents a domain not in **I**.

### IV. Honest quality

A red result is a signal about behavior. Do not “fix” it by weakening
assertions, skipping the real check, or hardcoding expectations that ignore the
system under test. Coded behavior needs an automated regression test.
Docs-only changes may skip tests.

Architecture MUST include an automated check that one domain package does not
import another domain’s `infrastructure` (or equivalent internals).

### V. Quality gates

| Command | When |
|---------|------|
| `make quality` | Pre-push, CI, release images, and claiming done. Ruff + Black + Pylint + pytest, global coverage ≥90% on `app/`. |
| `make quality-fast` | Local iteration only. Diff coverage ≥90% on changed `app/` lines. Not a substitute for `make quality`. |
| `make audit` | Dependency and Bandit audit. Separate from `quality`. Pre-push runs `pip-audit` when `pyproject.toml` or `uv.lock` change. |

Dockerfiles and CI call `make quality`. They do not inline Ruff or pytest.

---

## Ownership

### VI. Sibling ownership

This repo owns the **core** domain API and workers. Shared delivery workflows
live in `labsmyg-pipe-templates`. Shared AWS primitives live in
`labsmyg-tf-modules` and are wired from `labsmyg-iac`. Identity configuration
lives in `labsmyg-idm`. Outbound delivery mechanics live in
`labsmyg-notifications`. Browser clients live in `labsmyg-core-front`.

Cloud account layout, VPC, RDS, SES DNS, ECS wiring → **iac specs**, not here.
Reusable `aws_*` modules → **tf-modules**, not duplicated here.

---

## Governance

This constitution supersedes ad-hoc practice in this repo. Amendments update
this file, bump the version (MAJOR if domain map or boundary rules change),
and call out the migration in the active feature’s plan Product Conflict Check.
