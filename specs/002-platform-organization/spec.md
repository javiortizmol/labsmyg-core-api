# Feature Specification: Organización, configuración y numeración

**Feature Branch**: `002-platform-organization`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 1 — Plataforma
**Fuente**: Blueprint «Plataforma de gestión de Laboratorios M&G», octubre 2026;
  decisión producto: tipos de laboratorio + CRUD para montar otro sin redeploy.
**Idioma**: spec funcional en español. Código, API, tablas, eventos y docs técnicas en inglés.

## Decision — tipos de laboratorio (realidad M&G)

Laboratorios M&G **ya opera varios tipos de laboratorio** (publicado en
[laboratoriosmyg.com](https://laboratoriosmyg.com/)). Por eso el modelo
**MUST** distinguir:

1. **Tipo de laboratorio** (`laboratory_type`) — catálogo CRUD: código + nombre
   + activo. Refleja las clases que M&G tiene (y las que pueda añadir).
2. **Laboratorio** (instancia) — CRUD: un lab concreto de un tipo, en sede(s)
   (FR-003). Puede haber varias instancias del mismo tipo (otra sede, ampliación).
3. **Empresa** y **sede** — US1.

Alta/cambio de tipo o de instancia = datos (API/UI admin), **sin redeploy**.
Baja = logical delete / inactive. Numeración, authz, firmantes y catálogo
usan `laboratory_id` (y pueden filtrar por tipo).

**No** confundir con **tipo de ensayo** (`004` / `017`) — eso es el ensayo
analítico; el tipo de laboratorio es la **unidad de negocio/operación** de M&G.

### Semilla inicial de tipos (sitio público — editable por CRUD)

Códigos en inglés; nombres UI en español. Ops puede renombrar/activar/añadir.

| code | name (ES) |
|------|-----------|
| `toys` | Laboratorio de Juguetes |
| `physicochemical` | Laboratorio de Fisicoquímica |
| `microbiology` | Laboratorio de Microbiología |
| `food` | Laboratorio de Alimentos |
| `textile` | Laboratorio Textil |
| `vehicles` | Laboratorio de Vehículos |
| `plastics_rubber_leather` | Laboratorio de Plásticos, Cauchos y Cuero |
| `helmets` | Laboratorio de Cascos |
| `electrical` | Laboratorio Eléctrico |
| `calibration` | Laboratorio de Calibración |

Fuente menú «Laboratorios» en laboratoriosmyg.com (2026-10). «Calibración»
cubre metrología/presión del discurso público; no inventar un undécimo tipo
hasta que ops lo confirme.

## User Scenarios & Testing

### User Story 1 - Empresa, sedes y laboratorios (Priority: P1)

Administrador registra empresa legal, sedes y laboratorios con país, moneda,
zona horaria e idioma, sin redeploy.

**Independent Test**: Crear empresa, dos sedes y un laboratorio en ambas.

### User Story 1b - Varios tipos de laboratorio M&G (Priority: P1)

Admin mantiene el catálogo de **tipos** que M&G opera y las **instancias**
(laboratorio por tipo/sede). Puede registrar un tipo que aún no estaba o una
nueva instancia sin tocar código.

**Independent Test**: Dos tipos activos (A, B); un laboratorio de cada uno;
listar filtrando por tipo; inactivar una instancia → sale de selectores; el
tipo B sigue disponible para otra instancia.

### User Story 2 - Números únicos (Priority: P1)

Cualquier dominio pide un número (cotización, orden, muestra, ensayo, informe,
COM, recepción) y recibe el siguiente de una secuencia global, concurrente e
independiente de sede.

**Independent Test**: Dos peticiones concurrentes → valores distintos.

### User Story 3 - Parámetros operativos (Priority: P2)

Ajustar plazos y políticas (sesión 8h, inactividad 60 días) desde datos.

## Requirements

- **FR-001**: Modelo Empresa › Sedes › Laboratorios (+ tipos).
- **FR-002**: Config por sede: país, moneda, impuestos, TZ, idioma, ubicaciones
  de contramuestras; facturador/firma/acreditación como config aunque
  adaptadores lleguen en fase 4.
- **FR-003**: Laboratorio puede operar en una/varias/todas las sedes.
- **FR-004**: Numeración configurable, única en todo M&G, segura ante
  concurrencia. Facturas se numeran por empresa (fase 4).
- **FR-005**: UUID técnico distinto del código legible.
- **FR-006**: Settings con defaults (inactividad 60 días, sesión 8h, alerta
  firmante 1 día hábil).
- **FR-007**: Escrituras pasan por caso de uso + auditoría (`003`).
- **FR-008**: **CRUD** de `laboratory_type` (create/update/list/get; inactivate
  = logical delete). Código estable en inglés; nombre visible en español.
- **FR-009**: **CRUD** de laboratorio (instancia): create/update/list/get;
  inactivate. Campos mínimos: code, name, **laboratory_type**, site
  association(s), active. Varias instancias por tipo permitidas. Alta/cambio
  **MUST NOT** requerir deploy (M&G multi-tipo es dato, no hardcode).
- **FR-010**: OpenAPI admin: `/v1/laboratory-types` y `/v1/laboratories` (más
  companies/sites/settings ya previstos). Authz platform admin.
- **FR-011**: Outbox/audit en escrituras (transversal `011` / `003`). Idempotency
  en creates críticos (`022`) cuando aplique.
- **FR-012**: Selectores operativos (recepción, bandejas, firmantes) solo
  listan laboratorios **activos**. Histórico sigue resolviendo labs inactivos
  por id.

- **FR-013**: Seed de `laboratory_type` alineado a la tabla de la Decision
  (sitio público). Cambios posteriores solo por CRUD/admin, no por deploy.

## Pending

Laboratorio piloto · formato código de muestra · sedes en otros países ·
ops confirma si Cascos/Calibración son tipos o sub-alcances de otro.

## Related

003-audit-trail · 004-authorization · 017-platform-signers · front
002-platform-admin-ui  
ER: [`docs/domain-er-model.md`](../../docs/domain-er-model.md) · `025-domain-er-model`
