---
name: feature-build
description: Implements approved stories in the project repo — feature branch, one task at a time following repo conventions and the solution, automated tests from the test cases, failure triage, acceptance-criteria coverage and a self code review — logging everything in the CR folder. Use when stories from cr-analysis are ready, or when asked to implement or build a story.
---

> **Before step 1:** follow `HUB/src/AGENTS.md` — resolve the team workspace `WS`; if none is configured (first run), run skill `workspace-setup` first.

# Feature Build — implement, test, review

**SDLC phase:** 3 · Development & Testing  ·  **Typical roles:** Developer, QA / Test engineer

Never push, force-push, rebase shared branches or touch production config without approval. Never delete or skip tests to go green.

**Inputs:** `WS/crs/<project>/<feature>/` `05-solution.md`, `06-implementation-plan.md`, `07-stories.md`, `08-test-cases.md`; code in `WS/local/repos/<id>`  
**Output:** commits on `feature/<KEY>-<slug>`; `WS/crs/<project>/<feature>/` `09-impl-log.md`, `10-test-report.md`, `11-review.md`

## Steps
Run the steps **in order, one at a time**: open a step file, do it, meet its checkpoint, then open the next. ⏸ = stop and wait for the user.

| # | Step | Checkpoint |
|---|------|-----------|
| 1 | [Prepare](steps/01-prepare.md) | Baseline recorded in `09-impl-log.md`. |
| 2 | [Implement task by task](steps/02-implement-task-by-task.md) ⏸ | All planned tasks committed with green checks. |
| 3 | [Automate and run the test cases](steps/03-automate-and-run-the-test-cases.md) | No unexplained failures. |
| 4 | [Check acceptance-criteria coverage](steps/04-check-acceptance-criteria-coverage.md) ⏸ | All ACs covered. |
| 5 | [Self code review](steps/05-self-code-review.md) | No open blockers. |
| 6 | [Wrap up](steps/06-wrap-up.md) | User has the summary. |

## Gate
Tasks implemented, tests green, ACs covered, no review blockers — ready for `ship`.
