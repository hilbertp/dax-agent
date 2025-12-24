# Workflow Control Plan

**CONFIGURATION MODE: defining behavior only. No product development in this phase.**

## Done
- [x] Stable sprint-based workflow defined
- [x] Regression Gate implemented
- [x] Stakeholder Review Gate implemented
- [x] Sprint Closure Gate implemented
- [x] Agent never merges to main
- [x] Authority documents enforced via bootstrap
- [x] Automated authority snapshots on main
- [x] Folder structure clarified (authority vs execution)
- [x] Sandbox state successfully recovered via bundle

## Current Mode
- [x] Development temporarily switched to GitHub Copilot
- [x] GitHub Copilot sandbox usage paused due to credential instability
- [x] Core workflow preserved independent of tooling

## Next
- [x] Finalize merge trigger (GitHub UI only)
- [x] Confirm regression test ownership and location
- [x] Freeze workflow as v1 control baseline
- [x] Define post-merge regression test build phase (see POST_MERGE_REGRESSION_POLICY.md)
- [x] Define rollback procedure (see ROLLBACK_POLICY.md)
- [ ] Re-evaluate GitHub Copilot once sandbox access is stable

## Current Risks
- [ ] Sandbox authentication volatility
- [ ] Tooling drift from defined workflow
- [ ] Accidental merge bypass without UI controls

## Control Principles
- Agent or Copilot may commit only to sprint branches
- Only humans merge to main via GitHub UI
- Bootstrap is mandatory and authoritative
- Authority documents override prompts and tools
- Tooling is replaceable; workflow is not

## Post-merge Regression Build Phase (high level)
After a human merges a sprint PR to main, before starting the next sprint:
- Add or update regression tests to cover the approved behavior
- Attach test run output and exit status in the PR description or docs/evidence
- Test framework selection rules:
  - If the repo already has a test runner or existing tests, KEEP IT (no migrations)
  - If no runner exists, choose the most stable mainstream option in that ecosystem (boring > trendy)
  - Prioritize CI reliability: deterministic, fast, clear output, easy install
  - Minimize tool count: one runner for unit/integration; add E2E only if UI flows exist
  - Freeze the chosen framework by documenting it, and do not change without explicit stakeholder approval