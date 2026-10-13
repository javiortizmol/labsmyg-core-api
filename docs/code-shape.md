# Code shape — by artifact type

**Spirit (all repos, all generated solutions):** small units, one reason to
change, no god files. **Numbers depend on type** — do not apply Python 350/50
to a React page, a prompt, or realm JSON.

| Artifact | Prefer | Split / smell | Repos |
|----------|--------|---------------|-------|
| Python module (`app/`, workers) | ≤350 lines; fn ≤50 | File 500; fn 80 | api, notifications, agents-runtime |
| Test module | One theme | File 500 | same |
| React **page / route** (`page.tsx`, screen) | ≤400 | **600** (JSX is verbose) | front |
| React **component / hook** | Comp ≤200; hook body ≤80; fn ≤50 | Comp 350; hook 120 | front |
| CSS module / tokens | One theme | Split by surface, not LOC | front |
| Agent **runtime** Python/TS | Same as API Python | Same | agents |
| Agent **prompt / policy text** | One role per file; ≤200 lines | Split sections; **no** 50-line “function” rule | agents |
| Agent **eval JSON** | One suite per file | Split cases, not a line cap | agents |
| Domain `AGENTS.md` | Lean router ≤120 | Link; do not paste blueprint | agents |
| Terraform `.tf` | ≤350; one family | 500 | iac, tf-modules |
| GitHub workflow YAML | One job family ≤350 | Split composites | pipe-templates |
| Realm / theme JSON | Readable | Split clients/roles if dump | idm |
| Spec / docs Markdown | No LOC cap | Clarity, not line count | all |

MUST NOT delete tests or flatten prompts to hit a number.
