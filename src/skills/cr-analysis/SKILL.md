---
name: cr-analysis
description: Takes a CR (Change Request) document from Confluence and turns it into delivery-ready work — requirements with acceptance criteria, Confluence and Figma context, gaps, the solution and code changes, an implementation plan, Jira stories and test cases — saved in the shared team workspace. Use when someone shares a CR link, asks to analyse a CR, find gaps, plan a change, or create stories and test cases.
---

> **Before step 1:** follow `HUB/src/AGENTS.md` — resolve the team workspace `WS`; if none is configured (first run), run skill `workspace-setup` first.

# CR Analysis — from CR document to stories and test cases

**SDLC phase:** 2 · Requirements & Planning  ·  **Typical roles:** BA / Product owner, Tech lead / Architect, QA (test cases)

Every step writes one artifact to `WS/crs/<project>/<feature>/` and updates `state.md`, so anyone on the team can review or resume. Nothing is invented — unclear items become open questions.

**Inputs:** Confluence CR URL (or file / pasted text), project  
**Output:** `WS/crs/<project>/<feature>/` `00-source/cr.md`, `01-requirements.md` … `08-test-cases.md`, `state.md`

## Steps
Run the steps **in order, one at a time**: open a step file, do it, meet its checkpoint, then open the next. ⏸ = stop and wait for the user.

| # | Step | Checkpoint |
|---|------|-----------|
| 1 | [Pick the project and create the CR folder](steps/01-pick-the-project-and-create-the-cr-folde.md) ⏸ | User confirmed project + slug. |
| 2 | [Read and snapshot the CR](steps/02-read-and-snapshot-the-cr.md) | Snapshot matches the page version. |
| 3 | [Extract requirements and acceptance criteria](steps/03-extract-requirements-and-acceptance-crit.md) ⏸ | User approved requirements or answered blocking questions. |
| 4 | [Gather Confluence context](steps/04-gather-confluence-context.md) | Sources listed with URLs. |
| 5 | [Review Figma designs (skip if none)](steps/05-review-figma-designs-skip-if-none.md) ⏸ | User confirmed frames in scope. |
| 6 | [Identify gaps](steps/06-identify-gaps.md) ⏸ | No untriaged blockers. |
| 7 | [Design the solution and changes](steps/07-design-the-solution-and-changes.md) ⏸ | User approved the solution. |
| 8 | [Plan the implementation](steps/08-plan-the-implementation.md) ⏸ | User approved the plan. |
| 9 | [Create Jira stories](steps/09-create-jira-stories.md) ⏸ | User decided; created keys recorded. |
| 10 | [Write test cases](steps/10-write-test-cases.md) ⏸ | User approved test cases. |
| 11 | [Wrap up](steps/11-wrap-up.md) | User has the summary. |

## Gate
Requirements, gaps, solution, plan, stories and test cases approved — ready for `feature-build`.
