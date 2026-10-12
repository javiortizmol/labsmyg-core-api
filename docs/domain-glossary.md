# Domain glossary (ES → EN)

Source of truth for code, API, tables, and domain events in `labsmyg-core-api`.
User-facing copy stays in Spanish (i18n-ready). Constitution **I-d**.

| Español (negocio / UI) | English (code / API / DB / events) |
| --- | --- |
| Empresa | `company` |
| Sede | `site` |
| Laboratorio | `laboratory` |
| Usuario | `user` |
| Rol | `role` |
| Permiso | `permission` |
| Firmante | `signer` |
| Cliente | `customer` |
| Sede del cliente | `customer_site` |
| Contacto | `contact` |
| Solicitud | `request` (service request / quote request) |
| Cotización | `quote` |
| Línea de cotización | `quote_line` |
| Solicitud de cambio | `change_request` |
| Norma | `standard` |
| Versión de norma | `standard_version` |
| Cuaderno de carga | `customer_specification` |
| Ensayo (método / ítem de catálogo) | `test` / `test_method` |
| Precio | `price` |
| Acreditación | `accreditation` |
| Orden | `order` |
| Recepción / paquete | `reception` |
| Muestra | `sample` |
| Hoja de vida (de la muestra) | `sample_history` / sample lifecycle events |
| Inspección | `inspection` |
| Contramuestra | `retained_sample` |
| Traslado | `transfer` |
| Equipo | `equipment` |
| Plantilla Excel | `result_template` |
| Resultado | `result` |
| Informe | `report` |
| Informe preliminar | `preliminary_report` |
| Informe modificado | `amended_report` |
| Comunicación (COM) | `communication` |
| Aviso / envío | outbound delivery (executed by `labsmyg-notifications`) |
| Auditoría | `audit_record` |
| Aprobación (enlace + código) | `approval` |

## Domain event examples

- `sample.received`
- `test.completed`
- `report.issued`
- `quote.accepted`
- `communication.delivery_failed`

## Domains (packages)

`platform` · `customers` · `catalog` · `samples` · `laboratory` · `reports` · `communications`

Do not add a package outside this list without amending the constitution.
