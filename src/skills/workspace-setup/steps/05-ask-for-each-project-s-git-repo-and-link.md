# workspace-setup · Step 5/9 — Ask for each project's git repo and links

**Inputs:** project list

**Do:**
1. For each project ask for: **git repo URL** (required), branch (default `main`), and optionally Jira project key/board URL, Confluence space/CR parent URL, Figma file URLs. Unknown → `TODO`.
2. If the user already has a local clone, record its path in `WS/local/overrides.yaml` (`repos: {<id>: <path>}`) instead of cloning.
3. Write the entries to `WS/workspace.yaml` and show the diff.

**Output:** `workspace.yaml` entries

**Checkpoint ⏸ (wait for the user):** User approved the diff.

**Next:** [06-clone-the-repos.md](06-clone-the-repos.md)
