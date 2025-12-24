# Rollback Policy

## Goal
Restore production stability after a catastrophic bug is discovered, even when all quality gates (regression, stakeholder review, sprint closure) passed before the merge.

## Principles
- **Human-only merge to main:** Agent never merges to main; all rollbacks follow the standard PR workflow with human approval and merge via GitHub UI.
- **No force-push to main:** Main branch history must never be rewritten.
- **Audit trail required:** All rollbacks are executed via pull request, not direct pushes.
- **Prefer deploy-level rollback:** If the deployment system supports instant rollback to a previous release, use that first. Git-level rollback is the fallback when deploy rollback is unavailable.

## Rollback Target Selection (deterministic order)
When a rollback is required, identify the target using the first available option:

1. **Last known good production release tag** (recommended: tag every production release with semantic version or date tag).
2. **Last known good deployed SHA** recorded by CI/deploy logs or monitoring.
3. **Revert the last release PR merge commit** (single merge revert preferred; simplifies audit and redo if needed).

## Technical Rollback Patterns

### Pattern 1: Revert a merge commit (recommended)
Use this when rolling back a single problematic merge to `main`:

```bash
# On a new rollback branch
git checkout main
git pull
git checkout -b rollback/YYYY-MM-DD-short-reason
git revert -m 1 <merge_sha>
git push origin rollback/YYYY-MM-DD-short-reason
# Open PR, get human approval, human merges via GitHub UI
```

- `-m 1` preserves the first parent (main branch history).
- This creates a new commit that undoes the merge; history is preserved.

### Pattern 2: Rollback to a previous tag or commit via revert range
Use this when rolling back multiple commits or a range:

```bash
# On a new rollback branch
git checkout main
git pull
git checkout -b rollback/YYYY-MM-DD-restore-tag-vX.Y.Z
git revert --no-commit <last_good_sha>..HEAD
git commit -m "Rollback to <tag_or_sha>: <short_reason>"
git push origin rollback/YYYY-MM-DD-restore-tag-vX.Y.Z
# Open PR, get human approval, human merges via GitHub UI
```

- This reverts a range of commits safely without rewriting history.
- Still follows PR workflow.

## Verification Steps

### Before opening the rollback PR:
1. Run smoke test or health check on the rollback branch (if a test command exists).
2. Verify the rollback branch builds/runs successfully.
3. Confirm the expected behavior is restored (e.g., run a minimal reproducer if available).

### After the rollback PR is merged:
1. Monitor stability signals: logs, error rates, uptime metrics.
2. Confirm the issue is resolved or mitigated.
3. Record the outcome in the incident note.

## Evidence Requirements
Every rollback must include:

- **PR link:** URL of the rollback pull request.
- **Rollback target:** The chosen tag/SHA/merge commit and why it was selected.
- **Commands executed:** Exact git commands run, plus exit status (if applicable).
- **Incident note:** Short summary recorded in `docs/control/incidents/INCIDENT-YYYY-MM-DD.md` (filename suggestion; agent must not auto-create it without approval).

## Example Incident Note Structure (suggestion only)
```markdown
# Incident: YYYY-MM-DD - Short Description

## Timeline
- HH:MM: Issue detected
- HH:MM: Rollback PR opened
- HH:MM: Rollback merged
- HH:MM: Stability confirmed

## Root Cause
Brief explanation of what went wrong.

## Rollback Target
Tag/SHA and reason chosen.

## Commands Executed
<code block>

## Outcome
Issue resolved / mitigated / escalated.

## Follow-up
Any required fixes or process improvements.
```

## Agent Behavior on Rollback Request
1. Determine the rollback target using the selection order above.
2. Create a rollback branch following the naming convention: `rollback/YYYY-MM-DD-short-reason`.
3. Execute the appropriate revert pattern (Pattern 1 or Pattern 2).
4. Run verification steps and attach output.
5. Open a pull request with clear title, description, and evidence.
6. Wait for human approval and merge via GitHub UI.
7. Do NOT merge automatically. Do NOT force-push to main.
