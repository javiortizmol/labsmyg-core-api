# Feature Specification: Motor de aprobaciones con enlace y código

**Feature Branch**: `009-approvals-engine`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 1 (cotizaciones); reutilizable fases 2 y 4
**Fuente**: Blueprint «Plataforma de gestión de Laboratorios M&G», octubre 2026, versión preliminar. Se cierra al final de la fase 0.
**Idioma**: spec funcional en español. Código, API, tablas, eventos y docs técnicas en inglés.

## User Scenarios & Testing

### User Story 1 - Enlace de un solo propósito (Priority: P1)

Enlace opaco ≥128 bits, un propósito, con vencimiento y revocación; solo se guarda la huella.

### User Story 2 - Código al correo registrado (Priority: P1)

Código de un solo uso al correo del contacto; TTL minutos; bloqueo por intentos; evidencia en COM y auditoría.

## Requirements

- **FR-001**: Enlaces opacos, un propósito, vencimiento (ej. 7 días), revocables.
- **FR-002**: Solo huella del identificador.
- **FR-003**: Código al correo registrado; nunca a un correo tecleado en el momento.
- **FR-004**: Límite de intentos; sesión corta atada al navegador.
- **FR-005**: Evidencia en COM + auditoría.
- **FR-006**: Idempotencia.
- **FR-007**: Errores indistinguibles (inválido/vencido/revocado).

## Related

005 · 008 · notifications 005 · front 007-public-portal  
ER: [`docs/domain-er-model.md`](../../docs/domain-er-model.md) (approval_challenge) · `025-domain-er-model`
