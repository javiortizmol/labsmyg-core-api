# Quickstart: Floci local AWS

## Start

```bash
make floci-up
eval "$(make floci-env)"
```

Console: http://localhost:4566/_floci/ui

## Smoke — EventBridge → SQS (blueprint)

```bash
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

See also [`docs/local-aws-floci.md`](../../docs/local-aws-floci.md) and
`specs/011-domain-events-workers`.

## Stop / reset

```bash
make floci-down          # stop container, keep volume
make floci-reset         # stop and delete volume
```

## Point the API (later)

In `.env`:

```bash
AWS_ENDPOINT_URL=http://localhost:4566
AWS_ACCESS_KEY_ID=test
AWS_SECRET_ACCESS_KEY=test
AWS_DEFAULT_REGION=us-east-1
```

From another Compose service on the same network use `http://floci:4566` and keep `FLOCI_HOSTNAME=floci`.
