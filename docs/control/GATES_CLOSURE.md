# Closure Phase Gates

This document defines the criteria and behavior for the final gates of the Dax workflow: **Regression**, **Stakeholder Review**, **Merge**, and **Validation**.

## General Policy
All gates in Dax are **Warn-Only**, allowing for manual overrides when necessary, but adherence is critical for maintaining repository stability.

---

## Gate 6: Regression Gate

**Purpose**: Ensure that the new changes have not broken any existing functionality in the rest of the application.

### Criteria
1.  **Full Suite**: Run ALL existing unit and E2E tests in the repository, not just the new ones.
2.  **Clean State**: Tests should be run in a clean environment if possible.

### Pass/Fail
- **Pass**: 100% of the test suite passes.
- **Fail**: Any regression found.
    - *Action*: Fix the code to resolve the regression. Do not delete old tests unless the feature was intentionally deprecated (requires Stakeholder approval).

---

## Gate 7: Stakeholder Review Gate

**Purpose**: Get human approval before modifying the main codebase.

### Criteria
1.  **Demo**: The agent must be able to demonstrate the feature (via logs, screenshots, or live demo if applicable).
2.  **Review**: Stakeholder reviews the `implementation_plan.md`, code changes, and test results.

### Pass/Fail
- **Pass**: Stakeholder explicitly approves (e.g., "LGTM", "Proceed").
- **Fail**: Stakeholder requests changes.
    - *Action*: Return to **Implementation** or **Planning** phase as directed.

---

## Gate 8: Merge Gate

**Purpose**: Integrate the finished work into the main branch.

### Criteria
1.  **Frequency**: Merging happens once per completed Story or Epic (context dependent), not for every small commit.
2.  **Method**:
    - Prefer **Squash and Merge** to keep the main history clean.
    - Or **Clean Merge** if history preservation is important.
3.  **Conflicts**: All merge conflicts must be resolved before this gate passes.

### Pass/Fail
- **Pass**: Code is successfully merged into `main` (or target branch).
- **Fail**: Merge conflict or permission error.

---

## Gate 9: Validation & Next Gate

**Purpose**: Confirm the merge was successful and prepare for the next cycle.

### Criteria
1.  **Post-Merge Check**: Quick sanity check (e.g., `git status`, verify latest commit).
2.  **Next Epic**: Select the next Epic or Story from the backlog.

### Pass/Fail
- **Pass**: Repository is clean, on `main`, and ready for new work.
- **Fail**: Repository is in a detached head state or dirty state.

---
