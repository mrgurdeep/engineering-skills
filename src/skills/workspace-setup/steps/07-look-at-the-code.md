# workspace-setup · Step 7/9 — Look at the code

**Inputs:** each repo

**Do:**
1. Quick scan per project: languages/frameworks, entry points, package manifest scripts → fill `stack` and `commands` in `workspace.yaml`.
2. Detect links between projects: base URLs/env var names, API clients, shared packages, topics/queues, shared DB names — match them to other projects' APIs → propose `depends_on`.
3. Show a first-pass table `project | stack | depends_on | evidence (file:line)`.

**Output:** scan summary

**Checkpoint ⏸ (wait for the user):** User confirmed or corrected the dependencies.

**Next:** [08-build-the-shared-knowledge-base.md](08-build-the-shared-knowledge-base.md)
