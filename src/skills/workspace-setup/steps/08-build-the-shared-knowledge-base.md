# workspace-setup · Step 8/9 — Build the shared knowledge base

**Inputs:** scan results

**Do:**
1. For each project run skill `architecture-map` (ask: all now, or one at a time).
2. Write `WS/knowledge-base/system-landscape.md` (Mermaid flowchart of all projects + dependency matrix) and one `WS/knowledge-base/interdependencies/<from>--<to>.md` per dependency from `HUB/src/templates/interdependency.md`.
3. Update `WS/knowledge-base/README.md` with every project and interdependency; run `python3 HUB/src/scripts/kb_check.py WS`.

**Output:** knowledge base

**Checkpoint ⏸ (wait for the user):** KB check passes; landscape diagram shown to the user.

**Next:** [09-commit-and-share.md](09-commit-and-share.md)
