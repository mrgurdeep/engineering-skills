# jira-fix · Step 5/8 — Fix

**Inputs:** approved option

**Do:**
1. Branch `fix/<KEY>-<slug>` from the default branch (or the release branch the user names).
2. Minimal change; failing test now passes; add regression tests for nearby edge cases.
3. Commit `<KEY>: <summary>`.

**Output:** fix commit

**Checkpoint:** Test green.

**Next:** [06-verify.md](06-verify.md)
