# Feature Specification: Informes, firma, QR y entrega

**Feature Branch**: `013-reports-delivery`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 4; QR de verificación puede adelantarse
**Fuente**: Blueprint «Plataforma de gestión de Laboratorios M&G», octubre 2026, versión preliminar. Se cierra al final de la fase 0.
**Idioma**: spec funcional en español. Código, API, tablas, eventos y docs técnicas en inglés.

## User Scenarios & Testing

### User Story 1 - Emitir informe (Priority: P1 en fase 4)

Borrador → revisión → aprobación → firma → número de informe → QR de verificación.

### User Story 2 - Informe modificado (Priority: P2)

Si cambian datos del cliente o hay corrección, se emite modificado (ISO 17025 7.8.8), no se reescribe el emitido.

### User Story 3 - Entrega y pago (Priority: P2)

Descarga por enlace seguro; factura electrónica y pasarela en adaptadores fase 4.

### User Story 4 - Informe preliminar (Priority: P2 en fase 4)

Cliente pide resultados parciales: documento numerado P1, P2… marcado como «Informe preliminar»; no sustituye al final y **no** cambia el estado de la orden. Quién aprueba (firmante vs director), logo de acreditación y costo adicional: **pending §17**.

## Requirements

- **FR-001**: Máquina de estados de informe; firma digital (puerto; entidad TBD).
- **FR-002**: QR verifica autenticidad sin exponer datos de más.
- **FR-003**: Acreditación en informe solo si alcance cubre.
- **FR-004**: Informes modificados; emitidos se anulan, no se borran.
- **FR-005**: Fecha de emisión: pendiente decisión calidad/legal (R3).
- **FR-006**: Pagos e factura detrás de puertos; proveedores TBD.
- **FR-007**: Informes preliminares numerados, auditados, sin avanzar la orden a «informada»; reglas de firma/logo/costo configurables tras §17.

## Pending

Fecha emisión vs aprobación técnica · entidad de firma · software factura · pasarela (hoy ZonaPAGOS) · reglas de informe preliminar (§17).

## Related

009 · 010 · 006 · front 007/009
