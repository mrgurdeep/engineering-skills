# cr-analysis · Step 6/11 — Identify gaps

**Inputs:** 01–03, KB, code in `WS/local/repos/<id>`, `HUB/src/templates/gaps.md`

**Do:**
1. Check every FR/NFR for: clarity, completeness (flows, errors, limits, audit, analytics, migration), consistency (CR vs docs vs Figma vs code), NFR targets, design gaps.
2. Feasibility per FR (exists / partial / none with `file:line`), impact matrix `FR × component`, cross-project impact via interdependency pages.
3. Table `G-n | category | requirement | gap | evidence | severity | proposed resolution | owner | status` + ready-to-paste questions for PM/Design.
4. Triage with the user: `accept resolution` · `ask PM` · `out of scope`.

**Output:** `04-gaps.md`

**Checkpoint ⏸ (wait for the user):** No untriaged blockers.

**Next:** [07-design-the-solution-and-changes.md](07-design-the-solution-and-changes.md)
