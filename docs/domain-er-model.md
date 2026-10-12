# Domain-aligned ER model (provisional)

**Status**: Preliminary (fase 0). Closes with questionnaire + diagnosis.  
**Source**: Blueprint § modelo de datos · constitution Product I · `specs/025-domain-er-model`.  
**DB**: MySQL/MariaDB. Table/column names in **English**.  
**Legend**: **MVP** = fase 1 · **F4** = fase 4 · **TBD** = open questionnaire / fase 0.

## Principles

1. ER grouped by the **seven domains**; every business table has one owner.
2. **Transversal** (not domains): `audit`, `documents`, `approvals`, `outbox`.
3. Technical `id` UUID on every row; business numbers via Platform sequences.
4. Logical delete / void only (`lifecycle_status`: active | inactive | deleted | voided).
5. Laboratory tables **never** store customer identity.
6. Catalog consumers freeze `standard_version_id` (quotes, sample tests, reports).

---

## Backbone (read this first)

```mermaid
erDiagram
  CUSTOMER ||--o{ CUSTOMER_SITE : has
  CUSTOMER_SITE ||--o{ CONTACT : has
  CUSTOMER ||--o{ REQUEST : places
  REQUEST ||--o| QUOTE : may_have
  QUOTE ||--o| ORDER : accepted_as
  ORDER ||--|{ SAMPLE : contains
  RECEPTION ||--o{ SAMPLE : receives
  ORDER ||--o{ RECEPTION : linked
  SAMPLE ||--o{ LAB_ASSIGNMENT : assigned
  LAB_ASSIGNMENT ||--o{ SAMPLE_TEST : plans
  SAMPLE_TEST ||--o{ RESULT : produces
  ORDER ||--o| REPORT : issued_as
  COMMUNICATION }o--o{ ORDER : associates
```

---

## 1 · Platform (MVP)

Owns org structure, sequences, settings, signer config. **Consumes** audit; does not own audit rows’ business meaning.

```mermaid
erDiagram
  COMPANY ||--|{ SITE : has
  SITE ||--o{ LABORATORY : hosts
  SEQUENCE {
    uuid id PK
    string kind "quote|order|sample|rcp|com|report|test"
    string format
    bigint next_value
  }
  COMPANY {
    uuid id PK
    string legal_name
    string tax_id
    string country_code
  }
  SITE {
    uuid id PK
    uuid company_id FK
    string name
    string timezone
  }
  LABORATORY {
    uuid id PK
    uuid site_id FK
    string name
    string code
  }
  APP_SETTING {
    uuid id PK
    uuid site_id FK "nullable=global"
    string key
    json value
  }
  SIGNER_CONFIG {
    uuid id PK
    uuid site_id FK
    uuid user_subject "Keycloak sub"
    string role_label
  }
```

Authorization matrices (role × site × laboratory × test type) live here or in a dedicated authz package under platform — **not** in Keycloak as SoT.

---

## 2 · Customers (MVP mínimo)

```mermaid
erDiagram
  CUSTOMER ||--|{ CUSTOMER_SITE : has
  CUSTOMER_SITE ||--o{ CONTACT : has
  CUSTOMER ||--o{ CUSTOMER_DOCUMENT : legal_docs
  CUSTOMER ||--o{ CUSTOMER_ALIAS : learns
  CUSTOMER ||--o{ REQUEST : places
  REQUEST ||--o| QUOTE : yields
  QUOTE ||--|{ QUOTE_LINE : lines
  QUOTE ||--o{ CUSTOMER_APPROVAL : approvals
  ORDER ||--o{ CHANGE_REQUEST : changes
  CHANGE_REQUEST ||--o{ CUSTOMER_APPROVAL : needs

  CUSTOMER {
    uuid id PK
    string id_type "nit|cc|foreign"
    string id_number UK
    string legal_name
    string lifecycle_status
  }
  CUSTOMER_SITE {
    uuid id PK
    uuid customer_id FK
    string name
    string address
  }
  CONTACT {
    uuid id PK
    uuid customer_site_id FK
    string email
    string phone
    datetime verified_at
  }
  CUSTOMER_DOCUMENT {
    uuid id PK
    uuid customer_id FK
    uuid document_id FK "→ documents"
    string doc_type
    date expires_on "TBD rules"
  }
  REQUEST {
    uuid id PK
    uuid customer_id FK
    uuid customer_site_id FK
    uuid communication_id FK "nullable COM"
    uuid order_id FK "nullable until Samples creates"
    string channel
    string destination_country
  }
  QUOTE {
    uuid id PK
    string quote_number
    uuid request_id FK
    uuid standard_version_id FK "frozen catalog"
    string status
    string acceptance_mode
  }
  QUOTE_LINE {
    uuid id PK
    uuid quote_id FK
    uuid catalog_test_id FK
    decimal price
  }
```

