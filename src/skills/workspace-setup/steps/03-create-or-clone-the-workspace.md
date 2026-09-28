# workspace-setup · Step 3/9 — Create or clone the workspace

**Inputs:** choice from step 2, `HUB/src/templates/workspace/`

**Do:**
1. **Join:** `git clone <url> <path>` — if git asks for credentials, stop and ask the user to authenticate (git credential manager / `gh auth login`) and reply `done`; never handle tokens. Then read `workspace.yaml`; if it already lists projects go to step 6.
2. **Create:** copy the skeleton from `HUB/src/templates/workspace/` into the folder (README, workspace.yaml, .gitignore, knowledge-base/README.md, system-landscape.md, glossary.md, crs/), `git init -b main`, set `origin` if a remote was given.
3. Create `WS/local/repos/`; confirm `local/` is in `WS/.gitignore` (`git check-ignore -q local/repos` must succeed) before cloning anything.

**Output:** `WS` folder

**Checkpoint:** `WS/workspace.yaml` exists.

**Next:** [04-ask-for-the-list-of-projects.md](04-ask-for-the-list-of-projects.md)
