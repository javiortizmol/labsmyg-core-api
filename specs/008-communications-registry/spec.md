# Feature Specification: Registro de comunicaciones y avisos

**Feature Branch**: `008-communications-registry`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 1 mínimo (COM + correo); bandeja/WhatsApp/asistente fase 3
**Fuente**: Blueprint «Plataforma de gestión de Laboratorios M&G», octubre 2026, versión preliminar. Se cierra al final de la fase 0.
**Idioma**: spec funcional en español. Código, API, tablas, eventos y docs técnicas en inglés.

## User Scenarios & Testing

### User Story 1 - Toda comunicación tiene COM (Priority: P1)

Al enviar, recibir registrado o cargar nota manual nace COM asociado a la orden cuando se conoce.

### User Story 2 - Aviso de negocio por correo (Priority: P1)

El dominio decide destinatario/canal/plantilla y deja comando en la cola de notifications. No habla con SES.

### User Story 3 - Resultado de entrega (Priority: P2)

Consumir enviado/entregado/leído/fallido y guardarlo en el COM; descartar versiones atrasadas.

## Requirements

- **FR-001**: Emitir COM al registrar o al ordenar envío.
- **FR-002**: Asociar a orden/muestra/cliente.
- **FR-003**: Reglas de destinatario/canal/plantilla en este dominio.
- **FR-004**: Comando a cola de `labsmyg-notifications` con versión e idempotencia; sin llamar al proveedor.
- **FR-005**: Consumir resultados y actualizar COM.
- **FR-006**: Idempotencia.
- **FR-007**: Contacto inactivo no es destinatario.

## Related

notifications 001–005 · 007 · 011 · front 006
