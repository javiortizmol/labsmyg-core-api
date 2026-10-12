# Feature Specification: Permisos por rol, sede y confidencialidad

**Feature Branch**: `004-authorization`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 1 — Plataforma
**Fuente**: Blueprint «Plataforma de gestión de Laboratorios M&G», octubre 2026, versión preliminar. Se cierra al final de la fase 0.
**Idioma**: spec funcional en español. Código, API, tablas, eventos y docs técnicas en inglés.

## User Scenarios & Testing

### User Story 1 - Permiso módulo × acción × alcance (Priority: P1)

Usuario opera solo si el rol da la acción en sede/laboratorio/tipo de ensayo.

### User Story 2 - Analista no ve al cliente (Priority: P1)

APIs de laboratorio no exponen identidad, cuadernos originales ni códigos de cliente.

### User Story 3 - Roles predefinidos y separación de deberes (Priority: P2)

Roles de fábrica inmutables (copiables). Quien ejecutó no revisa ni firma. Admin no se auto-otorga.

## Requirements

- **FR-001**: Permiso = módulo × acción, limitable por sede, laboratorio y tipo de ensayo.
- **FR-002**: «Ver datos confidenciales» aparte.
- **FR-003**: Roles predefinidos inmutables: gerencia, calidad, comercial, servicio al cliente, recepción, recepción técnica, director de laboratorio, analista, firmante, administrador.
- **FR-004**: Modelos de respuesta distintos por permiso.
- **FR-005**: Rechazar autorrevisión, autofirma y auto-otorgamiento.
- **FR-006**: Cambios de rol auditados.
- **FR-007**: Sede activa validada (incluye acceso temporal con fechas).
- **FR-008**: 12 acciones: ver, crear, editar, eliminar, restaurar, anular, aprobar, firmar, enviar, descargar, exportar, configurar.

## Related

idm realms myg/cloud · front 002 (sede activa)
