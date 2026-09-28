# Shared procedure — pick the project

Used by `cr-analysis`, `feature-build`, `jira-fix`, `ship`. Never guess the project.

1. Read `WS/workspace.yaml` (+ `WS/local/overrides.yaml`). No projects → run skill `workspace-setup`.
2. If the user's request already names a project (or a Jira key whose prefix matches a project's
   `jira.project_key`), confirm it; otherwise show a numbered table
   `# | id | name | Jira | Confluence | Figma | architecture doc (✅ + last_verified)` and ask
   **"Which project?"** ⏸
3. Make sure the code is current in `WS/local/repos/<id>` (or the override path):
   missing → clone `git_url` (auth prompt → ask the user to authenticate and reply `done`);
   present → report branch, clean/dirty, commits behind; offer `git pull --ff-only`.
   Never stash, reset or switch branches unasked.
4. If `WS/knowledge-base/projects/<id>/architecture.md` is missing or >50 commits / 30 days behind HEAD,
   offer to run skill `architecture-map` first (architecture first).