**TBD**: segmentación exacta (sector/nivel cuenta), política de precios sin respuesta del cliente.

---

## 3 · Catalog (MVP mínimo; vigilancia/IA F2)

```mermaid
erDiagram
  STANDARD ||--|{ STANDARD_VERSION : versions
  STANDARD_VERSION ||--|{ CATALOG_TEST : defines
  CATALOG_TEST ||--o{ STANDARD_ITEM : items
  CATALOG_TEST ||--o{ PRICE : priced
  ACCREDITATION ||--o{ ACCREDITATION_SCOPE : scopes

  STANDARD {
    uuid id PK
    string code
    string owner_kind "country|customer_notebook"
    boolean confidential
  }
  STANDARD_VERSION {
    uuid id PK
    uuid standard_id FK
    string version_label
    string status "draft|detected|evaluating|verified|current|obsolete"
    uuid pdf_document_id FK
  }
  CATALOG_TEST {
    uuid id PK
    uuid standard_version_id FK
    string name
    boolean destructive
  }
  PRICE {
    uuid id PK
    uuid catalog_test_id FK
    uuid site_id FK
    string currency
    decimal amount
    date valid_from
  }
```

Consumers (**quote**, **sample_test**, **report**) store `standard_version_id` — never “whatever is current”.

---

## 4 · Samples (MVP; contramuestras F4)

```mermaid
erDiagram
  ORDER ||--|{ SAMPLE : contains
  RECEPTION ||--o{ SAMPLE : intake
  ORDER ||--o{ RECEPTION : linked
  SAMPLE ||--o{ SAMPLE_PHOTO : evidence
  SAMPLE ||--o| SAMPLE_INSPECTION : inspected
  SAMPLE ||--o{ SAMPLE_TRANSFER : moves
  SAMPLE ||--o{ RETAINED_SAMPLE : F4

  ORDER {
    uuid id PK
    string order_number
    uuid customer_id FK
    uuid customer_site_id FK
    uuid quote_id FK "nullable"
    uuid responsible_site_id FK
    string status
    date commitment_date
  }
  RECEPTION {
    uuid id PK
    string rcp_number
    uuid site_id FK
    datetime received_at
    string carrier
    string tracking_number
    uuid order_id FK "nullable until resolved"
  }
  SAMPLE {
    uuid id PK
    string mg_code UK
    uuid order_id FK "nullable if unresolved"
    uuid reception_id FK
    string client_sample_code
    int units_received
    string status
    string location
  }
  SAMPLE_PHOTO {
    uuid id PK
    uuid sample_id FK
    uuid document_id FK
  }
  SAMPLE_INSPECTION {
    uuid id PK
    uuid sample_id FK
    string outcome "fit|conditional"
    uuid document_id FK "nullable"
  }
  RETAINED_SAMPLE {
    uuid id PK
    uuid sample_id FK
    string location
    date retain_until
  }
```

Reception package photos → `documents` with `reception_id`. Sample photos → `sample_id`. `order_id` filled when resolved (object key unchanged).

---

## 5 · Laboratory (F4 detail; frontier FKs from MVP)

No `customer_id`. Work by `sample` / `sample_test` codes only.

```mermaid
erDiagram
  SAMPLE ||--o{ LAB_ASSIGNMENT : F4
  LAB_ASSIGNMENT ||--o{ SAMPLE_TEST : F4
  SAMPLE_TEST ||--o{ RESULT : F4
  EQUIPMENT ||--o{ CALIBRATION : F4
  EXCEL_TEMPLATE ||--o{ TEMPLATE_MAPPING : F4

  LAB_ASSIGNMENT {
    uuid id PK
    uuid sample_id FK
    uuid laboratory_id FK
    int units
    string status
  }
  SAMPLE_TEST {
    uuid id PK
    string test_code "mgcode-NN"
    uuid lab_assignment_id FK
    uuid catalog_test_id FK
    uuid standard_version_id FK "frozen"
    string status
  }
  RESULT {
    uuid id PK
    uuid sample_test_id FK
    uuid result_file_document_id FK
    json values
  }
```

