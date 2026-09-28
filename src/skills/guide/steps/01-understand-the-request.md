# guide · Step 1/5 — Understand the request

**Inputs:** user message, `WS` (may not exist yet)

**Do:**
1. Classify into one intent: **help / learn** · **setup / join** · **question about code or systems** · **understand a project** · **new CR** · **build stories** · **fix a Jira ticket** · **ship / release** · **full flow (CR → ship)**.
2. Pull out useful details: project name, Jira key (e.g. `SHOP-123`), Confluence/Figma URLs, feature name.
3. No workspace configured → the answer is `workspace-setup` first (say why).

**Output:** intent + details

**Checkpoint:** Intent decided, or one clarifying question asked.

**Next:** [02-help-and-training-help-learn-intent.md](02-help-and-training-help-learn-intent.md)
