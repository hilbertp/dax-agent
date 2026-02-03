# Entry Phase Gates

This document defines the criteria and behavior for the initial gates of the Dax workflow: **Session Setup** and **Decomposition**.

## General Policy
All gates in Dax are **Warn-Only**. The agent cannot physically block the user or itself from proceeding, but skipping these gates results in **undefined behavior**.

---

## Gate 1: Session Setup

**Purpose**: Ensure the environment is correctly configured and the agent has the necessary context to begin work.

### Criteria
1.  **Installation Check**: Verify Dax is installed (`agent/bootstrap.sh` exists).
2.  **Input Validation**:
    - `PRD.md` exists and is readable.
    - `EPIC_LIST.md` exists and is readable.
3.  **Project State Detection**:
    - **Fresh**: No existing `dax/` artifacts. -> Start at Epic 1.
    - **Existing**: `dax/` artifacts exist. -> Read progress and resume.
4.  **Branching**:
    - Ensure the agent is on a dedicated feature branch for the sprint (e.g., `feature/epic-N`).

### Pass/Fail
- **Pass**: All checks valid. Proceed to Decomposition.
- **Fail**: Missing inputs or bad state.
    - *Action*: Warn user. "Cannot guarantee results without PRD/Epics."
    - *Handoff*: If user persists, move to Decomposition anyway (at own risk).

---

## Gate 2: Decomposition (MDAP)

**Purpose**: Break down the high-level Epic into small, verifiable units to prevent hallucination and drift.

### Criteria
1.  **MDAP Execution**: The active Epic must be decomposed using the MDAP rules (Smallest Shippable Units).
2.  **AC Derivation**: Every generated User Story must have 3-5 Testable Acceptance Criteria.
3.  **Persistence**: The decomposition artifact must be saved to `dax/epics/epic_<N>_decomposition.md`.
4.  **Authority verification**: Verify that ACs are grounded in PRD.

### Pass/Fail
- **Pass**: Decomposition artifact exists and contains ACs.
- **Fail**: Artifact missing or ACs vague/missing.
    - *Action*: Rerun decomposition prompt.
    - *Handoff*: Once artifact is saved, **Gate Complete**.

---

## Handoff to Implementation

Completion of the **Decomposition Gate** triggers the **Implementation Phase**.
- **Trigger**: Existence of `dax/epics/epic_<N>_decomposition.md`.
- **Next Step**: The agent reads the first User Story from the decomposition and enters the **Implementation Gate**.
