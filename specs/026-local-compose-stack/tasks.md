# Tasks: Local Docker Compose stack

**Input**: [plan.md](./plan.md) · [spec.md](./spec.md)
**Prerequisites**: plan with Product Conflict Check Pass

## Phase 1: Setup

- [x] T001 Write `spec.md` / `plan.md` / `tasks.md` for `026-local-compose-stack`
- [x] T002 Point `.specify/feature.json` at `specs/026-local-compose-stack`

## Phase 2: Foundational (US1 / US2)

- [x] T003 [P] Add `docker/mysql/init/01-schemas.sql` (`labsmyg` + `labsmyg_audit`)
- [x] T004 Expand `docker-compose.yml` with `mysql` (8.4) + volume + healthcheck
- [x] T005 Update `.env.example` with DB URLs and host port
- [x] T006 Makefile: `up`, `up-aws`, `down`, `logs`, `ps`, `reset` (keep `floci-*`)

## Phase 3: Docs (US3)

- [x] T007 Add `docs/local-compose.md`; link from `docs/local-aws-floci.md`
- [x] T008 Smoke: `make up` → MySQL healthy; both schemas reachable

## Phase 4: Polish

- [x] T009 Note deferred `api` service until `001` health exists; constitution: MySQL
- [ ] T010 Commit when user asks (include prior Floci WIP if still uncommitted)

## Dependencies

T001 → T003–T006 → T007–T008 → T009
