# cr-analysis · Step 2/11 — Read and snapshot the CR

**Inputs:** CR URL via `HUB/src/shared/browser-login.md` (login wait)

**Do:**
1. Save `00-source/cr.md`: front-matter `source_url, title, space, page_version, last_updated, owner, captured_on`; full body as Markdown with tables; unresolved comments as `> [comment] …`; in-scope child pages as extra files.
2. Re-run on a newer page version → diff against the previous snapshot and list changes.

**Output:** `00-source/cr.md`

**Checkpoint:** Snapshot matches the page version.

**Next:** [03-extract-requirements-and-acceptance-crit.md](03-extract-requirements-and-acceptance-crit.md)
