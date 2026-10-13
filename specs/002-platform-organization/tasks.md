# Tasks: Organización, configuración y numeración

**Input**: [spec.md](./spec.md) · [plan.md](./plan.md)

- [x] T000 Document M&G multi laboratory_type + CRUD instancias (no hardcode)
- [x] T000b Seed types from laboratoriosmyg.com (10 labs)
- [ ] T001 [US1] Modelo y migraciones company/site/laboratory_type/laboratory
- [ ] T001b [US1b] CRUD laboratory_type (API + tests)
- [ ] T002 [US1/US1b] Rutas admin laboratories/sites/companies con ETag
- [ ] T003 [US2] NumberService concurrente (quote, order, sample, test, report, communication, reception)
- [ ] T004 [US2] Prueba de unicidad bajo concurrencia
- [ ] T005 [US3] Settings con defaults del blueprint
- [ ] T006 Auditoría + outbox de escrituras (`003` / `011`)
