# Feature Specification: Órdenes, recepción y hoja de vida

**Feature Branch**: `007-samples-intake`
**Created**: 2026-10-12
**Status**: Draft — no construir hasta Aprobada (blueprint §15)
**Fase**: Fase 1 ingreso mínimo; custodia completa fase 2; contramuestras fase 4
**Fuente**: Blueprint recepción/guía; decisión producto: captura por foto (guía o apps de domicilio) + extracción, o manual — **no** búsqueda web/Places como en Mandado.
**Idioma**: spec funcional en español. Código, API, tablas, eventos y docs técnicas en inglés.

## Decision — datos de la guía / paquete

En recepción, los datos de transportadora, número de guía, remitente, origen, etc. se obtienen así (cualquiera basta; se pueden combinar):

1. **Foto o PDF de la guía** de la transportadora → puerto de **lectura de documentos** (`014`) propone campos.
2. **Foto de la pantalla** de apps de domicilio / mensajería del mensajero → mismo puerto propone campos.
3. **Diligenciar a mano** el formulario de recepción (siempre disponible).

**No** se usa Gemini (ni otro) para “buscar” la dirección o el cliente en la web como en Mandado. La evidencia es la foto/PDF + confirmación humana.

La IA **solo propone**. Aunque la extracción “salga bien”, el sistema **siempre** muestra los campos y pregunta a recepción si quedó correcto (confirmar / editar / descartar). No hay auto-aplicar la propuesta. Si la IA falla, timeout o se omite: mismo formulario manual, sin bloqueo (`014` / constitution).

## User Scenarios & Testing

### User Story 1 - Orden con número (Priority: P1)

Orden nace al registrar solicitud o al recibir muestra sin solicitud. Cotización vencida sin aceptación/muestra → no concretada.

### User Story 2 - Ingreso con código y fotos (Priority: P1)

Registro de paquete (RCP), código M&G, fotos de muestra/paquete, hoja de vida.

### User Story 3 - Muestras por resolver (Priority: P2)

Sin cliente/orden: bandeja; no pueden ir a laboratorio.

### User Story 4 - Captura de guía / domicilio (Priority: P1)

Recepción registra paquete con datos de guía: (a) foto/PDF de guía, (b) foto de app de domicilio, y/o (c) formulario manual. Si hay foto, el sistema propone campos vía lectura de documentos y **pregunta explícitamente si quedó bien** (confirmar / corregir). Nunca persiste la propuesta como definitiva sin ese paso. Si falla o se omite IA, el mismo RCP se completa a mano.

**Independent Test**: Crear RCP solo manual; crear RCP con foto de guía mock → propuesta → UI exige confirmar/editar (no guarda sola); simular fallo del puerto → completar a mano sin bloqueo.

## Requirements

- **FR-001**: Orden al registrar solicitud o al recibir sin solicitud; número único global.
- **FR-002**: Máquina de estados; transiciones por comando (no PATCH de status). Estados: solicitada, cotizada, esperando al cliente, aceptada, parcialmente recibida, en laboratorio, informada, cerrada, no concretada.
- **FR-003**: Recepción (RCP) vinculable a varias órdenes; orden en varios paquetes.
- **FR-004**: Código M&G al ingresar + hoja de vida. El valor puede llegar
  escrito, desde **cámara del navegador** (celular/tablet/webcam) o lector
  teclado; la API no distingue el origen (front `005` / FR-002c).
- **FR-005**: Fotos vía puerto de archivos (muestra, paquete, **guía**, **captura app domicilio**).
- **FR-006**: Por resolver bloquea paso a laboratorio.
- **FR-007**: Parcialmente recibida si lo recibido no cubre lo esperado.
- **FR-008**: Sede responsable, de recepción y de laboratorio pueden diferir.
- **FR-009**: Cierre no concretada idempotente.
- **FR-010**: RCP guarda al menos: sede receptora, fecha/hora, transportadora, número de guía/tracking, remitente (texto), fotos/documentos asociados.
- **FR-011**: Tres vías de captura de datos de guía (foto guía, foto app domicilio, manual); no excluyentes.
- **FR-012**: Extracción asistida usa puerto **document read** (`014`); propuesta editable; **confirmación humana siempre** (también si la IA responde OK): UI/API MUST pedir confirmación explícita (“¿quedó bien?” / confirmar o editar) antes de fijar carrier, tracking, remitente, etc. AI-first con fallback/skip manual (constitution). **MUST NOT** auto-commit ni invocar búsqueda web/Places/geocoding como SoT de la guía.
- **FR-013**: Número de guía queda en hoja de vida / cadena de custodia.
- **FR-014**: Identificación de cliente a partir de datos de guía es propuesta + confirmación (cascada blueprint); IA no crea clientes.

## Pending

Formato código/stickers · plazos disposición · inspección sin respuesta del cliente · cuándo activar adaptador Textract/Bedrock en el piloto (puertos desde F1).

## Related

002 · 005 · 010 · 011 · 014 · front `005`  
ER: [`docs/domain-er-model.md`](../../docs/domain-er-model.md) (order, reception, sample) · `025-domain-er-model`
