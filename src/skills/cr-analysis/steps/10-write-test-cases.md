# cr-analysis · Step 10/11 — Write test cases

**Inputs:** stories, AC, gaps, repo test conventions, `HUB/src/templates/test-case.md`

**Do:**
1. Per AC: ≥1 positive and ≥1 negative case (boundaries, decision tables, state transitions, error guessing).
2. Cross-cutting: roles, accessibility, responsive, i18n, performance, security, analytics, migration, flag on/off.
3. Rows `TC-n | story | AC | title | type | priority | preconditions | data | steps | expected | automation | test file` + `AC × TC` coverage matrix. Optional (approval): attach to Jira.

**Output:** `08-test-cases.md`

**Checkpoint ⏸ (wait for the user):** User approved test cases.

**Next:** [11-wrap-up.md](11-wrap-up.md)
