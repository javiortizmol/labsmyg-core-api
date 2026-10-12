# Implementation Plan: Migración y convivencia con sistemas PHP

**Branch**: `021-migration-coexistence` | **Date**: 2026-10-12 | **Spec**: [spec.md](./spec.md)

## Summary

Parallel track to MVP. **No ETL / no invented source mappings** until inspection of
(1) PHP code, (2) current mounted DB, (3) metrology legacy. Then: assessment
docs, idempotent load scripts, cutover criteria. No permanent migration microservice.

## Constitution Check

| Gate | Status | Notes |
|------|--------|-------|
| No 8th domain | Pass | tools/scripts + jobs under existing domains |
| Speckit | Pass | Spec updated; build gated |
| Ownership | Pass | core-api owns runbooks; IdM users; iac only if sync infra |

## Product Conflict Check

| Conflict area | Check | Status | Notes / resolution |
|---------------|-------|--------|--------------------|
| Constitution | No migration domain | Pass | |
| Vocabulary | English script ids | Pass | |
| Ownership | core-api scripts | Pass | |
| Cross-feature | MVP specs unblocked | Pass | FR-006: parallel; does not block MVP cut |
| Metrology | F4 after inspection | Pass | Not forced into MVP loads |
| Sibling | idm users F1 after diagnosis | Pass | |
| Quality / TDD | Scripts later with tests | Pass | Gate before code |
| Breaking | N/A until cutover | Pass | |

**Related specs reviewed**: `015`, `005`–`007`, `012`, idm `002`

**Unresolved conflicts**: none (work **blocked on access**, not on product conflict)

## Blockers (not conflicts)

- Read access: PHP codebase, mounted DB, metrology data/systems
