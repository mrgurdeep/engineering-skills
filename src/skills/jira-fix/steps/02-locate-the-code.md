# jira-fix · Step 2/8 — Locate the code

**Inputs:** KB (architecture, modules, interdependencies, known issues), `WS/local/repos/<id>`

**Do:**
1. Use the KB to find the component; search for error messages, stack-trace frames, endpoints, UI text.
2. Check recent history: `git log -p --since=<date> -- <paths>`, `git blame` on suspect lines; check related known issues.

**Output:** suspect files with `file:line`

**Checkpoint:** Candidate area identified.

**Next:** [03-reproduce.md](03-reproduce.md)
