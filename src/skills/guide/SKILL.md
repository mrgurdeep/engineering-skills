---
name: guide
description: Entry point and help for the engineering skills. Takes any request in plain words, works out which skill fits (workspace-setup, architecture-map, cr-analysis, feature-build, jira-fix, ship) and runs it; explains how everything works, gives a guided tour of the SDLC phases for people new to the skills, and answers questions from the team knowledge base. Use when unsure which skill to use, for help or training, or for questions like how does X work.
---

> **Before step 1:** follow `HUB/src/AGENTS.md` — resolve the team workspace `WS`; if none is configured (first run), run skill `workspace-setup` first.

# Guide — ask anything, get routed, learn the skills

**SDLC phase:** 0 · Setup & Help  ·  **Typical roles:** Everyone

One door for everyone. If a request clearly matches a skill, confirm and run it. If someone is new, teach them. If it's a question, answer it from the knowledge base.

**Inputs:** the user's request (anything)  
**Output:** the right skill running, an answer, or a short training session

## Steps
Run the steps **in order, one at a time**: open a step file, do it, meet its checkpoint, then open the next. ⏸ = stop and wait for the user.

| # | Step | Checkpoint |
|---|------|-----------|
| 1 | [Understand the request](steps/01-understand-the-request.md) | Intent decided, or one clarifying question asked. |
| 2 | [Help and training (help / learn intent)](steps/02-help-and-training-help-learn-intent.md) ⏸ | The person knows their starting skill. |
| 3 | [Answer questions (question intent)](steps/03-answer-questions-question-intent.md) | Answer cites KB pages or sources. |
| 4 | [Route to a skill](steps/04-route-to-a-skill.md) ⏸ | User confirmed the skill. |
| 5 | [Run it and suggest the next step](steps/05-run-it-and-suggest-the-next-step.md) | Skill completed or paused at a gate. |

## Gate
The user got an answer, a training session, or the right skill running.

## Catalogue (by SDLC phase)
| SDLC phase | Skill | Use it when… | Typical roles | Output (in `WS`) |
|---|---|---|---|---|
| **0 · Setup & Help** | `guide` | unsure which skill, need help or training | everyone | answer / routed skill |
| **0 · Setup & Help** | `workspace-setup` | first time, joining the team, adding projects | tech lead, eng manager | `workspace.yaml`, clones in `local/`, KB landscape |
| **1 · Discovery & Architecture** | `architecture-map` | onboarding a repo, code changed a lot, need diagrams | architect, tech lead, new joiners | `knowledge-base/projects/<id>/`, interdependencies |
| **2 · Requirements & Planning** | `cr-analysis` | you have a CR (Change Request) document in Confluence | BA/product owner, tech lead, QA | requirements, gaps, solution, plan, Jira stories, test cases in `crs/` |
| **3 · Development & Testing** | `feature-build` | stories are ready to implement | developer, QA | code, tests, review notes |
| **4 · Release & Deployment** | `ship` | code is ready for a PR / release | developer, DevOps/release manager | PR + CI, release notes, Confluence/Jira updated |
| **5 · Maintenance & Support** | `jira-fix` | you have a Jira bug/ticket to fix | developer, support/L3, QA | root cause, fix, PR, Jira update; notes in `fixes/` |

## Routing
| The user says something like… | Skill |
|---|---|
| "help", "what can you do", "how do I…", "train me", "I'm new" | `guide` (help / learn) |
| "set up", "join the workspace", "add project X" | `workspace-setup` |
| "how does X work", "what calls Y", "draw the architecture of Z" | `guide` (question) or `architecture-map` |
| a Confluence CR link, "analyse this CR", "create stories for …" | `cr-analysis` |
| "implement SHOP-120", "build these stories" | `feature-build` |
| a Jira bug key, "fix SHOP-123", "this ticket is broken" | `jira-fix` |
| "open a PR", "release", "update Confluence/Jira after release" | `ship` |
| "do the whole thing for this CR" | `cr-analysis` → `feature-build` → `ship` |
