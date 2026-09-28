# feature-build · Step 3/6 — Automate and run the test cases

**Inputs:** `08-test-cases.md`, repo frameworks

**Do:**
1. Implement missing unit/integration/e2e tests with the repo's frameworks (Playwright/axe only if present or agreed).
2. Run lint → type-check → unit → integration → e2e (env confirmed by the user).
3. Triage failures: product bug (fix via step 2) / test bug / environment / flaky.

**Output:** tests + results

**Checkpoint:** No unexplained failures.

**Next:** [04-check-acceptance-criteria-coverage.md](04-check-acceptance-criteria-coverage.md)