---

## 6 · Reports (F4; signer config from Platform MVP)

```mermaid
erDiagram
  ORDER ||--o| REPORT : final
  REPORT ||--|{ REPORT_VERSION : versions

  REPORT {
    uuid id PK
    string report_number
    uuid order_id FK
    string status
    uuid verification_code
  }
  REPORT_VERSION {
    uuid id PK
    uuid report_id FK
    int version_no
    uuid pdf_document_id FK
    string content_hash
    uuid signed_by_subject
    datetime issued_at "TBD R3 emission date rules"
  }
```

Issued PDFs → Object Lock capable prefix/bucket.

---

## 7 · Communications (MVP: COM + email; WhatsApp F3)

```mermaid
erDiagram
  COMMUNICATION ||--o{ COM_ASSOCIATION : links
  COM_TEMPLATE ||--o{ COM_TEMPLATE_VERSION : versions

  COMMUNICATION {
    uuid id PK
    string com_number
    string direction "inbound|outbound"
    string channel
    string delivery_status
    uuid original_document_id FK
    string content_hash
  }
  COM_ASSOCIATION {
    uuid id PK
    uuid communication_id FK
    string target_type "order|sample|quote|sample_test"
    uuid target_id
    string link_status "provisional|confirmed"
  }
```

Outbound **send** is a command to `labsmyg-notifications` (SQS), not owned here.

---

## Transversal A · Audit (schema `audit`, MVP)

Same MySQL server, **logical schema/database `audit`**. App role: `INSERT` only.

```mermaid
erDiagram
  AUDIT_EVENT {
    uuid id PK
    datetime occurred_at
    string actor_type
    string actor_id
    string approved_by_id "nullable AI confirm"
    string action
    string entity_type
    uuid entity_id
    uuid site_id "nullable"
    uuid order_id "nullable idx"
    uuid sample_id "nullable idx"
    uuid customer_id "nullable idx"
    json before_json
    json after_json
    string correlation_id
    string prev_hash
    string row_hash
  }
```

Daily export → S3 + Object Lock. **TBD**: retention years by record type.

---

## Transversal B · Documents (MVP)

Metadata in app DB; bytes in S3. Stable key by `document_id`.

```mermaid
erDiagram
  DOCUMENT {
    uuid id PK
    string storage_key
    string content_type
    bigint byte_size
    string content_hash
    string sensitivity "standard|notebook|issued|audit_export"
    uuid customer_id "nullable"
    uuid customer_site_id "nullable"
    uuid order_id "nullable"
    uuid reception_id "nullable"
    uuid sample_id "nullable"
    uuid uploaded_by_subject
    datetime created_at
  }
```

Suggested key prefixes (not a second SoT):

- `customers/{customer_id}/legal/{document_id}`
- `receptions/{reception_id}/{document_id}`
- `samples/{sample_id}/{document_id}`
- `orders/{order_id}/{document_id}`
- `reports/issued/{document_id}`

---

## Transversal C · Approvals & outbox (MVP)

```mermaid
erDiagram
  APPROVAL_CHALLENGE {
    uuid id PK
    string kind "quote|standard_change|sample_condition|…"
    uuid target_id
    string target_type
    string otp_hash
    datetime expires_at
    string status
    uuid evidence_document_id "nullable"
  }
  OUTBOX_MESSAGE {
    uuid id PK
    string event_type
    json payload
    string status "pending|published|failed"
    datetime created_at
    datetime published_at
  }
```

---

## MVP table set (checklist)

| Domain | MVP tables |
|--------|------------|
| Platform | company, site, laboratory, sequence, app_setting, signer_config, authz assignments |
| Customers | customer, customer_site, contact, customer_document, request, quote, quote_line, customer_approval |
| Catalog | standard, standard_version, catalog_test, standard_item, price |
| Samples | order, reception, sample, sample_photo, sample_inspection |
| Laboratory | *(frontier only / stubs)* |
| Reports | *(frontier only / stubs)* |
| Communications | communication, com_association, com_template(+version) |
| Transversal | audit.audit_event, document, approval_challenge, outbox_message |

---

## Open TBDs (do not invent)

- Audit / document retention years (Ley 1581 / lab policy)
- Report emission date rules (R3)
- Customer segmentation attributes final shape
- Exact e-invoicing / payment provider columns (ports)
- Whether authz is separate tables vs JSON policies (implementation choice in `004`)
