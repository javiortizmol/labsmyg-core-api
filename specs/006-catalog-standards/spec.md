# Feature Specification: Normas, ensayos y precios

**Feature Branch**: `006-catalog-standards`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 1 catálogo mínimo; vigilancia/IA fase 2
**Fuente**: Blueprint «Plataforma de gestión de Laboratorios M&G», octubre 2026, versión preliminar. Se cierra al final de la fase 0.
**Idioma**: spec funcional en español. Código, API, tablas, eventos y docs técnicas en inglés.

## User Scenarios & Testing

### User Story 1 - Publicar norma y ensayos (Priority: P1)

Calidad registra norma por país con versión, ensayos, unidades, destructivo y precio por sede.

### User Story 2 - Cuaderno de carga neutro (Priority: P1)

PDF original solo con permiso confidencial; analista ve versión de laboratorio con código neutro.

### User Story 3 - Acreditación y versión anterior (Priority: P2)

Informar como acreditado solo si el alcance cubre la versión. Versión anterior con motivo + aceptación del cliente.

## Requirements

- **FR-001**: Normas versionadas por país con estado y fechas.
- **FR-002**: Ensayo: destructivo, unidades, tipo de equipo requerido.
- **FR-003**: Precio por ensayo, sede y vigencia.
- **FR-004**: Cuaderno: código neutro + versión laboratorio + PDF restringido.
- **FR-005**: Consumidores congelan la versión usada.
- **FR-006**: Acreditación consultable por cobertura.
- **FR-007**: Versión no vigente exige motivo + aceptación.

## Pending

Fuente de vigilancia de normas · reglas de precio/ensayos en curso · cliente que no responde.

## Related

005 · 014 (fase 2) · 012 · front 004
