# cr-analysis · Step 1/11 — Pick the project and create the CR folder

**Inputs:** `HUB/src/shared/pick-project.md`, `HUB/src/templates/state.md`

**Do:**
1. Follow `HUB/src/shared/pick-project.md` (architecture first).
2. Feature slug: kebab-case ≤40 chars, prefixed with the Jira key if known (`SHOP-120-checkout-v2`). Existing `state.md` → offer to resume at the first unfinished step.
3. Create `WS/crs/<project>/<feature>/``00-source/` and `state.md` from the template.

**Output:** CR folder

**Checkpoint ⏸ (wait for the user):** User confirmed project + slug.

**Next:** [02-read-and-snapshot-the-cr.md](02-read-and-snapshot-the-cr.md)
