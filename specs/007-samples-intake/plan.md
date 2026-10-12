# Implementation Plan: Órdenes, recepción y hoja de vida

**Branch**: `007-samples-intake` | **Date**: 2026-10-12 | **Spec**: [spec.md](./spec.md)

## Summary

Domain `samples` with explicit state machine. Reception captures guide data via
photo (carrier guide or courier-app screen) + document-read propose, or manual
form. Not Mandado-style web/Places search.

## Constitution Check

| Gate | Status | Notes |
|------|--------|-------|
| AI proposes, human decides | Pass | Always ask “quedó bien?” — even on successful extract |
| AI-first + manual fallback | Pass | FR-011/012; manual always; no auto-commit |
| No SES from API | Pass | |
| Samples owns order/RCP | Pass | |

## Product Conflict Check

| Conflict area | Check | Status | Notes / resolution |
|---------------|-------|--------|--------------------|
| Constitution | No web-search SoT | Pass | Explicit vs Mandado Gemini |
| Cross-feature | `014` document read | Pass | Port owns extract; samples owns confirm |
| Front `005` | Camera capture UI | Pass | Align capture kinds |
| Blueprint § guía | Photo/PDF + confirm | Pass | + courier app screenshot path |
| Earlier plan “F1 sin IA guía” | Amended | Pass | Assist allowed with mandatory manual |
| Quality / TDD | Later | Pass | |
| Breaking | Additive | Pass | |

**Related specs reviewed**: `010` `014` `019` front `005` `015`

**Unresolved conflicts**: none
