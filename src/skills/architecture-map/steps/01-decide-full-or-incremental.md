# architecture-map · Step 1/9 — Decide full or incremental

**Inputs:** `architecture.md` front-matter, `git -C WS/local/repos/<id> rev-parse HEAD`

**Do:**
1. No doc → full run.
2. Doc exists → `git diff --stat <last_verified_commit>..HEAD`; if >50 commits / 30 days or structural files changed, refresh only the affected pages.
3. Tell the user which mode and why.

**Output:** mode + list of pages to (re)write

**Checkpoint:** Mode stated.

**Next:** [02-inventory-the-repo.md](02-inventory-the-repo.md)
