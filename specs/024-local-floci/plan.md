# Implementation Plan: Local Floci AWS Emulator

**Branch**: `024-local-floci` | **Date**: 2026-10-12 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `/specs/024-local-floci/spec.md`

## Summary

Add an optional Docker Compose profile `aws-emulator` that runs [Floci](https://github.com/floci-io/floci) on port `4566`, with Makefile helpers and `.env.example` so local AWS SDK/CLI traffic can target the emulator without a cloud account—same shape as Mandado.

## Technical Context

**Language/Version**: N/A (Compose + shell); API remains Python 3.14 / uv  
**Primary Dependencies**: Docker, `floci/floci:latest`, AWS CLI optional for smoke  
**Storage**: Floci volume `labsmyg_api_floci` (`FLOCI_STORAGE_MODE=hybrid`)  
**Testing**: Manual smoke (`aws`/`curl`); no pytest dependency on Floci for unit suite  
**Target Platform**: Developer macOS/Linux with Docker  
**Project Type**: Local devops tooling  
**Performance Goals**: Emulator ready &lt; 30 s  
**Constraints**: Optional profile; never required for `make quality`  
**Scale/Scope**: Single Compose service + docs/Makefile

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- Dev tooling only; does not invent an eighth domain — Pass  
- Source/docs English for env keys and Compose — Pass  
- Production AWS stays in `labsmyg-iac` / `labsmyg-tf-modules` — Pass  
- Quality gate unchanged (`make quality` does not need Floci) — Pass  

## Product Conflict Check

*GATE: Must pass before tasks/implement.*

| Conflict area | Check | Status | Notes / resolution |
|---------------|-------|--------|--------------------|
| Constitution | No principle diluted or bypassed | Pass | Emulator is local; cloud ownership unchanged |
| Vocabulary | Source identifiers English | Pass | `floci`, `AWS_ENDPOINT_URL`, Makefile targets |
| Ownership | Correct repo owns the change | Pass | Local API/dev compose lives in `labsmyg-core-api`; real AWS in IaC |
| Auth / roles | Realms/session unchanged | N/A | No Keycloak change |
| Application security | No cross-tenant leak / impersonation | Pass | Test credentials only; example values never production secrets |
| Cross-feature FR/SC | No contradiction with related specs | Pass | Complements `001` bootstrap and `011` events; does not replace outbox |
| Sibling repos | Coherent with Mandado / IaC | Pass | Mirrors Mandado Floci profile; IaC remains source of truth for prod |
| Quality / TDD | Coded behavior tested | Pass | Smoke documented; unit suite stays offline |
| Breaking UX / API | No public API break | Pass | Opt-in profile |

**Related specs reviewed**: `001-api-bootstrap`, `011-domain-events-workers`, `010-files-documents`; IaC `001-aws-foundation` (region TBD)

**Unresolved conflicts**: none

## Project Structure

### Documentation (this feature)

```text
specs/024-local-floci/
├── plan.md
├── research.md
├── quickstart.md
├── spec.md
└── tasks.md
```

### Source Code (repository root)

```text
docker-compose.yml
.env.example
Makefile          # floci-* targets
README.md         # Local AWS section
docs/local-aws-floci.md
```

## Complexity Tracking

N/A — mirrors existing Mandado pattern; no new abstractions.
