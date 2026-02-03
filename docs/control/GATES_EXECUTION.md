# Execution Phase Gates

This document defines the criteria and behavior for the development gates of the Dax workflow: **Implementation**, **Unit Testing**, and **E2E Testing**.

## General Policy
All gates in Dax are **Warn-Only**. However, ignoring test failures in this phase defeats the purpose of the agent.

---

## Gate 3: Implementation

**Purpose**: Execute the coding work defined in the decomposed User Story.

### Criteria
1.  **Scope Bounds**: Code changes must be necessary for the *current* User Story. Out-of-scope changes should be rejected or flagged.
2.  **Coding Standards**: Follow project languages, frameworks, and patterns.
3.  **In-Sprint Commits**: Frequent commits are encouraged during implementation (e.g., `wip: ...`), but the final merge happens later.

### Pass/Fail
- **Pass**: Code implemented.
- **Fail**: Code does not compile or agent is hallucinating features not in the ACs.

---

## Gate 4: Unit Test Gate

**Purpose**: Verify that the specific component logic works as requested in the Acceptance Criteria.

### Criteria
1.  **Source of Truth**: Tests must be derived directly from the ACs.
2.  **Pre-requisite**: Unit tests must pass before attempting E2E tests.
3.  **Persistence**: Tests must be saved to the repo (not just run in memory).

### Pass/Fail
- **Pass**: All new unit tests pass.
- **Fail**: Any unit test fails.
    - *Action*: **Fix Code, Not Tests.**
    - *Exception*: If the AC is physically impossible or logically flawed, stop and ask the stakeholder. Never silently change the test to make it pass.

---

## Gate 5: E2E Test Gate

**Purpose**: Verify that the new feature works within the broader user journey and doesn't break basic flows.

### Criteria
1.  **User Journey Coverage**: Tests must simulate the actual user interaction described in the Story.
2.  **Pass Before Regression**: This specific feature must work before running the full regression suite.

### Pass/Fail
- **Pass**: All new E2E tests pass.
- **Fail**: Tests fail.
    - *Action*: **Fix Code.**

---

## Handoff to Closure

Completion of the **E2E Test Gate** triggers the **Closure Phase** (Regression).
- **Trigger**: All new Unit and E2E tests passing green.
- **Next Step**: Enter **Regression Gate**.
