# Implementation Plan: Domain-aligned ER model

**Branch**: `025-domain-er-model` | **Date**: 2026-10-12 | **Spec**: [spec.md](./spec.md)

## Summary

Publish a provisional ER model grouped by the seven Labs MYG domains plus
transversal `audit` / `documents` / `approvals` / `outbox`, marking MVP vs later
phases and questionnaire TBDs — no migrations in this slice.

## Technical Context

**Language/Version**: Markdown + Mermaid  
**Storage**: Design only (MySQL/MariaDB later)  
**Testing**: Doc review / Speckit analyze  
**Project Type**: Design artifact  

## Constitution Check

- Seven domains — Pass  
- Audit append-only + separate logical schema — Pass  
- Lab without client identity — Pass  
- English table names — Pass  

## Product Conflict Check

| Conflict area | Check | Status | Notes |
|---------------|-------|--------|-------|
| Constitution | Domain ownership | Pass | Grouped by domain |
| Vocabulary | English identifiers | Pass | |
| Ownership | core-api owns ER docs | Pass | |
| Auth / roles | Keycloak ids as refs only | Pass | |
| Application security | No client identity in lab tables | Pass | |
| Cross-feature | Aligns 003/010/011 | Pass | |
| Sibling repos | IdM/notifications not owning business tables | Pass | |
| Quality / TDD | Docs-only | Pass | |
| Breaking UX / API | None | Pass | |

**Related specs reviewed**: `003`, `010`, `011`, `015`, blueprint data model

**Unresolved conflicts**: none

## Project Structure

```text
docs/domain-er-model.md
specs/025-domain-er-model/{spec,plan,tasks}.md
```
