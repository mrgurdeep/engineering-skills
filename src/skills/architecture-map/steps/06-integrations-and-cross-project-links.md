# architecture-map · Step 6/9 — Integrations and cross-project links

**Inputs:** HTTP clients, SDKs, shared packages, env URL names, other projects in `WS/workspace.yaml`

**Do:**
1. `integrations.md`: external services and how they are called.
2. For every other team project this one calls or is called by (HTTP base URLs, SDK/package names, topics, shared DBs — matched against `WS/workspace.yaml` and the other repos in `WS/local/repos/`): write/refresh `WS/knowledge-base/interdependencies/<from>--<to>.md` from `HUB/src/templates/interdependency.md` (what, how, contract table with caller/provider files, sequence diagram, failure modes).
3. Update `WS/knowledge-base/system-landscape.md`: Mermaid `flowchart` of all projects (arrows labelled with protocol, linking to the interdependency pages), the dependency matrix, and shared components/infrastructure. Set `depends_on` in `WS/workspace.yaml`.

**Output:** `integrations.md`, `interdependencies/*.md`, updated system landscape

**Checkpoint:** Every dependency has a page; landscape diagram renders; links both ways.

**Next:** [07-runtime-quality-and-debt.md](07-runtime-quality-and-debt.md)
