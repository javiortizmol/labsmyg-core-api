# Feature Specification: Órdenes, recepción y hoja de vida

**Feature Branch**: `007-samples-intake`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 1 ingreso mínimo; custodia completa fase 2; contramuestras fase 4
**Fuente**: Blueprint «Plataforma de gestión de Laboratorios M&G», octubre 2026, versión preliminar. Se cierra al final de la fase 0.
**Idioma**: spec funcional en español. Código, API, tablas, eventos y docs técnicas en inglés.

## User Scenarios & Testing

### User Story 1 - Orden con número (Priority: P1)

Orden nace al registrar solicitud o al recibir muestra sin solicitud. Cotización vencida sin aceptación/muestra → no concretada.

### User Story 2 - Ingreso con código y fotos (Priority: P1)

Registro de paquete, código M&G, fotos y hoja de vida.

### User Story 3 - Muestras por resolver (Priority: P2)

Sin cliente/orden: bandeja; no pueden ir a laboratorio.

## Requirements

- **FR-001**: Orden al registrar solicitud o al recibir sin solicitud; número único global.
- **FR-002**: Máquina de estados; transiciones por comando (no PATCH de status). Estados: solicitada, cotizada, esperando al cliente, aceptada, parcialmente recibida, en laboratorio, informada, cerrada, no concretada.
- **FR-003**: Recepción (RCP) vinculable a varias órdenes; orden en varios paquetes.
- **FR-004**: Código M&G al ingresar + hoja de vida.
- **FR-005**: Fotos vía puerto de archivos.
- **FR-006**: Por resolver bloquea paso a laboratorio.
- **FR-007**: Parcialmente recibida si lo recibido no cubre lo esperado.
- **FR-008**: Sede responsable, de recepción y de laboratorio pueden diferir.
- **FR-009**: Cierre no concretada idempotente.

## Pending

Formato código/stickers · plazos disposición · inspección sin respuesta del cliente.

## Related

002 · 005 · 010 · 011 · front 005  
ER: [`docs/domain-er-model.md`](../../docs/domain-er-model.md) (order, reception, sample) · `025-domain-er-model`
