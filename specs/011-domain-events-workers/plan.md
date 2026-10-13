# Implementation Plan: Eventos de dominio, outbox y workers

**Branch**: `011-domain-events-workers` | **Date**: 2026-10-12 | **Spec**: [spec.md](./spec.md)

**Input**: Blueprint §6 + evaluación de no-pérdida / idempotencia.

## Summary

At-least-once via transactional outbox + publisher ACK-then-mark + per-consumer
inbox. Same repo workers. Local: Floci (`024`). Reliability policy:
[`docs/event-delivery-reliability.md`](../../docs/event-delivery-reliability.md).

## Technical Context

**Language/Version**: Python (API/workers) · MySQL  
**Primary Dependencies**: EventBridge, SQS, Scheduler  
**Storage**: `outbox_message`, consumer inbox, due-jobs  
**Testing**: Crash/replay/duplicate delivery tests when implementing  
**Constraints**: No dual-write; no silent drop; no exactly-once claim  
**Scale/Scope**: Fase 1 bus + first jobs

## Constitution Check

| Gate | Status | Notes |
|------|--------|-------|
| Seven domains | Pass | Outbox is transversal shared |
| Audit same TX | Pass | FR-001 with audit |
| Events not ES | Pass | FR-004 |
| Notifications commands | Pass | FR-012 / Q-04 not via bus |

## Product Conflict Check

| Conflict area | Check | Status | Notes / resolution |
|---------------|-------|--------|--------------------|
| Constitution | I-a.2 audit; II outbox | Pass | Amended II-c delivery |
| Vocabulary | English event types / table names | Pass | |
| Ownership | API owns outbox/inbox; iac owns bus/queues | Pass | |
| Auth / roles | Unchanged | Pass | |
| Application security | Consumers use same authz as user context where needed | Pass | No privilege via worker |
| Cross-feature FR/SC | `022` HTTP keys ≠ inbox; `008` commands | Pass | FR-012/015 |
| Sibling repos | notif inbox/outbox for send results; iac DLQ/archive | Pass | Pointers in spec |
| Quality / TDD | Duplicate + crash tests when coded | Pass | tasks T006+ |
| Delivery / idempotency | Transversal outbox/inbox for all future slices | Pass | This spec *is* the SoT |
| Breaking UX / API | None | Pass | |

**Related specs reviewed**: `008`, `022`, `024`, `025`, iac `002`/`004`, notif `001`/`006`

**Unresolved conflicts**: none

## Project Structure

```text
docs/event-delivery-reliability.md
specs/011-domain-events-workers/
```
