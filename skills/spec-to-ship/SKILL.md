---
name: spec-to-ship
description: Use when starting a non-trivial build, feature or project that needs requirements, a plan, tasks and verified execution, before writing any code.
version: 0.2.0
license: MIT
metadata:
  hermes:
    tags: [pipeline, spec-driven, planning, execution, superpowers, spec-kit, omh]
    related_skills: [speckit-specify, omh-ralplan, omh-ralph, superpowers:brainstorming]
---

# Spec to Ship

One pipeline over three toolkits. It calls them by name and never copies their text, so upstream updates flow through.

- **spec-kit** owns the durable artifacts: constitution, `spec.md`, `plan.md`, `tasks.md`.
- **OMH** owns the hard thinking and the loop: deep-interview, ralplan consensus, ralph evidence-checked execution.
- **Superpowers** owns discipline: brainstorming, TDD, verification, review.

Rule: `specs/<NNN>-<name>/` is the single source of truth. OMH output under `.omh/` is derived and may be regenerated.

## When to Use

- New feature, project or subsystem touching several files.
- The goal is vague, or the plan must survive review.

Not for: one-line fixes (just do them), bug hunts (use superpowers:systematic-debugging), non-build work.

## Stages

Run in order. A stage is done only when its artifact exists. Detail and fallbacks: `references/stage-map.md`.

0. **Setup.** Project dir exists; on a tracked project, a task-board entry exists. Run `specify init <dir> --integration hermes --ignore-agent-tools` once. Done: `.specify/integration.json` exists.
1. **Research** (only if the domain is unfamiliar). `omh-deep-research`. Done: `.omh/research/*-report.md`.
2. **Constitution.** `speckit-constitution`. Done: `.specify/memory/constitution.md` has no placeholders.
3. **Intent.** If the goal is vague: `omh-deep-interview`, then `superpowers:brainstorming`. If clear: brainstorming alone. Done: the user confirmed the written-back understanding.
4. **Specify.** `speckit-specify`, then `speckit-clarify`. Feed the interview spec in as the feature description. Done: `spec.md` with no open `[NEEDS CLARIFICATION]`.
5. **Plan.** Also write `docs/architecture.md` and `docs/design.md` (see Deliverable docs). `speckit-plan`. Then `omh-ralplan` with `plan.md` as input: Planner, Architect and Critic review it. Fold accepted amendments back into `plan.md`. Done: `plan.md` updated and consensus recorded.
6. **Tasks.** Also write `docs/test-plan.md`; `ux.md` must exist by now. `speckit-tasks`, then `speckit-analyze`. Done: `tasks.md` exists and analyze reports no CRITICAL items.
7. **Bridge.** Convert `tasks.md` to `.omh/plans/ralph-plan.md`: one numbered task per `T###`, each with a testable acceptance criterion, keeping `[P]` markers as no-dependency. See `references/bridge.md`.
8. **Execute.** `omh-ralph` one task per call, or hand the tasks to Kanban workers. Each task uses superpowers:test-driven-development and records evidence. Tick the `T###` box in `tasks.md` only after ralph verifies it.
9. **Close.** Reconcile all deliverable docs with the as-built code and write `test-report.md`. `speckit-converge` to append unbuilt work and loop to 8 if any. Then superpowers:verification-before-completion and superpowers:requesting-code-review. Done: all boxes ticked, tests run this turn, review passed.

## Deliverable docs (required, not optional)

The build must ship its documents, not just code. All live in `specs/<NNN>-<name>/docs/` (single source of truth) and are written by the stage that has the knowledge, then reconciled to the as-built result at Close. Template and checklist: `references/deliverables.md`.

| Doc | Written at | Source | Owner |
|---|---|---|---|
| `ux.md` (UI/UX: users, flows, screens/wireframes, states, accessibility) | after stage 4 | spec.md user stories | UI designer |
| `architecture.md` (context, components, data flow, tech choices, ADRs, risks) | stage 5 | plan.md + ralplan Architect | architect |
| `design.md` (detailed design: modules, interfaces/APIs, data model, errors, security) | stage 5 | plan.md, architecture.md | developer |
| `test-plan.md` (strategy, cases mapped to spec acceptance criteria, environments) | stage 6 | spec.md + tasks.md | QA / reviewer |
| `test-report.md` (commands run, real output, pass/fail, coverage gaps) | stage 8-9 | actual test runs this turn | whoever runs them |
| `README`/user guide + `runbook.md` (install, run, ops, rollback) | stage 9 | as-built | technical writer |

Rules: no UI means `ux.md` says "N/A: no UI" with one line why, never silently skipped. Stage 6 `speckit-analyze` also checks docs exist and trace to spec requirement IDs. Stage 9 requires every doc reconciled with the built code (a doc that disagrees with the code is a FAIL) and `test-report.md` filled from output of this turn. On a task board, add one doc task per row. Deliver the docs with the build.

## Overlap decisions

| Need | Use | Not |
|---|---|---|
| Requirements | interview (vague) or brainstorming (clear), then speckit-specify | all three at once |
| Plan | speckit-plan, reviewed by ralplan | ralplan or writing-plans as the plan of record |
| Task list | speckit-tasks | superpowers:writing-plans |
| Execution | ralph or Kanban workers + TDD | executing-plans plus ralph together |
| Done check | verification-before-completion | "looks done" |

## Red Flags

| Thought | Reality |
|---|---|
| "Skip the spec, I know what to build" | Stage 4 is the contract. Write it. |
| "Ralph can plan as it goes" | Ralph refuses without a plan. Run the bridge. |
| "Tick the box, tests probably pass" | Tick only after evidence this turn. |
| "Copy the upstream skill text in here" | Call by name; copies go stale. |
| "Two plans are fine" | `plan.md` is the plan of record. |

## Missing pieces

If a named skill is not installed, say so and stop at that stage; do not improvise its output. `bash scripts/check.sh` (from this skill's folder) or `bash skills/spec-to-ship/scripts/check.sh` (from the repo) lists what is missing.
