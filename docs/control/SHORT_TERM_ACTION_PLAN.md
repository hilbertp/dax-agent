# Immediate Workflow Control Plan

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
- [x] ii-agent sandbox usage paused due to credential instability
- [x] Core workflow preserved independent of tooling

## Next
- [ ] Finalize merge trigger (GitHub UI only)
- [ ] Confirm regression test ownership and location
- [ ] Freeze workflow as v1 control baseline
- [ ] Re-evaluate ii-agent once sandbox access is stable

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

## Top 5 Ambiguities
1. Merge authority is unclear about whether the agent may merge to `main` automatically.
2. "Bootstrap success" is underspecified (what exactly must be validated for success?).
3. Regression skip/waiver policy is vague when no tests exist.
4. Test detection heuristics (where to look and what to run) are underspecified.
5. Evidence storage and provenance (where artifacts live and how to prove them) are underspecified.

## Proposed Doc Changes (one sentence each)
1. Explicitly state that agents may not merge to `main` and must instead open a pull request for human merge via the GitHub UI.
2. Define a canonical Bootstrap success checklist in the docs listing required validations (MANIFEST parse, authority files present, not-on-main, clean working tree) and the artifact to be produced on success.
3. Require a documented regression waiver or explicit stakeholder acceptance recorded before skipping the Regression Gate when no tests are present.
4. Standardize test discovery order and canonical keys (e.g., `manifest.tests`, package.json `test`/`test:ci`, Makefile `test`, tox/pytest) in the manifest and docs.
5. Define an evidence policy that mandates where artifacts are stored and what contents they must include (commands run, exit status, excerpts) for every gate.

## Recommended Policies (rules)
- Merge policy: Agent opens PR, human merges in GitHub UI.
- Evidence policy: Evidence lives in PR description.
