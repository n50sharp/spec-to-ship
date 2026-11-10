# Stage map

| # | Stage | Skill (as installed) | Artifact | Done when |
|---|---|---|---|---|
| 0 | Setup | `specify init` (CLI) | `.specify/` | `.specify/integration.json` exists |
| 1 | Research | omh-deep-research | `.omh/research/<slug>-report.md` | report confirmed |
| 2 | Constitution | speckit-constitution | `.specify/memory/constitution.md` | no placeholder tokens |
| 3 | Intent | omh-deep-interview, superpowers:brainstorming | `.omh/specs/*`, chat write-back | user confirmed |
| 4 | Specify | speckit-specify, speckit-clarify | `specs/NNN-name/spec.md` | no open clarifications |
| 5 | Plan | speckit-plan, omh-ralplan | `specs/NNN-name/plan.md`, `.omh/plans/ralplan-*.md` | amendments folded in |
| 6 | Tasks | speckit-tasks, speckit-analyze | `specs/NNN-name/tasks.md` | no CRITICAL findings |
| 7 | Bridge | this skill | `.omh/plans/ralph-plan.md` | every task testable |
| 8 | Execute | omh-ralph or Kanban workers, superpowers:test-driven-development | code, tests, ticked tasks | evidence per task |
| 5+ | Deliverable docs | see references/deliverables.md | `specs/NNN-name/docs/{ux,architecture,design,test-plan,test-report}.md`, README/runbook | exist, traced to FR IDs, match as-built |
| 9 | Close | speckit-converge, superpowers:verification-before-completion, superpowers:requesting-code-review | review result | all verified this turn |

## Fallbacks

- No OMH plugin (`omh_state` tool missing): skip stages 1 and the ralplan half of 5; execute stage 8 with superpowers:subagent-driven-development.
- No Superpowers: skip brainstorming; keep TDD and verification as written rules in the task acceptance criteria.
- No spec-kit: stop. The artifacts are the spine.

## Handoffs that break

- ralplan writes to `.omh/plans/`, spec-kit to `specs/`. Never let both become the plan of record.
- speckit skills need the project's `.specify/`; run them from the project root.
- ralph parses plans only from `.omh/plans/ralplan-*.md` or `ralph-plan.md`.
