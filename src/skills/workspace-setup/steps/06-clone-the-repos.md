# workspace-setup · Step 6/9 — Clone the repos

**Inputs:** `WS/workspace.yaml`, overrides

**Do:**
1. For each project without an override: `git clone --branch <branch> <git_url> WS/local/repos/<id>`; if it exists, `git -C WS/local/repos/<id> pull --ff-only`.
2. Auth prompt or 403 → stop, ask the user to authenticate and reply `done` (never handle credentials); allow `skip`.

**Output:** local code for every project

**Checkpoint ⏸ (wait for the user):** Every project is cloned, overridden or explicitly skipped.

**Next:** [07-look-at-the-code.md](07-look-at-the-code.md)
