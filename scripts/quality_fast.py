#!/usr/bin/env python3
"""Fast local/agent quality gate: lint touched files + subset tests + diff-cover ≥90%.

Full suite + global 90% remains `make quality` (pre-push / CI / claiming done).
See specs/055-api-quality-fast and 016 FR-003a.
"""

from __future__ import annotations

import os
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
APP = ROOT / "app"
TESTS = ROOT / "tests"


def _run(cmd: list[str], *, check: bool = True) -> subprocess.CompletedProcess[str]:
    print("+", " ".join(cmd), flush=True)
    return subprocess.run(cmd, cwd=ROOT, check=check, text=True)


def _git_output(*args: str) -> list[str]:
    proc = subprocess.run(
        ["git", *args],
        cwd=ROOT,
        check=False,
        text=True,
        capture_output=True,
    )
    if proc.returncode != 0:
        return []
    return [line.strip() for line in proc.stdout.splitlines() if line.strip()]


def resolve_base() -> str | None:
    env = (os.environ.get("QUALITY_FAST_BASE") or "").strip()
    candidates = [env] if env else ["origin/main", "main", "origin/master", "master"]
    for ref in candidates:
        if not ref:
            continue
        probe = subprocess.run(
            ["git", "rev-parse", "--verify", ref],
            cwd=ROOT,
            check=False,
            capture_output=True,
        )
        if probe.returncode == 0:
            return ref
    return None


def changed_python_files(base: str) -> list[Path]:
    names = set(_git_output("diff", "--name-only", "--diff-filter=ACMR", base, "--", "app", "tests"))
    names.update(_git_output("ls-files", "--others", "--exclude-standard", "--", "app", "tests"))
    out: list[Path] = []
    for name in sorted(names):
        path = ROOT / name
        if path.suffix == ".py" and path.is_file():
            out.append(path)
    return out


def select_tests(changed: list[Path]) -> list[Path]:
    selected: set[Path] = set()
    for path in changed:
        rel = path.relative_to(ROOT)
        if rel.parts[0] == "tests":
            if path.name != "conftest.py" and path.name.startswith("test_"):
                selected.add(path)
            continue
        if rel.parts[0] != "app":
            continue
        stem = path.stem
        # Heuristic: test files whose name mentions the module stem.
        for match in TESTS.rglob("*.py"):
            if not match.name.startswith("test_"):
                continue
            if stem in match.stem or stem.replace("_", "") in match.stem.replace("_", ""):
                selected.add(match)
        # Domain package hint: app/domains/foo/... → tests/test_*foo*
        if len(rel.parts) >= 3 and rel.parts[1] == "domains":
            domain = rel.parts[2]
            for match in TESTS.glob(f"test_*{domain}*.py"):
                selected.add(match)
            for match in TESTS.rglob(f"test_*{domain}*.py"):
                selected.add(match)
    return sorted(p for p in selected if p.is_file())


def main() -> int:
    venv_bin = ROOT / ".venv" / "bin"
    python = str(venv_bin / "python") if (venv_bin / "python").is_file() else sys.executable
    ruff = str(venv_bin / "ruff") if (venv_bin / "ruff").is_file() else "ruff"
    black = str(venv_bin / "black") if (venv_bin / "black").is_file() else "black"
    pylint = str(venv_bin / "pylint") if (venv_bin / "pylint").is_file() else "pylint"
    pytest = str(venv_bin / "pytest") if (venv_bin / "pytest").is_file() else "pytest"
    diff_cover = str(venv_bin / "diff-cover") if (venv_bin / "diff-cover").is_file() else "diff-cover"

    base = resolve_base()
    if base is None:
        print(
            "quality-fast: no compare branch (set QUALITY_FAST_BASE or fetch main); "
            "falling back to make quality",
            flush=True,
        )
        return _run(["make", "quality"], check=False).returncode

    changed = changed_python_files(base)
    if not changed:
        print(f"quality-fast: no Python changes under app/tests vs {base}; OK", flush=True)
        return 0

    print(f"quality-fast: base={base} files={len(changed)}", flush=True)
    rels = [str(p.relative_to(ROOT)) for p in changed]
    _run([ruff, "check", *rels])
    _run([black, "--check", *rels])

    app_changed = [p for p in changed if p.is_relative_to(APP)]
    if app_changed:
        os.environ.setdefault("PYLINTHOME", str(ROOT / ".pylint.d"))
        Path(os.environ["PYLINTHOME"]).mkdir(parents=True, exist_ok=True)
        _run([pylint, *[str(p.relative_to(ROOT)) for p in app_changed]])

    if not app_changed:
        print("quality-fast: no app/ changes; lint-only OK", flush=True)
        return 0

    tests = select_tests(changed)
    if not tests:
        print(
            "quality-fast: no matching tests for changed app modules; "
            "add tests or run make quality",
            file=sys.stderr,
            flush=True,
        )
        return 1

    cov_xml = ROOT / "coverage.xml"
    if cov_xml.exists():
        cov_xml.unlink()

    # Override global fail_under for the subset run; diff-cover enforces 90% on the diff.
    _run(
        [
            pytest,
            *[str(p.relative_to(ROOT)) for p in tests],
            "--cov=app",
            "--cov-report=xml:coverage.xml",
            "--cov-report=term-missing:skip-covered",
            "--cov-fail-under=0",
        ]
    )

    if not cov_xml.is_file():
        print("quality-fast: coverage.xml missing after pytest", file=sys.stderr, flush=True)
        return 1

    result = _run(
        [
            diff_cover,
            "coverage.xml",
            f"--compare-branch={base}",
            "--fail-under=90",
            "--include=app/*",
        ],
        check=False,
    )
    return result.returncode


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except subprocess.CalledProcessError as exc:
        raise SystemExit(exc.returncode) from exc
