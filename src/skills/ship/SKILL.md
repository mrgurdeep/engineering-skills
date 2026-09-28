---
name: ship
description: Takes finished work to production and closes the loop — opens the pull request with full context, gets CI green, prepares release notes, deployment checklist and rollback plan, and updates Confluence and Jira after release, each write with explicit approval. Use when code is ready for a PR, a release, or post-release documentation.
---

> **Before step 1:** follow `HUB/src/AGENTS.md` — resolve the team workspace `WS`; if none is configured (first run), run skill `workspace-setup` first.

# Ship — PR, CI, release and handoff

**SDLC phase:** 4 · Release & Deployment  ·  **Typical roles:** Developer, DevOps / Release manager, Tech lead

Push, PR, reviewers, deploys, Confluence publishes and Jira transitions each need explicit approval. Releases go only through the project's normal pipeline.

**Inputs:** branch in `WS/local/repos/<id>`; CR folder or fix folder  
**Output:** PR + green CI; `WS/crs/<project>/<feature>/` `12-pr.md`, `13-release.md`, `14-handoff.md` (or notes in `fix.md`)

## Steps
Run the steps **in order, one at a time**: open a step file, do it, meet its checkpoint, then open the next. ⏸ = stop and wait for the user.

| # | Step | Checkpoint |
|---|------|-----------|
| 1 | [Pre-checks](steps/01-pre-checks.md) | All pre-checks pass. |
| 2 | [Open the PR](steps/02-open-the-pr.md) ⏸ | User approved the push and PR. |
| 3 | [Get CI green](steps/03-get-ci-green.md) | CI green or failures explained. |
| 4 | [Prepare the release](steps/04-prepare-the-release.md) ⏸ | User approved the release plan. |
| 5 | [Release and verify](steps/05-release-and-verify.md) | Release verified. |
| 6 | [Hand off docs and Jira](steps/06-hand-off-docs-and-jira.md) ⏸ | User approved each write. |

## Gate
PR merged, release verified, docs/Jira/KB reflect what shipped.
