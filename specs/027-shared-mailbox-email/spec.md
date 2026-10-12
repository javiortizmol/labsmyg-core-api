# Feature Specification: Buzón operativo compartido (correo in/out)

**Feature Branch**: `027-shared-mailbox-email`
**Created**: 2026-10-12
**Status**: Draft — decisión de producto documentada; build tras Aprobada
**Fase**: Fase 1 (COM + documentos); bandeja UI fase 3
**Fuente**: Decisión producto (mismo patrón mercado: dirección compartida).
**Idioma**: spec funcional en español. Identificadores técnicos en inglés.

## Summary

Una **dirección operativa compartida** recibe correo de clientes (cuerpo +
adjuntos) y es el `From` de avisos de negocio salientes. Mecánica SES inbound /
outbound vive en `labsmyg-notifications` (`006` / `002`). Este repo crea **COM
inbound**, asocia a orden/cliente cuando se conoce, y registra adjuntos como
`document` (`010`).

## User Scenarios & Testing

### User Story 1 - Correo entrante vira COM (Priority: P1)

Tras `email.message.received`, communications crea COM `direction=inbound`,
guarda hash/refs, asocia provisionalmente a orden/cliente si hay reglas, y
materializa adjuntos vía `010`.

### User Story 2 - Respuesta / aviso saliente (Priority: P1)

Avisos de negocio siguen `008` US2 → cola notifications; identidad From =
buzón operativo (notif `002`).

## Requirements

- **FR-001**: Consumir evento inbound de notifications; crear COM inbound (`008`).
- **FR-002**: Adjuntos del evento → `document` con FK opcional a communication / order / sample (`010`).
- **FR-003**: No llamar SES desde core-api (constitution).
- **FR-004**: OTP/noreply quedan fuera del buzón operativo (notif `005`).
- **FR-005**: Dominio/dirección exacta pendiente TI (§17); no inventar el FQDN.

## Related

`008` · `010` · `015` · notif `002` `006` · iac `001` · ER communications
