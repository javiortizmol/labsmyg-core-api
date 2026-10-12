# Local AWS with Floci

Labs MYG uses [Floci](https://github.com/floci-io/floci) as the local AWS
emulator (same approach as Mandado). Production AWS stays in `labsmyg-iac` and
`labsmyg-tf-modules`.

Full local stack (MySQL + optional Floci): [local-compose.md](./local-compose.md)
(`make up` / `make up-aws`).

The blueprint / constitution call for **Amazon EventBridge** (domain bus) plus
**SQS per consumer** (outbox → bus → rules → queues). Floci emulates that path
locally so workers can be developed without cloud.

## Quick start

```bash
make floci-up          # Floci only
# or: make up-aws      # MySQL + Floci
eval "$(make floci-env)"
```

| URL | Purpose |
|-----|---------|
| `http://localhost:4566` | AWS endpoint (SDK / CLI) |
| `http://localhost:4566/_floci/ui` | Web console (needs Docker socket) |

## Smoke: EventBridge → SQS (blueprint shape)

Creates a custom bus, a rule for `sample.received`, targets a queue, and
publishes one event (verified against Floci).

```bash
eval "$(make floci-env)"   # or FLOCI_HOST_PORT=4567 make floci-env

aws events create-event-bus --name labsmyg-domain

aws sqs create-queue --queue-name labsmyg-dev-events
QARN=$(aws sqs get-queue-attributes \
  --queue-url "$(aws sqs get-queue-url --queue-name labsmyg-dev-events --query QueueUrl --output text)" \
  --attribute-names QueueArn \
  --query 'Attributes.QueueArn' --output text)

aws events put-rule \
  --event-bus-name labsmyg-domain \
  --name sample-received-to-sqs \
  --event-pattern '{"source":["labsmyg.samples"],"detail-type":["sample.received"]}' \
  --state ENABLED

aws events put-targets \
  --event-bus-name labsmyg-domain \
  --rule sample-received-to-sqs \
  --targets "Id=sqs-dev,Arn=${QARN}"

aws events put-events --entries '[
  {
    "EventBusName": "labsmyg-domain",
    "Source": "labsmyg.samples",
    "DetailType": "sample.received",
    "Detail": "{\"sampleId\":\"demo-1\",\"version\":1}"
  }
]'

aws sqs receive-message \
  --queue-url "$(aws sqs get-queue-url --queue-name labsmyg-dev-events --query QueueUrl --output text)" \
  --max-number-of-messages 1 \
  --wait-time-seconds 2
```

Also useful locally (same endpoint): **S3** (files/PDF), **Secrets Manager**,
**EventBridge Scheduler** (recurring jobs). Full product wiring lands in
`specs/011-domain-events-workers`.

## Make targets

| Target | Action |
|--------|--------|
| `make floci-up` | Start Floci (`aws-emulator` profile) |
| `make floci-down` | Stop / remove container (keep volume) |
| `make floci-logs` | Follow logs |
| `make floci-env` | Print `export` lines for the shell |
| `make floci-reset` | Stop and delete the Floci volume |

## Configuration

See `.env.example`. Important variables:

- `AWS_ENDPOINT_URL=http://localhost:4566` (host → Floci)
- From another Compose service: `http://floci:4566` (keep `FLOCI_HOSTNAME=floci`)
- `FLOCI_STORAGE_MODE=hybrid` (default in Compose)

## Notes

- Profile is **optional**: default `docker compose up` does not start Floci.
- `make quality` does not require Floci.
- Region default `us-east-1` is provisional until IaC fase 0 chooses the prod region.
- If Mandado’s Floci already binds `4566`, reuse it (`eval "$(make floci-env)"`) or start a second instance: `FLOCI_HOST_PORT=4567 make floci-up`.
