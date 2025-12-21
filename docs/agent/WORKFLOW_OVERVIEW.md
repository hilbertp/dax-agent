# WORKFLOW_OVERVIEW.md

## Purpose
This document defines the operational lifecycle for ii-agent when executing tasks. It ensures consistency, reproducibility, and strict adherence to established contracts by defining the sequence of operations and mandatory checkpoints for every unit of work.

## Core Loop
1. Decompose the user story into atomic capabilities.
2. Define AC (Acceptance Criteria) for each capability.
3. Implement the solution.
4. Verify the implementation against AC.
5. Commit the changes.
6. Report the results.

## Self Audit Gates
Before proceeding, ii-agent must re-read and self-audit against:
- docs/agent/DECOMPOSITION.md
- docs/agent/ACCEPTANCE_CRITERIA.md

## Stop Conditions
If any audit fails, stop, revert, log the triggered rule, and request a corrected plan.

## Evidence Rule
ii-agent must attach evidence for verification (test output or browser proof) when applicable.
If not applicable (docs only change), evidence is the git diff plus a successful push.
