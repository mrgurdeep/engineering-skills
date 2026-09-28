# workspace-setup · Step 1/9 — Check existing setup

**Inputs:** `~/.config/engineering-skills/config.yaml` (Windows: `%USERPROFILE%\.config\engineering-skills\config.yaml`)

**Do:**
1. If `workspace:` is set, the folder exists and `WS/workspace.yaml` has projects → report it and stop, unless the user asked to change the workspace or add projects (then go to step 4).
2. Otherwise tell the user: *"First run — let's set up your team workspace."*

**Output:** setup state

**Checkpoint:** State reported to the user.

**Next:** [02-ask-for-the-workspace.md](02-ask-for-the-workspace.md)
