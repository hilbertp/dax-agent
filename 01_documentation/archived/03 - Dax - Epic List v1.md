# Epic List — Dax v0

## Epic 1: MDAP Decomposition and AC Derivation

**Goal**  
Decompose each epic into the smallest shippable user stories with testable acceptance criteria.

**Scope**

- Define MDAP (Massively Decomposed Agentic Processes) decomposition rules
- Dax takes the first unfinished epic from the Epic List
- Decompose one epic at a time, not the entire list
- Input: PRD + current Epic (single)
- Output: User stories broken into smallest possible shippable units
- Derive explicit, testable Acceptance Criteria (ACs) for each user story
- ACs are source of truth for unit tests
- Save AC summary to repo documentation folder
- AC review options (we go with Option A for now):
  - Option A (default): ACs available on request during stakeholder review
  - Option B (if we find too much drift): ACs are written and shown to stakeholder before starting implementation
  - Option C: Stakeholder can enable pre-approval gate (Option B)

**Authority Chain**
```
PRD + Epics → ACs → Unit Tests → Code
```

- ACs derived from PRD/Epics, not invented
- Unit tests derived from ACs, not invented
- Code must satisfy tests
- If tests fail → fix code, not tests
- If AC flaw discovered → surface to stakeholder

**Why this is Epic 1**  
MDAP decomposition is the core mechanism for reducing hallucination. This is what makes Dax different from "just coding." Everything else serves this.

---

## Epic 2: Core Workflow and Gate Definitions

**Goal**  
Define the complete development workflow as a sequence of mandatory, non-blocking gates.

**Scope**

- Define all workflow gates and their sequence:
  1. Session Setup
  2. Decomposition
  3. Implementation
  4. Unit Test Gate
  5. E2E Test Gate
  6. Regression Gate
  7. Stakeholder Review
  8. Merge
  9. Validation
  10. Next Sprint
- Define gate behavior rules:
  - All gates are warn-only
  - If stakeholder ignores warnings, agent continues
  - Dax surfaces same guidance again at next gate
- Define pass/fail criteria for each gate
- Define handoff between gates (what triggers next gate)
- Document workflow in human-readable format

**Why this is Epic 2**  
The workflow structure defines how Dax shapes agent behavior. Without clear gate definitions, there is no discipline to enforce.

---

## Epic 3: Bootstrap and Entry Point Handoff

**Goal**  
Establish a single entry point that activates Dax and hands off to the correct workflow gate.

**Scope**

- Bootstrap script as single entry point (`bootstrap.sh`)
- Display canonical opening message (confirms Dax is active)
- Detect project state:
  - Fresh project: no prior Dax activity
  - Existing project: prior Dax activity detected
- Validate required inputs:
  - PRD exists → continue
  - PRD missing → warn, do not block
  - Epic List exists → continue
  - Epic List missing → warn, do not block
- Hand off to appropriate gate based on project state:
  - Fresh project → Decomposition gate
  - Existing project → Resume from last known state
- Bootstrap is mandatory every session
- If bootstrap skipped, Dax has undefined behavior

**Why this is Epic 3**  
One entry point simplifies agent instructions. Clear handoff ensures the workflow activates correctly regardless of project state.

---

## Epic 4: Sprint Branch and Implementation Loop

**Goal**  
Establish the sprint structure and guide the agent through disciplined implementation.

**Scope**

- Create sprint branch at sprint start
- Branch naming convention (define during development)
- One sprint = one epic (default, refine through testing)
- Allow in-sprint commits during implementation
- Guide agent to implement against ACs only
- Scope enforcement:
  - Implementation must address current user story
  - Surface warnings if agent modifies files outside scope
  - Do not block (warn-only)
- Implementation continues until all user stories in epic complete

**Why this is Epic 4**  
The sprint branch isolates work until verified. This prevents half-finished or broken code from reaching main.

---

## Epic 5: Unit Test Gate

**Goal**  
Ensure new functionality is verified by unit tests derived from acceptance criteria.

**Scope**

- Create new unit tests based on ACs
- Each AC maps to one or more unit tests
- Run new unit tests after implementation
- Pass criteria: all new unit tests pass
- Fail behavior:
  - If tests fail → return to implementation
  - Agent must fix code, not modify tests
  - If AC flaw discovered → surface to stakeholder, pause for guidance
- Tests must be saved to repo (not ephemeral)
- Test location follows project conventions

**Why this is Epic 5**  
Unit tests verify individual components work as specified. This gate enforces the authority chain and prevents "cheating" by test modification.

---

## Epic 6: E2E Test Gate

**Goal**  
Ensure new functionality works within the user journey.

**Scope**

