# Epic 1: MDAP Decomposition and AC Derivation — Decomposition

**Epic Goal**: Build the system capability to decompose future epics into user stories and acceptance criteria.

**Strategy**: We are applying the MDAP process to the task of building the MDAP system itself. This decomposition breaks down the implementation of the "Decomposition Module" in Dax.

---

## User Stories

### Story 1: Define MDAP Prompt Template
**As a** System  
**I want** a standardized prompt template for decomposition  
**So that** the agent reliably adheres to MDAP rules (small units, ACs first).

**Acceptance Criteria**:
- [ ] A file `dax/prompts/DECOMPOSITION_PROMPT.md` exists.
- [ ] The prompt explicitly requires "smallest possible shippable units".
- [ ] The prompt explicitly requires Testable "Acceptance Criteria" for every story.
- [ ] The prompt forbids "technical implementation details" in the user stories (focus on behavioral/functional).
- [ ] The prompt instructs the agent to analyze the specific Epic against the PRD constraints.
- [ ] The prompt requires the agent to verify each AC traces to PRD or Epic scope.
- [ ] The prompt requires the agent to flag ungrounded ACs to the stakeholder before proceeding.

### Story 2: Create Decomposition CLI Skeleton
**As a** Developer  
**I want** a script `agent/decompose.sh`  
**So that** I can trigger the decomposition process for a specific epic.

**Acceptance Criteria**:
- [ ] `agent/decompose.sh` exists and is executable.
- [ ] Accepts an Epic ID or Keyword as an argument (e.g., `bash agent/decompose.sh 2`).
- [ ] Validates that `PRD.md` (or configured path) exists; warns if missing.
- [ ] Validates that `EPIC_LIST.md` exists; warns if missing.
- [ ] Outputs a simple confirmation message with the Epic Name to prove it found the files.

### Story 3: Implement Context Gathering Logic
**As a** Decomposition Agent  
**I want** to extract the relevant context from the documentation  
**So that** I don't distract the LLM with the entire codebase.

**Acceptance Criteria**:
- [ ] Script locates the PRD and reads its content.
- [ ] Script locates the Epic List and parses it to find the *targeted* Epic.
- [ ] Script extracts ONLY the text of the targeted Epic (Goal, Scope, Why).
- [ ] Verification: Script prints the extracted "Context Payload" to debug output.

### Story 4: Connect to Generation Engine
**As a** System  
**I want** to pass the context and prompt to the implementation agent  
**So that** I receive a structured decomposition.

**Acceptance Criteria**:
- [ ] Script constructs the full prompt: `System Prompt` + `PRD Context` + `Epic Context`.
- [ ] Script executes a call to the implementation agent (using the environment's standard way of invoking LLM/Agent, e.g., passing a task to a sub-agent or API).
- [ ] *Implementation Note*: For v0, this might just be printing the prompt to stdout for the user to copy-paste, OR using a CLI tool if available. *Decision*: Assume `llm` CLI or similar is available, or use a placeholder `generate_response` function.
- [ ] Output is captured into a variable.

### Story 5: Persist Decomposition Artifacts
**As a** Stakeholder  
**I want** the decomposed stories and ACs saved to a file  
**So that** I can review them and they survive the session.

**Acceptance Criteria**:
- [ ] Output is saved to `01_documentation/epics/epic_<N>_decomposition.md`.
- [ ] Directory `01_documentation/epics/` is created if it doesn't exist.
- [ ] File content is strictly the Markdown output from the Agent.
- [ ] Script prints the location of the new file.

### Story 6: Verification (Decompose Epic 2)
**As a** User  
**I want** to verify the tool works by decomposing Epic 2  
**So that** I can trust the system for future sprints.

**Acceptance Criteria**:
- [ ] Run `agent/decompose.sh 2`.
- [ ] A new file `01_documentation/epics/epic_2_decomposition.md` is created.
- [ ] Review the file: It must contain logical user stories and ACs for "Core Workflow and Gate Definitions".
