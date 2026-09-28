# cr-analysis · Step 9/11 — Create Jira stories

**Inputs:** plan, Jira (login wait), `HUB/src/templates/jira-story.md`

**Do:**
1. Read the existing backlog (JQL on the project/epic/keywords); map duplicates and already-covered FRs.
2. Draft epic + stories (summary, user story, Given/When/Then AC, technical notes with `C-n`, DoD, labels, suggested points, links to CR page/Figma) + sub-tasks from `T-n`.
3. Ask: `create all` · `create <ids>` · `edit` · `don't create`. Create only on approval, one at a time, verify keys, write them back into 07 and the traceability table.

**Output:** `07-stories.md` (+ Jira keys)

**Checkpoint ⏸ (wait for the user):** User decided; created keys recorded.

**Next:** [10-write-test-cases.md](10-write-test-cases.md)
