# guide · Step 2/5 — Help and training (help / learn intent)

**Inputs:** Catalogue and Roles tables below, `HUB/README.md`

**Do:**
1. Explain the skills as SDLC phases (Catalogue below): *0 Setup & Help → 1 Discovery & Architecture → 2 Requirements & Planning → 3 Development & Testing → 4 Release & Deployment → 5 Maintenance & Support*, with one example request per skill; draw the Mermaid flow from the README.
2. Explain the safety rules in plain words: approvals (⏸) before any Jira/Confluence/git write, the login wait (they sign in, the agent waits for **done**), shared vs local workspace (`local/` is never pushed).
3. Offer a **guided tour**: pick one of their projects and walk through `architecture-map` steps 1–3 read-only, then show where the output lives in the KB.
4. End with a 3-question check (e.g. *Which skill for a Jira bug? Where do CR outputs go? What does ⏸ mean?*) and the answers.

**Output:** short training session

**Checkpoint ⏸ (wait for the user):** The person knows their starting skill.

**Next:** [03-answer-questions-question-intent.md](03-answer-questions-question-intent.md)
