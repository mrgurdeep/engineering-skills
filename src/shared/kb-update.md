# Shared procedure — update the knowledge base

Run at the end of every skill so the team's shared KB (`WS/knowledge-base/`) stays current.

1. **Extract durable facts** from what you just produced: new/changed module, endpoint, entity, integration,
   interdependency, decision, domain term, known issue/gotcha. Feature-only details stay in `crs/` or `fixes/`.
2. **Update, don't duplicate:** search the KB first; one concept per page; front-matter from
   `HUB/src/templates/kb-page.md` (title, type, project, related, sources, last_verified, last_verified_commit).
3. **Readable:** plain-language summary first; Mermaid diagram on overview, architecture, landscape and
   interdependency pages; tables for endpoints/entities. Cite `path:line@commit` or URLs. No secrets/PII.
4. **Link both ways** with relative links; first mention of a glossary term links to `glossary.md#term`;
   update `projects/<id>/features.md` (CRs) or `projects/<id>/known-issues.md` (fixes).
5. **Index & landscape:** every page reachable from `README.md`; refresh `system-landscape.md` if dependencies changed.
6. **Check:** `python3 HUB/src/scripts/kb_check.py WS`; fix broken links/orphans.
7. Suggest a commit that stages only shared paths: `git add knowledge-base crs fixes workspace.yaml` →
   `kb(<project>): …` (never `local/`).
