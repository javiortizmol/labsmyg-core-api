# Local Docker Compose stack

Base local for `labsmyg-core-api`: **MySQL** (business + audit schemas) and
optional **Floci** (AWS emulator). See also [local-aws-floci.md](./local-aws-floci.md)
and the ER model [domain-er-model.md](./domain-er-model.md).

Spec: `specs/026-local-compose-stack`.

## Prerequisites

- Docker (or Colima) with Compose v2
- Copy env: `cp .env.example .env` (optional; defaults match Compose)

## Quick start

```bash
make up          # MySQL only
make ps          # status
make down        # stop (keeps volumes)
make reset       # stop + delete volumes (destructive)
```

With Floci:

```bash
make up-aws
eval "$(make floci-env)"
```

| Service | Host default | Notes |
|---------|--------------|--------|
| MySQL | `localhost:3307` | Databases `labsmyg`, `labsmyg_audit` |
| Floci | `localhost:4566` | Profile `aws-emulator`; UI `/_floci/ui` |

## Connection URLs

From `.env.example` (host → published port):

```text
DATABASE_URL=mysql+pymysql://labsmyg:labsmyg-local@localhost:3307/labsmyg
AUDIT_DATABASE_URL=mysql+pymysql://labsmyg:labsmyg-local@localhost:3307/labsmyg_audit
```

From another Compose service on the same network, use hostname `mysql` and
port `3306`.

## Schemas

Init script `docker/mysql/init/01-schemas.sql` runs **once** on first volume
create:

- `labsmyg` — application / domain tables (Alembic later)
- `labsmyg_audit` — audit trail only

After changing init SQL, run `make reset` then `make up` (wipes data).

## Makefile targets

| Target | Purpose |
|--------|---------|
| `make up` | Start MySQL |
| `make up-aws` | MySQL + Floci |
| `make down` | Stop stack (keep volumes) |
| `make logs` | Follow logs |
| `make ps` | List containers |
| `make reset` | Down + remove volumes |
| `make floci-up` / `floci-down` / `floci-env` / `floci-reset` | Floci-only helpers |

## Deferred: API container

A Compose `api` service will be added when FastAPI exposes a health endpoint
(`001`). Until then, run the app on the host against `DATABASE_URL` / Floci env.

## Port conflicts

- MySQL: `MYSQL_HOST_PORT=3308 make up`
- Floci: `FLOCI_HOST_PORT=4567 make up-aws` (e.g. if Mandado owns 4566)
