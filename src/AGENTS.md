# Engineering Skills — shared agent rules

**CR** = Change Request document (usually a Confluence page) — the input for planned work.
Not sure which skill to use? → **`guide`**.

## Skills (7) by SDLC phase
| SDLC phase | Skill | Purpose |
|---|---|---|
| 0 · Setup & Help | `guide` | route any request to the right skill; help, training, KB questions |
| 0 · Setup & Help | `workspace-setup` | first run / join team / add projects |
| 1 · Discovery & Architecture | `architecture-map` | project architecture + interdependencies in the KB (architecture first) |
| 2 · Requirements & Planning | `cr-analysis` | CR → requirements → gaps → solution → plan → Jira stories → test cases |
| 3 · Development & Testing | `feature-build` | implement stories, test, self-review |
| 4 · Release & Deployment | `ship` | PR & CI → release → Confluence/Jira handoff |
| 5 · Maintenance & Support | `jira-fix` | Jira ticket → root cause → fix → PR → Jira update |

Shared procedures used by the skills (not skills themselves): `HUB/src/shared/pick-project.md`,
`HUB/src/shared/browser-login.md`, `HUB/src/shared/kb-update.md`.

## Two locations, never mixed
| Name | What | Where |
|---|---|---|
| `HUB` | this skills repo (code only) | `$ENG_SKILLS_HOME`, default `~/engineering-skills` (Windows `%USERPROFILE%\engineering-skills`) |
| `WS` | the **team workspace** — separate git repo shared by the team | `workspace:` in `~/.config/engineering-skills/config.yaml` |

## Before step 1 of any skill
1. Read `~/.config/engineering-skills/config.yaml`. Missing, no `workspace`, folder missing, or no projects in
   `WS/workspace.yaml` → run **`workspace-setup`** first, then return.
2. Read `WS/workspace.yaml` + personal overrides in `WS/local/overrides.yaml`.

## Workspace layout (`WS`)
```
workspace.yaml               SHARED  projects: id, name, git_url, branch, jira, confluence, figma, stack, commands, depends_on
knowledge-base/              SHARED  README (index), system-landscape.md, interdependencies/<a>--<b>.md,
                                     glossary.md, projects/<id>/ (architecture, modules, APIs, data, ADRs, features, known-issues)
crs/<project>/<feature>/     SHARED  CR analysis + build/ship artifacts, state.md
fixes/<project>/<KEY>/       SHARED  jira-fix notes (root cause, fix, tests)
local/                       LOCAL   git-ignored: repos/<id>/ clones, overrides.yaml
```

## How to run a skill
Each skill = `SKILL.md` (index) + `steps/NN-*.md`. Open **one step at a time**, do it, meet its checkpoint,
then open the next. ⏸ = stop and wait for the user.

## Always
- **Login wait** for Jira/Confluence/Figma (`HUB/src/shared/browser-login.md`): the user signs in, you wait for
  `done`. Never ask for, read, store or type credentials, tokens or MFA codes.
- Approval before any Jira write, Confluence publish, git push, PR, merge or deploy — per action.
- Templates from `HUB/src/templates/`; outputs only in `WS`, never in `HUB`.
- Cite sources (Jira keys, Confluence title+URL, Figma frame+node-id, `path:line@commit`). Missing or
  conflicting info → open questions. Never invent facts. No secrets/PII in `WS`.
- Commits in `WS` stage shared paths only (`workspace.yaml knowledge-base crs fixes`), never `local/`.
  Prefixes: `kb(<project>):`, `cr(<project>):`, `fix(<project>):`, `workspace:`.
- Code changes in `WS/local/repos/<id>` on `feature/<KEY>-<slug>` or `fix/<KEY>-<slug>`, following repo conventions.
- Skills exist only in `HUB/src/skills/`; installs link to them. Never copy a skill anywhere.
