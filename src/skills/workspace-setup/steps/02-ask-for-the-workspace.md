# workspace-setup · Step 2/9 — Ask for the workspace

**Inputs:** user

**Do:**
1. Ask: **"Where should the team workspace live?"** with options:
2. (a) **Join existing** — the team's workspace git URL (e.g. `https://github.com/<org>/eng-workspace.git`) and a local folder (default `~/eng-workspace`).
3. (b) **Create new** — a local folder (default `~/eng-workspace`) and, optionally, an empty remote git URL to share it later.
4. Save `workspace: <absolute path>` (and `remote:` if given) to `~/.config/engineering-skills/config.yaml`.

**Output:** workspace path saved

**Checkpoint ⏸ (wait for the user):** User chose join or create; config file written.

**Next:** [03-create-or-clone-the-workspace.md](03-create-or-clone-the-workspace.md)
