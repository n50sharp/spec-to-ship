# Deliverable docs

Path: `specs/<NNN>-<name>/docs/`. Each doc cites spec requirement IDs (FR-###) so analyze can check traceability.

## ux.md
Users/personas; key journeys; screen list with wireframe (ASCII or image link); component states (empty, loading, error, success); copy; accessibility; responsive notes. No UI: one line "N/A: <why>".

## architecture.md
Context/scope; component diagram (mermaid); data flow; tech choices with rejected alternatives (ADR list); deployment/ports/units; NFRs (perf, security); risks and mitigations.

## design.md
Modules and responsibilities; interfaces/APIs (signatures, schemas); data model; error handling; security/authz; config keys; migration/rollback.

## test-plan.md
Strategy (unit/integration/e2e); case table: ID, spec requirement, steps, expected; environments and fixtures; exit criteria.

## test-report.md
Filled at Close only from output produced this turn: commands, exit codes, pass/fail counts, failures, known gaps, requirements with no test.

## README / runbook.md
Install, run, configure, operate, troubleshoot, rollback. Verified by following it once.

## Done check
All files exist, no placeholders, FR IDs resolve, content matches the built code (spot-check by command), test-report matches a fresh run.
