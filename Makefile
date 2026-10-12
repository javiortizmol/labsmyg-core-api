# Generic quality entrypoint for CI and image builds.
# Prefer `make quality` over inlining tool CLIs in Dockerfiles.
.PHONY: quality quality-fast test-unit format lint verify audit coverage install install-hooks \
	up up-aws down logs ps reset \
	floci-up floci-down floci-logs floci-env floci-reset

install:
	uv sync --extra dev

# Prefer local .venv from `uv sync --extra dev` (pre-push / bare `make` often have no global tools).
VENV_BIN := $(CURDIR)/.venv/bin
RUFF := $(shell if [ -x "$(VENV_BIN)/ruff" ]; then echo "$(VENV_BIN)/ruff"; else echo ruff; fi)
BLACK := $(shell if [ -x "$(VENV_BIN)/black" ]; then echo "$(VENV_BIN)/black"; else echo black; fi)
PYLINT := $(shell if [ -x "$(VENV_BIN)/pylint" ]; then echo "$(VENV_BIN)/pylint"; else echo pylint; fi)
PYTEST := $(shell if [ -x "$(VENV_BIN)/pytest" ]; then echo "$(VENV_BIN)/pytest"; else echo pytest; fi)
PYTHON := $(shell if [ -x "$(VENV_BIN)/python" ]; then echo "$(VENV_BIN)/python"; else echo python3; fi)
# pytest-xdist workers: auto, a fixed N, or 0 = serial.
PYTEST_WORKERS ?= 0
BANDIT := $(shell if [ -x "$(VENV_BIN)/bandit" ]; then echo "$(VENV_BIN)/bandit"; else echo bandit; fi)

# Cache pylint stats inside the repo (not ~/Library/Caches).
export PYLINTHOME := $(CURDIR)/.pylint.d

# Ruff = lint + import order; Black = format; Pylint = design + import-outside-toplevel.
lint:
	@mkdir -p "$(PYLINTHOME)"
	$(RUFF) check app tests
	$(BLACK) --check app tests
	$(PYLINT) app

format:
	$(BLACK) app tests
	$(RUFF) check --fix app tests

# Lint + full pytest with global coverage gate (fail_under also in pyproject).
# Required for pre-push, CI, release images, and claiming done.
quality: lint
	@rm -f .coverage
ifeq ($(PYTEST_WORKERS),0)
	$(PYTEST) --cov=app --cov-report=term-missing:skip-covered --cov-fail-under=90
else
	$(PYTEST) -n $(PYTEST_WORKERS) --dist loadgroup --cov=app --cov-report=term-missing:skip-covered --cov-fail-under=90
endif

# Iteration gate: lint touched + heuristic tests + diff-cover ≥90% on changed app/ lines.
# Not a substitute for `make quality`. Base: QUALITY_FAST_BASE (default origin/main).
quality-fast:
	$(PYTHON) scripts/quality_fast.py

test-unit:
	$(PYTEST) -m unit -q

coverage:
	@rm -f .coverage
	$(PYTEST) --cov=app --cov-report=term-missing --cov-report=html

verify: quality
	@echo "verify: quality OK"

# Dependency + SAST audits (separate from quality).
audit:
	$(PYTHON) scripts/security_audit.py
	$(BANDIT) -r app -ll -q

# One-time per clone: point Git at repo-managed hooks (pre-push → make quality).
install-hooks:
	git config core.hooksPath .githooks
	@chmod +x .githooks/pre-push
	@echo "Git hooksPath=.githooks (pre-push: make quality; pip-audit when deps change)"

# --- Local Compose stack (MySQL + optional Floci) ---
# Docs: docs/local-compose.md · docs/local-aws-floci.md
# Prefer Compose v2 plugin; fall back to standalone docker-compose.
COMPOSE ?= $(shell if docker compose version >/dev/null 2>&1; then echo "docker compose"; \
	elif command -v docker-compose >/dev/null 2>&1; then echo "docker-compose"; \
	else echo "docker compose"; fi)
FLOCI_SERVICE := floci
MYSQL_SERVICE := mysql

# MySQL only (default local base).
up:
	$(COMPOSE) up -d $(MYSQL_SERVICE)
	@port="$${MYSQL_HOST_PORT:-3307}"; \
	echo "MySQL: localhost:$$port  databases: labsmyg, labsmyg_audit"; \
	echo "Wait:  $(COMPOSE) ps"; \
	echo "URLs:  see .env.example (DATABASE_URL / AUDIT_DATABASE_URL)"

# MySQL + Floci (AWS emulator profile).
up-aws: up
	$(COMPOSE) --profile aws-emulator up -d $(FLOCI_SERVICE)
	@port="$${FLOCI_HOST_PORT:-4566}"; \
	echo "Floci: http://localhost:$$port  UI: http://localhost:$$port/_floci/ui"; \
	echo "Env:   eval \"\$$(make floci-env)\""

down:
	$(COMPOSE) --profile aws-emulator down --remove-orphans

logs:
	$(COMPOSE) --profile aws-emulator logs -f

ps:
	$(COMPOSE) --profile aws-emulator ps -a

# Stop and wipe named volumes (MySQL data + Floci). Destructive.
reset:
	$(COMPOSE) --profile aws-emulator down -v --remove-orphans
	@echo "Volumes removed (labsmyg_mysql_data, labsmyg_api_floci)."

# --- Local AWS emulator (Floci): https://github.com/floci-io/floci ---
# Optional profile; not required for make quality.

floci-up:
	$(COMPOSE) --profile aws-emulator up -d $(FLOCI_SERVICE)
	@port="$${FLOCI_HOST_PORT:-4566}"; \
	echo "Floci: http://localhost:$$port  UI: http://localhost:$$port/_floci/ui"; \
	echo "Env:   eval \"\$$(make floci-env)\""

floci-down:
	$(COMPOSE) --profile aws-emulator stop $(FLOCI_SERVICE)
	$(COMPOSE) --profile aws-emulator rm -f $(FLOCI_SERVICE)

floci-logs:
	$(COMPOSE) --profile aws-emulator logs -f $(FLOCI_SERVICE)

floci-env:
	@region="$${AWS_REGION:-us-east-1}"; \
	port="$${FLOCI_HOST_PORT:-4566}"; \
	echo "export AWS_ENDPOINT_URL=http://localhost:$$port"; \
	echo "export AWS_ACCESS_KEY_ID=test"; \
	echo "export AWS_SECRET_ACCESS_KEY=test"; \
	echo "export AWS_DEFAULT_REGION=$$region"; \
	echo "export AWS_REGION=$$region"

# Remove only the Floci named volume (keeps MySQL data). Full wipe: make reset.
floci-reset: floci-down
	@name="$$(docker volume ls -q | grep 'labsmyg_api_floci$$' | head -1)"; \
	if [ -n "$$name" ]; then \
		docker volume rm "$$name"; \
		echo "Floci volume removed ($$name)."; \
	else \
		echo "No Floci volume to remove."; \
	fi
