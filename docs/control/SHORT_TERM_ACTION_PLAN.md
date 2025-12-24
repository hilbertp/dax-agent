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
- [ ] Re-evaluate GitHub Copilot once sandbox access is stable
- [ ] Define post-merge regression test build phase
- [ ] Define rollback procedure

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