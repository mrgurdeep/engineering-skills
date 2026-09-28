# jira-fix · Step 1/8 — Read the ticket

**Inputs:** Jira via `HUB/src/shared/browser-login.md` (login wait)

**Do:**
1. Capture summary, description, steps to reproduce, expected vs actual, environment/version, attachments/logs, comments, linked issues, priority.
2. Pick the project from the key prefix (`HUB/src/shared/pick-project.md`); create `WS/fixes/<project>/<KEY>/` `fix.md` with the ticket summary and link.

**Output:** ticket summary in `fix.md`

**Checkpoint ⏸ (wait for the user):** User confirmed the understanding of the problem.

**Next:** [02-locate-the-code.md](02-locate-the-code.md)
