# cr-analysis · Step 7/11 — Design the solution and changes

**Inputs:** requirements, accepted gaps, KB, code, `HUB/src/templates/tech-design.md`

**Do:**
1. Current state (cited) → options with a recommendation for each significant decision.
2. **Change list** `C-n | component | files | type | description | covers | risk | size` — every FR/NFR/accepted gap maps to ≥1 change.
3. API contracts, data model & migrations (with rollback), security, performance, observability, feature flag & rollout, target-architecture Mermaid diagram. Irreversible decisions → ADR (`HUB/src/templates/adr.md`) in the KB.

**Output:** `05-solution.md`

**Checkpoint ⏸ (wait for the user):** User approved the solution.

**Next:** [08-plan-the-implementation.md](08-plan-the-implementation.md)
