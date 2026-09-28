# ship · Step 4/6 — Prepare the release

**Inputs:** merged changes since last tag, test cases, NFRs

**Do:**
1. Release notes: user-facing + technical (migrations, config, breaking changes).
2. Checklist: pre-deploy (backups, migration order, env vars, flags), per-environment steps, smoke tests from `08-test-cases.md`, flag ramp, dashboards/alerts to watch, rollback triggers and steps.

**Output:** `13-release.md`

**Checkpoint ⏸ (wait for the user):** User approved the release plan.

**Next:** [05-release-and-verify.md](05-release-and-verify.md)
