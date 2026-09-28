# feature-build · Step 5/6 — Self code review

**Inputs:** `git diff <default>...HEAD`

**Do:**
1. Correctness vs AC/solution; security (authz, validation, injection, XSS, IDOR, secrets, PII in logs, dependency audit); performance (N+1, unbounded loops, bundle size); architecture boundaries & interdependency contracts; a11y vs design; readability; logs/metrics/flags; reversible migrations.
2. Findings `R-n | severity | file:line | issue | fix` — verified only. Fix blockers (step 2) and re-check.

**Output:** `11-review.md`

**Checkpoint:** No open blockers.

**Next:** [06-wrap-up.md](06-wrap-up.md)
