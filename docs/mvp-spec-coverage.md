# MVP spec coverage (cross-repo)

**Date**: 2026-10-12 · Living checklist · Scorecard: [`specs/015-blueprint-alignment`](../specs/015-blueprint-alignment/spec.md)

**MVP = Fase 1** product capabilities. Specs are mostly **Draft** (not Aprobada). Code is mostly **absent** (stubs + local tooling).

## Legend

| Status | Meaning |
|--------|---------|
| Spec OK | Draft/Aprobada slice exists and maps to MVP |
| Spec thin | Exists but missing UI sibling or detail |
| Spec gap | No dedicated slice yet |
| Out | Explicitly post-MVP / later phase |
| Build | Spec OK; implementation still todo |

---

## By repository

### `labsmyg-core-api`

| Area | Specs | MVP? | Notes |
|------|-------|------|-------|
| Bootstrap / JWT / OpenAPI | `001` | Build | |
| Platform org / numbering / settings | `002` | Build | |
| Audit | `003` | Build | |
| Authorization | `004` | Build | |
| Customers / quotes | `005` | Build | |
| Catalog min | `006` | Build | Vigilance/IA → F2 |
| Samples / RCP / guide capture | `007` | Build | Photo guía/app + confirm |
| COM | `008` + `027` | Build | Shared mailbox |
| Approvals OTP | `009` | Build | |
| Files / PDF | `010` | Build | |
| Outbox / workers | `011` | Build | |
| AI ports (stubs) | `014` | Build (ports) | Adapters F2; guide read uses port |
| Pending lists | `016` | Build | |
| Signers config | `017` | Build | Use in reports F4 |
| Order complete view | `018` | Build | |
| Sample inspection | `019` | Build | F1–2 |
| Idempotency | `022` | Build | |
| NFR / 17025 package | `023` | Build (doc) | |
| Local Floci / Compose MySQL | `024` `026` | Tooling OK | |
| ER / scorecard | `025` `015` | Doc OK | |
| Laboratory / reports / retained | `012` `013` `020` | Out | F4 |
| Migration PHP | `021` | Out parallel | Blocked on PHP+DB+metrology inspect |
| WhatsApp | — | Out | F3 / notif later |

### `labsmyg-core-front`

| Area | Specs | MVP? | Notes |
|------|-------|------|-------|
| Bootstrap / OIDC / responsive shell | `001` | Build | |
| Admin org / users / roles | `002` | Build | |
| Customers / quotes UI | `003` | Build | |
| Catalog UI | `004` | Build | |
| Reception UI (responsive) | `005` | Build | PWA post-MVP |
| COM UI | `006` | Build | |
| Public portal (link+OTP) | `007` | Build | |
| Pending lists UI | `010` | Build | |
| Order complete UI | `011` | Build | |
| Signers admin UI | `013-signers-ui` | Spec added | Was gap vs api `017` |
| Inspection UI | `014-sample-inspection-ui` | Spec added | Was gap vs api `019` |
| Lab / reports UI | `008` `009` | Out | F4 |
| Cursor skills | `012` | Tooling | |

### `labsmyg-notifications`

| Area | Specs | MVP? |
|------|-------|------|
| Bootstrap / consumer | `001` | Build |
| SES outbound + shared From | `002` | Build |
| Teams alerts | `003` | Build |
| SES delivery webhooks | `004` | Build (WA F3) |
| OTP + templates | `005` | Build |
| SES inbound | `006` | Build |

### `labsmyg-idm`

| Area | Specs | MVP? |
|------|-------|------|
| Keycloak realms MFA OIDC | `001` | Build |
| User admin / federation later | `002` | Build (admin); federation §17 |

### `labsmyg-iac` + `labsmyg-tf-modules`

| Area | Specs | MVP? |
|------|-------|------|
| Foundation / runtime | iac `001` `002` | Build later (definition freeze) |
| Config inventory (no apply) | iac `004` + docs | Doc OK |
| Shared modules catalogue | tf-modules `001` | Build when leaving definition |

### `labsmyg-pipe-templates`

| Area | Specs | MVP? |
|------|-------|------|
| Reusable deploy / quality | `001` `002` | Build / CI |

### `labsmyg-agents`

| Area | Specs | MVP? |
|------|-------|------|
| Bootstrap / skills | `001` `002` | Thin for MVP — runtime ports in api `014`; rich agents F2+ |

---

## Spec gaps closed this review

1. Front **signers** UI → `013-signers-ui`
2. Front **inspection** UI → `014-sample-inspection-ui`
3. This coverage doc + `015` refresh

## Still not a “missing spec” (process / decisions)

| Item | Why |
|------|-----|
| Draft → Aprobada (§15) | Process; all MVP specs still Draft |
| §17: DNS/mailbox, MySQL version, stickers, lab piloto | External owners |
| Implement code | Build phase |
| IaC apply | Intentionally deferred while in definition |
| Stickers/printers detail | Pending TI inside `005`/`007` |
| Guide OCR adapter live | Port in `014`; Textract/Bedrock when iac enables |

## Out of MVP (do not block cut)

WhatsApp · PWA offline · migration ETL · laboratory · reports/sign issue · retained samples · full analytics · Bedrock KB vigilance · M365 Graph mailbox alt
