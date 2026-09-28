---
name: architecture-map
description: FIRST engineering step for any project. Analyses a repository and its Confluence architecture pages to create or refresh the project's architecture in the knowledge base — context, containers, modules, data model, APIs, integrations, runtime, quality and cross-project dependencies — with Mermaid diagrams and file citations. Use before CR work, when onboarding a repo, or when asked to document the architecture.
---

> **Before step 1:** follow `HUB/src/AGENTS.md` — resolve the team workspace `WS`; if none is configured (first run), run skill `workspace-setup` first.

# Architecture Map

**SDLC phase:** 1 · Discovery & Architecture  ·  **Typical roles:** Architect / Tech lead, new joiners, anyone before changing code

Everything later (gaps, solution, stories) builds on these pages, so every claim cites `path:line` or a URL.

**Inputs:** project `WS/local/repos/<id>`, Confluence space, existing `WS/knowledge-base/projects/<id>/`  
**Output:** `WS/knowledge-base/projects/<id>/{overview,architecture,data-model,apis,integrations,runtime-and-deploy,quality-and-debt}.md`, `modules/`, `decisions/`

## Steps
Run the steps **in order, one at a time**: open a step file, do it, meet its checkpoint, then open the next. ⏸ = stop and wait for the user.

| # | Step | Checkpoint |
|---|------|-----------|
| 1 | [Decide full or incremental](steps/01-decide-full-or-incremental.md) | Mode stated. |
| 2 | [Inventory the repo](steps/02-inventory-the-repo.md) | Inventory complete with file citations. |
| 3 | [System context and containers (C4 L1–L2)](steps/03-system-context-and-containers-c4-l1-l2.md) | Diagrams render; every box cited. |
| 4 | [Modules and key flows (C4 L3)](steps/04-modules-and-key-flows-c4-l3.md) | Each module page has Related links. |
| 5 | [Data model and APIs](steps/05-data-model-and-apis.md) | All endpoints listed with handlers. |
| 6 | [Integrations and cross-project links](steps/06-integrations-and-cross-project-links.md) | Every dependency has a page; landscape diagram renders; links both ways. |
| 7 | [Runtime, quality and debt](steps/07-runtime-quality-and-debt.md) | Pages written with citations. |
| 8 | [Reconcile with Confluence](steps/08-reconcile-with-confluence.md) | Sources listed with URLs. |
| 9 | [Finish and review](steps/09-finish-and-review.md) ⏸ | User confirmed. |

## Gate
User confirmed the architecture (corrections applied). Suggest commit `kb(<id>): architecture <full|incremental>`.
