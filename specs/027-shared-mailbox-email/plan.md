# Implementation Plan: Buzón operativo compartido

**Branch**: `027-shared-mailbox-email` | **Date**: 2026-10-12 | **Spec**: [spec.md](./spec.md)

## Summary

Lock product decision in core-api specs (`008`/`010`/ER/`015`) and sibling
pointers. No application code in this slice.

## Constitution Check

| Gate | Status | Notes |
|------|--------|-------|
| SES not from core-api | Pass | Inbound event only; send via notifications |
| Ownership | Pass | COM/docs here; SES mechanics in notifications; DNS in iac |
| Speckit | Pass | Spec/plan/tasks + sibling amends |

## Product Conflict Check

| Conflict area | Check | Status | Notes / resolution |
|---------------|-------|--------|--------------------|
| Constitution | No SES in core-api | Pass | Event consumer only |
| Vocabulary | English ids | Pass | `email.message.received`, COM direction |
| Ownership | Correct repos | Pass | Amends point to notif `006`, iac `001` |
| Auth / roles | Unchanged | N/A | |
| Application security | Attachments via documents port | Pass | No raw public links |
| Cross-feature | `008`/`010`/`015` | Pass | Specs amended together |
| Sibling repos | notif constitution 1.2.0 | Pass | Receipt mechanics allowed |
| Quality / TDD | Docs-only | N/A | |
| Breaking | Additive | Pass | |

**Related specs reviewed**: `008` `010` `015` `025`; notif `002` `006`; iac `001`

**Unresolved conflicts**: none

## Project Structure

```text
specs/027-shared-mailbox-email/
# amends: specs/008, 010, 015, docs/domain-er-model.md
```
