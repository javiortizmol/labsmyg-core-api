# Research: Local Floci

## Decision: Floci over LocalStack

**Choice**: `floci/floci:latest` on port `4566`.  
**Rationale**: Free, no auth token, MIT, drop-in LocalStack-compatible endpoint; Mandado already standardized on Floci. LocalStack Community sunset requires tokens.  
**Alternatives**: LocalStack (rejected — token/gates), Moto (SDK-only, not full wire protocol for Compose/IaC).

## Decision: Optional Compose profile

**Choice**: `profiles: ["aws-emulator"]`.  
**Rationale**: Developers who only need API + DB should not pull/start Floci. Same as Mandado.  
**Alternatives**: Always-on service (rejected — slower default `compose up`).

## Decision: Hybrid storage + named volume

**Choice**: `FLOCI_STORAGE_MODE=hybrid` + volume `labsmyg_api_floci`.  
**Rationale**: Floci docs recommend hybrid for local dev; survives restarts without WAL overhead.  
**Alternatives**: `memory` (CI-friendly later), `persistent` (heavier sync).

## Decision: Docker socket mount

**Choice**: Mount `/var/run/docker.sock`.  
**Rationale**: Needed for Floci UI sidecar and Docker-backed services (Lambda, RDS, etc.) when those are used.  
**Risk**: Requires Docker Desktop/socket permissions on the host.

## Decision: Region default `us-east-1`

**Choice**: Provisional until IaC fase 0 picks us-east-1 vs sa-east-1.  
**Rationale**: Matches Floci default and common SDK examples; override via `AWS_REGION`.
