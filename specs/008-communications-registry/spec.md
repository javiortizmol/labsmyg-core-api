# Feature Specification: Registro de comunicaciones y avisos

**Feature Branch**: `008-communications-registry`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 1 mínimo (COM + correo); bandeja/WhatsApp/asistente fase 3
**Fuente**: Blueprint «Plataforma de gestión de Laboratorios M&G», octubre 2026, versión preliminar. Se cierra al final de la fase 0. Buzón compartido: `027-shared-mailbox-email` / notif `006`.
**Idioma**: spec funcional en español. Código, API, tablas, eventos y docs técnicas en inglés.

## User Scenarios & Testing

### User Story 1 - Toda comunicación tiene COM (Priority: P1)

Al enviar, recibir registrado o cargar nota manual nace COM asociado a la orden cuando se conoce.

### User Story 2 - Aviso de negocio por correo (Priority: P1)

El dominio decide destinatario/canal/plantilla y deja comando en la cola de notifications. No habla con SES. El `From` operativo lo configura notifications (`002`) = buzón compartido.

### User Story 3 - Resultado de entrega (Priority: P2)

Consumir enviado/entregado/leído/fallido y guardarlo en el COM; descartar versiones atrasadas.

### User Story 4 - Correo entrante del cliente (Priority: P1)

Consumir `email.message.received` (notifications `006`). Crear COM `direction=inbound` con metadatos (from/to/subject/message-id), refs al raw y adjuntos materializados vía `010`. Asociación a orden/cliente/muestra provisional o confirmada según reglas; sin llamar a SES.

## Requirements

- **FR-001**: Emitir COM al registrar o al ordenar envío.
- **FR-002**: Asociar a orden/muestra/cliente.
- **FR-003**: Reglas de destinatario/canal/plantilla en este dominio.
- **FR-004**: Comando a cola de `labsmyg-notifications` con versión e idempotencia; sin llamar al proveedor.
- **FR-005**: Consumir resultados y actualizar COM.
- **FR-006**: Idempotencia.
- **FR-007**: Contacto inactivo no es destinatario.
- **FR-008**: Consumir evento inbound; COM inbound idempotente por `Message-Id` / event id.
- **FR-009**: Adjuntos del inbound → documentos (`010`) ligados al COM (y a orden/muestra cuando aplique).
- **FR-010**: No parsear MIME ni poseer el bucket raw SES (eso es notifications / iac).

## Related

notifications `001`–`006` · `007` · `010` · `011` · `027` · front `006`  
ER: [`docs/domain-er-model.md`](../../docs/domain-er-model.md) (communication, com_association) · `025-domain-er-model`
