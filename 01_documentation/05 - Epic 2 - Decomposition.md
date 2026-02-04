# Epic Decomposition: Core Workflow and Gate Definitions

## Story 1: Define Entry Phase Gates
**As a** System Architect  
**I want** to document the criteria for Session Setup and Decomposition gates  
**So that** the agent knows exactly how to start a session and prepare for work.

**Acceptance Criteria**:
- [ ] A file `docs/control/GATES_ENTRY.md` exists.
- [ ] Defines "Session Setup" gate: check installation, validate inputs, branching logic.
- [ ] Defines "Decomposition" gate: MDAP requirement, AC derivation rules.
- [ ] Explicitly states that these gates are warn-only but critical for "undefined behavior" warning.
- [ ] Defines the handoff trigger for moving to the Implementation phase.

## Story 2: Define Execution Phase Gates
**As a** System Architect  
**I want** to document the criteria for Implementation, Unit Test, and E2E Test gates  
**So that** the agent follows a TDD-like cycle during development.

**Acceptance Criteria**:
- [ ] A file `docs/control/GATES_EXECUTION.md` exists.
- [ ] Defines "Implementation" gate: coding standards, scope bounds.
- [ ] Defines "Unit Test Gate": derived from ACs, must pass before E2E.
- [ ] Defines "E2E Test Gate": validates user journey, must pass before Regression.
- [ ] States rule: "If tests fail, fix code, not tests."

## Story 3: Define Closure Phase Gates
**As a** System Architect  
**I want** to document the criteria for Regression, Review, Merge, and Validation  
**So that** we ensure quality control before and after merging.

**Acceptance Criteria**:
- [ ] A file `docs/control/GATES_CLOSURE.md` exists.
- [ ] Defines "Regression Gate": full suite run.
- [ ] Defines "Stakeholder Review Gate": demo requirement, approval states.
- [ ] Defines "Merge Gate": once per sprint, squashed or clean merge.
- [ ] Defines "Validation/Next Gate": post-merge checks and next epic selection.

## Story 4: Define General Gate Policies
**As a** System Architect  
**I want** to document the universal rules for all gates  
**So that** the agent behaves consistently across the entire workflow.

**Acceptance Criteria**:
- [ ] A file `docs/control/GATE_POLICIES.md` exists.
- [ ] Clearly states the "Warn-Only" policy for all gates.
- [ ] Defines the standard "Pass/Fail" format for gate outputs.
- [ ] Defines how to handle stakeholder overrides (ignoring warnings).
- [ ] Includes a diagram or text-based flow of the entire gate sequence.
