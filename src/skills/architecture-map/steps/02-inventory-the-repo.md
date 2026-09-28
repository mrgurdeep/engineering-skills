# architecture-map · Step 2/9 — Inventory the repo

**Inputs:** repo (read-only)

**Do:**
1. Languages, frameworks, package manifests, monorepo layout, entry points.
2. Config/env files — **names only, never secret values**; Docker/K8s/IaC; CI pipelines; test setup.
3. Hotspots: `git log --format= --name-only | sort | uniq -c | sort -rn | head -20`.

**Output:** inventory notes

**Checkpoint:** Inventory complete with file citations.

**Next:** [03-system-context-and-containers-c4-l1-l2.md](03-system-context-and-containers-c4-l1-l2.md)
