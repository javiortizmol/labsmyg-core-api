# Tasks: Local Floci AWS Emulator

**Input**: [plan.md](./plan.md) · [spec.md](./spec.md)

## Phase 1 — Speckit artifacts

- [x] T001 Create `specs/024-local-floci` spec/plan/research/quickstart
- [x] T002 Product Conflict Check green in plan.md
- [x] T003 Point `.specify/feature.json` at `024-local-floci`

## Phase 2 — Compose & env

- [x] T004 Add `docker-compose.yml` with `floci` service (`aws-emulator` profile)
- [x] T005 Add `.env.example` AWS/Floci variables
- [x] T006 Add Makefile `floci-up|down|logs|env|reset`
- [x] T007 Document in `README.md` + `docs/local-aws-floci.md`

## Phase 3 — Verify

- [x] T008 `make floci-up` and smoke S3 (or curl health)
- [x] T009 Mark tasks complete; `make quality` still green without Floci
