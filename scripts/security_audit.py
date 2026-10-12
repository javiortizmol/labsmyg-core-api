"""Run dependency audit with severity-aware blocking."""

from __future__ import annotations

import json
import os
import subprocess
import sys
from urllib.error import HTTPError, URLError
from urllib.request import urlopen

from cvss import CVSS3, CVSS4

OSV_URL = "https://api.osv.dev/v1/vulns/"


def advisory_score(advisory_id: str) -> float | None:
    try:
        with urlopen(f"{OSV_URL}{advisory_id}", timeout=10) as response:  # noqa: S310
            advisory = json.load(response)
    except (HTTPError, URLError, TimeoutError, json.JSONDecodeError):
        return None

    for severity in advisory.get("severity", []):
        vector = severity.get("score", "")
        try:
            if severity.get("type") == "CVSS_V3":
                return float(CVSS3(vector).scores()[0])
            if severity.get("type") == "CVSS_V4":
                return float(CVSS4(vector).scores()[0])
        except (TypeError, ValueError):
            continue
    return None


def severity(score: float | None) -> str:
    if score is None:
        return "unknown"
    if score >= 9:
        return "critical"
    if score >= 7:
        return "high"
    if score >= 4:
        return "medium"
    return "low"


def main() -> int:
    result = subprocess.run(
        [sys.executable, "-m", "pip_audit", "--skip-editable", "--format", "json"],
        capture_output=True,
        text=True,
        check=False,
    )
    try:
        report = json.loads(result.stdout)
    except json.JSONDecodeError:
        print(result.stderr, file=sys.stderr)
        return result.returncode or 1

    findings: list[tuple[str, str, str, float | None]] = []
    for dependency in report.get("dependencies", []):
        for vulnerability in dependency.get("vulns", []):
            advisory_id = vulnerability["id"]
            score = advisory_score(advisory_id)
            findings.append((dependency["name"], dependency["version"], advisory_id, score))

    summary_path = os.environ.get("GITHUB_STEP_SUMMARY")
    summary = [
        "## Dependency audit",
        "",
        "| Package | Version | Advisory | Severity |",
        "|---|---:|---|---|",
    ]
    blocking = False
    for package, version, advisory_id, score in findings:
        level = severity(score)
        summary.append(f"| {package} | {version} | {advisory_id} | {level} |")
        if level in {"critical", "high", "unknown"}:
            blocking = True

    output = "\n".join(summary) if findings else "Dependency audit found no vulnerabilities."
    print(output)
    if summary_path:
        with open(summary_path, "a", encoding="utf-8") as summary_file:
            summary_file.write(f"{output}\n")

    return 1 if blocking else 0


if __name__ == "__main__":
    raise SystemExit(main())
