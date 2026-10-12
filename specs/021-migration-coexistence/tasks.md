# Tasks: Migración y convivencia con sistemas PHP

**Input**: [spec.md](./spec.md) · [plan.md](./plan.md)

## Phase 0: Gate (before any ETL design)

- [x] T000 Document parallel-to-MVP + inspection gate (código PHP, DB montada, metrología)
- [ ] T001 Acceso lectura: código PHP actual
- [ ] T002 Acceso lectura: base de datos montada (inventario tablas / calidad)
- [ ] T003 Acceso lectura: metrología legado (alcance F4)
- [ ] T004 Checklist assessment fase 0 (salidas: inventario → entidades MYG, gaps, riesgos)

## Phase 1: Plan de carga (después del gate)

- [ ] T005 Inventario tablas origen → mapeo entidades
- [ ] T006 Plan de carga por entidad/fase (metrología queda F4)
- [ ] T007 Criterios de validación de corte

## Phase 2: Implementación (cuando haya acceso + plan)

- [ ] T008 [piloto] scripts ETL clientes
- [ ] T009 Sync convivencia solo-lectura (`011`) si aplica
