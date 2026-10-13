# Event & command delivery reliability (evaluation)

**Status**: Draft — **transversal** policy for every generated solution.  
**Specs**: [`011`](../specs/011-domain-events-workers/spec.md) · [`022`](../specs/022-endpoint-idempotency/spec.md) · COM [`008`](../specs/008-communications-registry/spec.md) · notif `001`/`006`  
**ER**: [`docs/domain-er-model.md`](./domain-er-model.md) (`outbox_message`, inbox)

A new domain slice, worker, or sibling-service flow **MUST** reuse this
pattern. Do not invent a one-off `PutEvents` / `SendMessage` / fire-and-forget
side effect. Product Conflict Check includes **Delivery / idempotency**.

## What “no lost transaction” means here

Labs MYG **does not** promise broker exactly-once (EventBridge + SQS cannot).
It promises:

1. A **committed** business write is never without a durable outbox/command row
   in the **same MySQL transaction** (including append-only audit).
2. That row is published **at-least-once** until ACK, then retried; poison →
   **DLQ + alarm**, never silent drop.
3. Consumers apply **idempotency** (inbox) so retries/duplicates do not double
   effects (emails, state jumps, COM).
4. Operators can **replay** from archive / outbox / DLQ.

If the DB commit fails, nothing happened (no ghost event). If the process dies
after commit and before publish, the outbox publisher recovers the row.

## Evaluation of current specs (2026-10-12)

| Practice | Before this pass | Verdict |
|----------|------------------|---------|
| Transactional outbox with state change | `011` FR-001 (one line) | **Thin** — now FR-007–012 |
| Audit in same transaction | Constitution I-a.2 | **OK** |
| No full event sourcing | `011` FR-004 | **OK** |
| Bus + per-consumer SQS + DLQ | `011` FR-002; iac Q-03 | **OK** (ops alarms were missing) |
| Event version / discard stale | `011` US2 | **OK** |
| HTTP `Idempotency-Key` | `022` | **OK** for user retries — **not** a substitute for inbox |
| COM send command + inbound Message-Id | `008` FR-004/008 | **OK** intent; needs same outbox/inbox rules |
| Notifications consume + DLQ | notif `001` | **Thin** — must persist send inbox |
| Publisher ACK-before-mark-published | — | **Gap** (risk: mark published then crash = lost) |
| Ban dual-write (PutEvents in request) | — | **Gap** |
| Consumer inbox unique `(consumer, event_id)` | — | **Gap** (FR-003 said “idempotent” only) |
| Outbox retry / attempts / never drop | ER status only | **Gap** |
| Command queue (notifications) transactional | “cola” in `008` | **Gap** if SendMessage then commit |
| Visibility timeout vs work time | iac WA-lite skill | **Not in 011** |
| Archive + replay | inventory Q-01 | **Not required in 011** |
| Job lease (no double scheduler) | `011` US3 “idempotent” | **Thin** |
| Notifications result events | notif FR-005 | **Must** use notif-local outbox |

## Required pattern (locked)

```
use case ──► BEGIN
               write aggregate + audit
               INSERT outbox / command_outbox (event_id)
             COMMIT
publisher ──► Send / PutEvents
             on ACK: mark published
             on fail: retry with backoff; DLQ/failed after N
consumer ──► INSERT inbox (consumer_id, event_id) UNIQUE
             if duplicate: ACK queue, no side effect
             apply + bump applied_version
             ACK SQS
```

**Forbidden:** `PutEvents` / `SendMessage` inside the request that writes
business state, then hoping the commit succeeds (dual-write).

## Semantic

| Layer | Guarantee |
|-------|-----------|
| MySQL commit | All-or-nothing for aggregate + audit + outbox |
| Publisher → EventBridge/SQS | At-least-once |
| SQS consumer | At-least-once; visibility timeout ≥ p95 work + buffer |
| Inbox | Effect-once per `(consumer_id, event_id)` |
| Aggregate version | Ignore stale (`version <= applied`) |

## Related inventory

iac `Q-01` archive · `Q-03` rule+SQS+DLQ · `Q-04` send command queue
