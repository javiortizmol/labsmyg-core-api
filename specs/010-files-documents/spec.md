# Feature Specification: Documentos, archivos y generación de PDF

**Feature Branch**: `010-files-documents`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 1 almacenamiento; PDF cotización/informe según fase
**Fuente**: Blueprint «Plataforma de gestión de Laboratorios M&G», octubre 2026, versión preliminar. Se cierra al final de la fase 0.
**Idioma**: spec funcional en español. Código, API, tablas, eventos y docs técnicas en inglés.

## User Scenarios & Testing

### User Story 1 - Subida y descarga con enlace temporal (Priority: P1)

La app obtiene URL firmada para subir/bajar. Nadie recibe ruta fija. Buckets privados; Object Lock donde aplique (informes emitidos, auditoría).

### User Story 2 - PDF de cotización (Priority: P2)

Desde cotización aceptada se genera proforma/PDF en segundo plano (202 + seguimiento).

### User Story 3 - Adjuntos de correo entrante (Priority: P1)

Tras COM inbound (`008` / `027`), cada adjunto del evento se registra como
`document` (copiar o re-key desde staging inbound hacia prefijo de documentos).
El MIME raw puede quedar referenciado; la SoT de negocio son los `document_id`.

## Requirements

- **FR-001**: Puerto de archivos; solo backend lee/escribe con IAM; personas reciben URL temporal.
- **FR-002**: Buckets por sensibilidad (cuadernos más restringidos); versionado; Object Lock para emitidos/auditoría.
- **FR-003**: Metadatos en DB (`document`): key S3 estable por `document_id`, huella, FKs opcionales a customer/reception/sample/order/communication; sin bytes en MySQL. Prefijos por tipo (no carpeta cliente como SoT) — ver `docs/domain-er-model.md`.
- **FR-004**: Generación PDF (WeasyPrint o browser headless) asíncrona vía workers.
- **FR-005**: Subidas con límite de tamaño/tipo en la URL firmada.
- **FR-006**: Ingest desde refs S3 del evento inbound (notifications `006`); límites de tipo/tamaño alineados; no exponer el bucket raw al cliente.

## Related

007 fotos · 006 cuadernos · 013 informes · `008` · `027` · notif `006` · iac buckets  
ER: [`docs/domain-er-model.md`](../../docs/domain-er-model.md) (`document` + S3 prefixes) · `025-domain-er-model`
