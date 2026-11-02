---
name: spec-to-ship
description: Use when starting a non-trivial build, feature or project that needs requirements, a plan, tasks and verified execution, before writing any code.
version: 0.1.0
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

0. **Setup.** Project dir exists; on a mission, a Kanban task exists. Run `specify init <dir> --integration hermes --ignore-agent-tools` once. Done: `.specify/integration.json` exists.
1. **Research** (only if the domain is unfamiliar). `omh-deep-research`. Done: `.omh/research/*-report.md`.
2. **Constitution.** `speckit-constitution`. Done: `.specify/memory/constitution.md` has no placeholders.
3. **Intent.** If the goal is vague: `omh-deep-interview`, then `superpowers:brainstorming`. If clear: brainstorming alone. Done: the user confirmed the written-back understanding.
4. **Specify.** `speckit-specify`, then `speckit-clarify`. Feed the interview spec in as the feature description. Done: `spec.md` with no open `[NEEDS CLARIFICATION]`.
5. **Plan.** `speckit-plan`. Then `omh-ralplan` with `plan.md` as input: Planner, Architect and Critic review it. Fold accepted amendments back into `plan.md`. Done: `plan.md` updated and consensus recorded.
6. **Tasks.** `speckit-tasks`, then `speckit-analyze`. Done: `tasks.md` exists and analyze reports no CRITICAL items.
7. **Bridge.** Convert `tasks.md` to `.omh/plans/ralph-plan.md`: one numbered task per `T###`, each with a testable acceptance criterion, keeping `[P]` markers as no-dependency. See `references/bridge.md`.
8. **Execute.** `omh-ralph` one task per call, or hand the tasks to Kanban workers. Each task uses superpowers:test-driven-development and records evidence. Tick the `T###` box in `tasks.md` only after ralph verifies it.
9. **Close.** `speckit-converge` to append unbuilt work and loop to 8 if any. Then superpowers:verification-before-completion and superpowers:requesting-code-review. Done: all boxes ticked, tests run this turn, review passed.

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

If a named skill is not installed, say so and stop at that stage; do not improvise its output. `bash scripts/check.sh` lists what is missing.
