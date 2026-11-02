# Bridge: tasks.md to ralph-plan.md

Input line (spec-kit): `- [ ] T005 [P] Implement auth middleware in src/middleware/auth.py`

Output entry (OMH ralph):

```
### Task 5: Implement auth middleware
- Source: tasks.md T005
- Depends on: none            # [P] markers and phase order decide this
- Files: src/middleware/auth.py
- Acceptance: <a command or test that exits 0 and proves it, e.g. pytest tests/test_auth.py -q>
```

Rules:
- One task per `T###`; never merge, never split without updating `tasks.md`.
- Acceptance must be runnable. "Implementation complete" is rejected by ralph.
- Take acceptance from `spec.md` user-story scenarios and `plan.md` contracts.
- After ralph verifies a task, tick the matching box in `tasks.md`.