- Create new E2E tests for user journey affected by current sprint
- E2E tests validate integration across components
- Run new E2E tests after unit tests pass
- Pass criteria: all new E2E tests pass
- Fail behavior:
  - If tests fail → return to implementation
  - Agent must fix code, not modify tests
- E2E tests cover main user flows, not edge cases
- Tests must be saved to repo

**Why this is Epic 6**  
Unit tests verify parts; E2E tests verify the whole. A feature can pass unit tests but break the user journey.

---

## Epic 7: Regression Gate

**Goal**  
Ensure new work does not break existing functionality.

**Scope**

- Run full test suite:
  - All existing unit tests
  - All existing E2E tests
  - All new unit tests
  - All new E2E tests
- Pass criteria: entire test suite passes
- Fail behavior:
  - If any test fails → return to implementation
  - Identify which test failed and why
  - Agent fixes code to restore passing state
- Regression must pass before stakeholder review
- No stakeholder time wasted on broken builds

**Why this is Epic 7**  
Regression safety is a core problem. Agents happily break existing features while adding new ones. This gate prevents that.

---

## Epic 8: Stakeholder Review Gate

**Goal**  
Present verified increment to stakeholder for approval, amendment, or rejection.

**Scope**

- Present increment with concise, non-technical summary
- Summary focuses on what changed, not how
- Demonstrate working functionality (haptic/visual demo preferred)
- AC summary available if stakeholder wants insight into decisions
- Three possible outcomes:
  - **Approve** → proceed to merge
  - **Amend** → return to implementation with specific feedback
  - **Reject** → stop, no merge, sprint terminated
- Review cadence: after each epic (default, refine through testing)
- Review must not require stakeholder to understand code

**Why this is Epic 8**  
This is the human control point. No code reaches main without explicit stakeholder approval. Stakeholder decides, not agent.

---

## Epic 9: Merge, Validation, and Next Sprint

**Goal**  
Complete the sprint by merging to main, validating docs, and proposing next work.

**Scope**

- Merge sprint branch to main
- Merge happens exactly once per sprint
- Run automated main branch actions (if configured)
- Validate authority docs are consistent:
  - PRD still accurate
  - Epic List reflects current state
  - AC summaries saved
- Propose next epic from Epic List
- Present next epic summary to stakeholder
- Await stakeholder approval before starting next sprint
- If Epic List exhausted → project complete

**Why this is Epic 9**  
This closes the loop. Clean merge, validated state, explicit approval for next work. Repeatable across sprints.

---

## Epic 10: Package Structure and Installation

**Goal**  
Enable single-command installation of Dax into any project repository.

**Scope**

- Define final package structure:
  - Shell scripts (bootstrap, gates)
  - Markdown (docs, prompts, policies)
  - JSON (runtime config, manifest)
- Implement installation mechanism:
  - Decide during development: npm/pnpm or curl
  - Single command execution
  - Standardize for all users once decided
- Installer behavior:
  - Fetch Dax package
  - Add to project repo (or agent sandbox if applicable)
  - Trigger bootstrap
  - Display opening message
- Installation must be idempotent (safe to run multiple times)
- Support any file-editing implementation agent

**Why this is Epic 10**  
Installation is infrastructure. Important for delivery, but the workflow and gates are the product. This enables access to the product.

---

## Epic 11: Progress Documentation System

**Goal**  
Maintain continuous progress state in the production repo so work survives session breaks.

**Scope**

- Define progress documentation format (Markdown)
- Track and persist:
  - Completed work (done)
  - Current sprint status
  - Current gate position
  - Next tasks (todo)
  - Open blockers or warnings
  - AC summaries per sprint
- Documentation location: project's existing docs folder
- Documentation must be:
  - Human-readable
  - Parseable by next agent/session
- Bootstrap reads progress docs to determine resume point
- Progress updated after each gate transition

**Why this is Epic 11**  
Session continuity is valuable but not core. Dax works within a single session without this. This epic enables multi-session workflows.

---

## Summary

| # | Epic | Focus |
|---|------|-------|
| 1 | MDAP Decomposition and AC Derivation | Core philosophy |
| 2 | Core Workflow and Gate Definitions | Workflow structure |
| 3 | Bootstrap and Entry Point Handoff | Single entry, correct handoff |
| 4 | Sprint Branch and Implementation Loop | Isolated implementation |
| 5 | Unit Test Gate | Component verification |
| 6 | E2E Test Gate | Integration verification |
| 7 | Regression Gate | Protect existing functionality |
| 8 | Stakeholder Review Gate | Human control point |
| 9 | Merge, Validation, and Next Sprint | Close loop, continue |
| 10 | Package Structure and Installation | Delivery infrastructure |
| 11 | Progress Documentation System | Multi-session continuity |
