---
name: jira-fix
description: Fixes a Jira ticket end to end — reads the issue, finds the code using the knowledge base, reproduces it with a failing test, explains the root cause, applies a minimal fix, verifies it, opens a PR and updates Jira with root cause and fix, all with approvals. Use for a Jira bug key, fix this ticket, or this is broken.
---

> **Before step 1:** follow `HUB/src/AGENTS.md` — resolve the team workspace `WS`; if none is configured (first run), run skill `workspace-setup` first.

# Jira Fix — from ticket to verified fix

**SDLC phase:** 5 · Maintenance & Support  ·  **Typical roles:** Developer, Support / L3 engineer, QA (verify)

Small and safe: minimal change, test first, explain the root cause. Notes go to `WS/fixes/<project>/<KEY>/` so the team learns from every fix.

**Inputs:** Jira key (e.g. `SHOP-123`) or URL  
**Output:** fix branch + PR, Jira comment; `WS/fixes/<project>/<KEY>/` `fix.md`

## Steps
Run the steps **in order, one at a time**: open a step file, do it, meet its checkpoint, then open the next. ⏸ = stop and wait for the user.

| # | Step | Checkpoint |
|---|------|-----------|
| 1 | [Read the ticket](steps/01-read-the-ticket.md) ⏸ | User confirmed the understanding of the problem. |
| 2 | [Locate the code](steps/02-locate-the-code.md) | Candidate area identified. |
| 3 | [Reproduce](steps/03-reproduce.md) ⏸ | Bug reproduced (or info requested). |
| 4 | [Find the root cause](steps/04-find-the-root-cause.md) ⏸ | User approved the fix approach. |
| 5 | [Fix](steps/05-fix.md) | Test green. |
| 6 | [Verify](steps/06-verify.md) | All checks green. |
| 7 | [PR and Jira update](steps/07-pr-and-jira-update.md) ⏸ | User approved each write. |
| 8 | [Record the lesson](steps/08-record-the-lesson.md) | Recorded. |

## Gate
Fix verified, PR open, Jira updated (all with approval), lesson recorded.
