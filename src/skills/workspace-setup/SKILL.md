---
name: workspace-setup
description: First-run setup, triggered automatically when no team workspace is configured. Asks where the shared team workspace lives (create new or clone the team's existing one), asks for the list of projects and each project's git repo, clones and reads the code, and builds the shared knowledge base with a system landscape and interdependency pages in Mermaid. Use on first use, to join a team workspace, or to add projects.
---

> **Before step 1:** follow `HUB/src/AGENTS.md` — resolve the team workspace `WS`; if none is configured (first run), run skill `workspace-setup` first.

# Workspace Setup (first run)

**SDLC phase:** 0 · Setup & Help  ·  **Typical roles:** Tech lead / Engineering manager (once per team), everyone (join)

The workspace (`WS`) is a separate git repo the whole team shares: `workspace.yaml`, `knowledge-base/` (KB + flows), `crs/` and `fixes/` are **shared**. Everything local — cloned project code in `WS/local/repos/` and personal settings in `WS/local/overrides.yaml` — sits in `WS/local/`, which is git-ignored and never pushed. The skills repo (`HUB`) is never written to.

**Inputs:** `~/.config/engineering-skills/config.yaml` (may not exist), user answers  
**Output:** configured `WS` with projects, cloned repos, knowledge base + system landscape

## Steps
Run the steps **in order, one at a time**: open a step file, do it, meet its checkpoint, then open the next. ⏸ = stop and wait for the user.

| # | Step | Checkpoint |
|---|------|-----------|
| 1 | [Check existing setup](steps/01-check-existing-setup.md) | State reported to the user. |
| 2 | [Ask for the workspace](steps/02-ask-for-the-workspace.md) ⏸ | User chose join or create; config file written. |
| 3 | [Create or clone the workspace](steps/03-create-or-clone-the-workspace.md) | `WS/workspace.yaml` exists. |
| 4 | [Ask for the list of projects](steps/04-ask-for-the-list-of-projects.md) ⏸ | User confirmed the project list. |
| 5 | [Ask for each project's git repo and links](steps/05-ask-for-each-project-s-git-repo-and-link.md) ⏸ | User approved the diff. |
| 6 | [Clone the repos](steps/06-clone-the-repos.md) ⏸ | Every project is cloned, overridden or explicitly skipped. |
| 7 | [Look at the code](steps/07-look-at-the-code.md) ⏸ | User confirmed or corrected the dependencies. |
| 8 | [Build the shared knowledge base](steps/08-build-the-shared-knowledge-base.md) ⏸ | KB check passes; landscape diagram shown to the user. |
| 9 | [Commit and share](steps/09-commit-and-share.md) ⏸ | User approved commit (and push) or declined. |

## Gate
Workspace configured, projects listed with git repos, code cloned and scanned, landscape + interdependencies written.
