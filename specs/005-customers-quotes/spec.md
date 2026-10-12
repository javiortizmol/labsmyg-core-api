# Feature Specification: Clientes, solicitudes y cotizaciones

**Feature Branch**: `005-customers-quotes`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 1 mínimo; segmentación/inactivos fase 2
**Fuente**: Blueprint «Plataforma de gestión de Laboratorios M&G», octubre 2026, versión preliminar. Se cierra al final de la fase 0.
**Idioma**: spec funcional en español. Código, API, tablas, eventos y docs técnicas en inglés.

## User Scenarios & Testing

### User Story 1 - Alta sin duplicar (Priority: P1)

Registrar empresa/persona/exterior con sedes y contactos tras buscar coincidencias.

### User Story 2 - Cotización obligatoria (Priority: P1)

Toda orden a ejecutar tiene cotización registrada. Aceptación por motor de enlaces o por llegada de muestra con cotización en curso.

### User Story 3 - Solicitud de cambio (Priority: P2)

Agregar/quitar ensayos versiona la cotización y exige nueva aceptación.

## Requirements

- **FR-001**: Tipos empresa (NIT), persona (cédula), exterior.
- **FR-002**: Deduplicación antes de crear; fusión solo explícita.
- **FR-003**: Sedes/contactos se inactivan, no se borran; contacto inactivo no aprueba ni recibe.
- **FR-004**: Política de pago por cliente/sede (cobro = fase 4).
- **FR-005**: Solicitud → evento/comando para que muestras cree la orden; si muestra sin solicitud, muestras pide cotización.
- **FR-006**: Cotización con número, líneas de catálogo y versiones congeladas.
- **FR-007**: Aceptación vía `009` o regla de llegada de muestra, con COM como evidencia.
- **FR-008**: Excepciones de aceptación previa configurables por cliente.

## Pending

Identificación/factura/cobro de clientes exterior · cobro al quitar ensayo · recotización por cambio de norma.

## Related

006 · 007 · 009 · front 003 · portal 007  
ER: [`docs/domain-er-model.md`](../../docs/domain-er-model.md) (customer, quote, request) · `025-domain-er-model`
