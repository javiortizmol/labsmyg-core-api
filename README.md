# labsmyg-core-api

Spec-driven development (Spec Kit + Cursor skills), quality gates, and a
pre-push hook. Non-negotiables live in `.specify/memory/constitution.md`.

## Quality

```bash
uv sync --extra dev
make install-hooks   # once per clone; pre-push runs make quality
make quality          # required before done / push / CI
make quality-fast     # iteration only
make audit            # deps + Bandit, separate from quality
```

## Local AWS (Floci)

Optional emulator for S3, SQS, EventBridge, Secrets Manager, etc. Same pattern
as Mandado. Details: [`docs/local-aws-floci.md`](docs/local-aws-floci.md).

```bash
make floci-up
eval "$(make floci-env)"
# Blueprint path: EventBridge bus → rule → SQS (see docs/local-aws-floci.md)
```

Console: http://localhost:4566/_floci/ui

