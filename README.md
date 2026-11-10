<!-- status:start -->
> **Status: Active** (checked 2026-11-03) 
> Stable skill; maintained as the toolkits it orders change.
<!-- status:end -->

# spec-to-ship

A Hermes Agent skill that runs one build pipeline across three toolkits:

- [github/spec-kit](https://github.com/github/spec-kit): constitution, spec, plan, tasks
- [oh-my-hermes (OMH)](https://github.com/witt3rd/oh-my-hermes): deep-interview, ralplan consensus, ralph verified execution
- [obra/superpowers](https://github.com/obra/superpowers): brainstorming, TDD, verification, code review

It does not copy their text. It orders their skills, picks one owner per overlapping job, and bridges `tasks.md` into OMH's ralph plan. Updates to the originals flow through.

## Requirements

Install the three toolkits first:

- spec-kit CLI and skills (`specify init <dir> --integration hermes`)
- OMH plugin and skills
- Superpowers plugin

Check what is missing:

```
bash skills/spec-to-ship/scripts/check.sh
```

## What a build delivers

Besides code and tests, every build ships its documents in `specs/<NNN>-<name>/docs/`, each citing spec requirement IDs:

| Doc | Written at |
|---|---|
| `ux.md` (users, flows, screens, states, accessibility; "N/A: no UI" if none) | after Specify |
| `architecture.md` (context, components, data flow, ADRs, risks) | Plan |
| `design.md` (modules, interfaces, data model, errors, security) | Plan |
| `test-plan.md` (strategy, cases mapped to acceptance criteria) | Tasks |
| `test-report.md` (commands run, real output, gaps) | Close |
| README / `runbook.md` (install, run, operate, roll back) | Close |

At Close, each doc is reconciled with the built code; a doc that disagrees with the code fails the stage. Templates: `skills/spec-to-ship/references/deliverables.md`.

## Installation

```
git clone https://github.com/n50sharp/spec-to-ship.git
bash spec-to-ship/install.sh
```

This copies `skills/spec-to-ship` to `~/.hermes/skills/software-development/spec-to-ship`. Restart the gateway so the skill loads.

## Use

Ask Hermes to build something non-trivial. The skill's stages run in order: setup, research, constitution, intent, specify, plan, tasks, bridge, execute, close, with the deliverable docs written along the way. See `skills/spec-to-ship/SKILL.md` and `references/`.

## Test

```
python3 -I tests/validate.py
```

## Licence

MIT.
