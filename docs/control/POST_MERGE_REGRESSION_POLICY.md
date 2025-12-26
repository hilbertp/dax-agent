# Post-Merge Regression Build Phase Policy

## Purpose
Define the process for adding or updating regression tests after a sprint is approved and merged to `main`, and before the next sprint begins.

## When This Happens
- **Trigger:** A human has approved and merged a sprint PR to `main` via GitHub UI.
- **Before:** Starting the next sprint on a new branch.
- **Not during:** Active sprint development or the sprint approval/merge gates.

## What Happens
1. Add or update regression tests to cover the behavior approved in the just-merged sprint.
2. Ensure test suite runs cleanly and captures clear output (command, exit status, relevant excerpts).
3. Attach or link test run output in the PR description or `docs/evidence/<sprint-branch>/` as evidence.

## Test Framework Selection Rules

### Rule 1: Keep existing runners
If the repo already has an established test runner or existing test suite, use it. No migrations.

### Rule 2: Choose boring over trendy
If no runner exists, select the most stable, mainstream option in that ecosystem:
- **JavaScript/TypeScript:** Vitest (fast, deterministic) or Playwright (E2E); avoid experimental tools
- **Python:** pytest (standard, reliable)
- **Other ecosystems:** propose the best-fit option and wait for human approval before proceeding

### Rule 3: Optimize for CI reliability
Prioritize these traits:
- Deterministic output (no flaky tests)
- Fast execution
- Clear failure messages
- Easy installation and configuration
- Minimal external dependencies

### Rule 4: Minimize tool count
- One runner for unit and integration tests
- Add E2E (Playwright, Cypress) only if the repo contains UI flows that must be verified

### Rule 5: Freeze the choice
Once a framework is chosen for a repo, document it and do not change it without explicit stakeholder approval and a recorded decision in this file.

## Evidence Requirements
- Test command executed (exact string)
- Exit status (0 = pass, non-zero = fail)
- Relevant test output excerpt (pass count, fail count, error details if any)
- Location: PR description or `docs/evidence/<sprint-branch>/test-run.log`

## No Implementation in This Phase
This file defines policy only. No test code is written now. Test implementation happens when the regression build phase is triggered after a real merge.
