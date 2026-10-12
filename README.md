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

