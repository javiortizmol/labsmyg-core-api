# Generic quality entrypoint for CI and image builds.
# Prefer `make quality` over inlining tool CLIs in Dockerfiles.
.PHONY: quality quality-fast test-unit format lint verify audit coverage install install-hooks

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
