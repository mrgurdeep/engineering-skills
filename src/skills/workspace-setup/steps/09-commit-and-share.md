# workspace-setup · Step 9/9 — Commit and share

**Inputs:** `WS`

**Do:**
1. Verify nothing local is staged: `git status --porcelain` must show no `local/` paths and no nested `.git` folders; then `git add workspace.yaml knowledge-base crs fixes README.md .gitignore && git commit -m "workspace: init <n> projects"` (on approval).
2. Push to the team remote only on explicit approval.
3. Tell the user how teammates join: install the skills, run any skill, choose **Join existing** with the workspace URL.

**Output:** committed workspace

**Checkpoint ⏸ (wait for the user):** User approved commit (and push) or declined.

**Next:** Back to [SKILL.md](../SKILL.md) → **Gate**
