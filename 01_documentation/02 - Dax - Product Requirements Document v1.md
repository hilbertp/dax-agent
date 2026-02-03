# Product Requirements Document — Dax v0

## 1. Problem Statement

AI implementation agents (LLMs used for coding) suffer from predictable failure modes:
- **Hallucination**: They invent requirements or misinterpret intent
- **Drift**: They lose track of the original goal over long sessions
- **Skipped discipline**: They bypass verification, testing and documentation
- **Black box execution**: Stakeholders cannot see what was decided or why, i.e. based on what
- **Session amnesia**: last work tracker lost, what is currently being done, what was supposedto happen next.

Non-technical stakeholders want to ship software using AI agents but have no mechanism to keep agents accountable without becoming technical themselves.

Micromanagement defeats the purpose. Blind trust produces broken software.

## 2. Goal

Build a minimal installable package that:
- Injects behavioral structure into any AI implementation agent
- Guides agents through a disciplined workflow with visible checkpoints
- Keeps stakeholders informed and in control without requiring technical knowledge
- Reduces hallucination through decomposition and frequent feedback loops
- Maintains continuous progress documentation for session continuity

Dax does not write code. Dax structures and organizes how development progresses. It allows agents to work inside of human organizations since its inspired by the scrum process.


## 3. Non-Goals

- Do not build a coding agent
- Do not enforce compliance (warn-only)
- Do not prescribe tech stack choices for target projects
- Do not automate stakeholder decisions
- Do not fully replicate MAKER (inspiration only for v0)
- Do not rely on AI self-assessed confidence levels


## 4. Definitions

### Dax
A behavioral workflow framework that operates as a subroutine within a third-party AI implementation agent. Dax advises; it cannot block.

### Implementation Agent
Any AI coding tool that can read files, write files, and execute shell commands.

### Stakeholder
The human who owns business decisions. Provides PRD and Epic List. Reviews and then approves or rejects work. Does not need to understand code. 

### Sprint
One unit of work corresponding to one epic. Sprint length is variable and will be refined through testing.

### MDAP (Massively Decomposed Agentic Processes)
The principle that work must be broken into the smallest possible shippable units before implementation begins.

### MAKER
A multi-agent framework described in [arxiv.org/html/2511.09030v1](https://arxiv.org/html/2511.09030v1) implementing Maximal Agentic decomposition, first-to-ahead-by-K Error correction, and Red-flagging. Dax is inspired by MAKER's decomposition philosophy but does not fully replicate its error correction or red-flagging mechanisms in v0.

### Acceptance Criteria (ACs)
Testable conditions derived from the PRD and Epic List that define when a user story is complete. ACs are the source of truth for unit tests.


## 5. Authority Chain

Dax enforces a strict authority chain for quality control:

```
PRD + Epics → ACs → Unit Tests → Code
```

| Artifact | Derived From | Responsible and Maintend By |
|----------|--------------|-------------|
| PRD | Stakeholder | Stakeholder |
| Epic List | Stakeholder | Stakeholder |
| Acceptance Criteria | PRD + Epics (by agent) | AI agent|
| Unit Tests | ACs | AI agent |
| Code | Must satisfy tests | Agent fixes code to pass tests, never modifies tests to pass code |

**Key rule**: If tests fail, fix the code. If ACs are flawed, surface to stakeholder—do not silently adjust tests. When AC changes seems appropriate after development, it is very likely that the requirements weren't clear enough. This should trigger confering with the stakeholder.

---

## 6. Target User

**Primary**: Product owners and stakeholders at the business-tech interface.

**Secondary**: Technical users who want workflow discipline.

**Assumptions for v0**:
- Single stakeholder per project
- Stakeholder provides PRD and Epic List
- Stakeholder reviews and approves demoed artifact after each sprint

**Communication style**: Concise, feature-centric, non-granular and non-technical. Dax only expands into detail when clarifying open questions or asked for specifically.

**Compatible Implementation Agents**:
Dax is designed to work with any file-editing agent, including multi-agent systems:
- Cursor, Windsurf, Cline
- GitHub Copilot, Antigravity
- Kimi K2, II-Agent, Manus
- Lovable, OpenClaw
- Others that can read files and execute commands

---

## 7. Required Inputs

The stakeholder must provide two artifacts before meaningful work begins:

**PRD (Product Requirements Document)**
Describes the problem, constraints and success criteria. (example PRD is provided by Dax)

**Epic List**
A ranked list of work units that define scope and priority. (example Epics List is presented by Dax)

Both are stored in the project's existing documentation location. Dax does not prescribe folder structure.


## 8. Installation

Dax is installed via a single command. The exact mechanism (curl, npm, pnpm, or other) is determined during Dax development and then standardized for all users.

**Installation flow**:

1. Stakeholder find and learns about Dax, sees the setup instructions in the Readme
2. Stakeholder instructs agent to install Dax
3. Agents fetches whatever is need to set up Dax as a package
4. Dax is setup in the project repo(or agent sandbox if applicable)
5. Opening message confirms Dax is active and specifies what is expected by the user


## 9. Session Continuity

Dax must support both fresh projects and existing ones.

**Fresh project**: Full setup—validate PRD/Epics, initialize progress tracking, begin first sprint.

**Existing project**: Dax checks its own existence and health, repairs or installs itself if needed, reads progress documentation to determine current state—what's done, what's next—and resumes from that point. If PRD and Epics List arent available, asks for it.

**Progress documentation**:
Dax continuously maintains progress state in the production repo:
- Completed work (done)
- Current sprint status
- Next tasks (todo)
- Open blockers or warnings
- AC summaries for each sprint

This documentation is the source of truth for session continuity. If context cannot be confidently reconstructed, Dax will say so.


## 10. Acceptance Criteria Handling

ACs are derived by the agent from PRD and Epic List, not authored by the stakeholder.

**AC Documentation**: ACs are always saved to the repo documentation folder. This supports:

- Session continuity (next agent knows where work left off)
- Stakeholder context rebuilding after interruptions
- Audit trail for decisions

**AC Review Timing (v0)**:

| Option | Behavior | Status |
|--------|----------|--------|
| **A** | ACs saved to docs. Stakeholder reviews increment. ACs available if questions arise. | Default for v0 |
| **B** | Require AC approval before implementation begins. | Escalation if drift persists |
| **C** | Stakeholder toggles AC review gate on/off via setting. | Available option |

v0 starts with Option A. Stakeholder can enable Option C if they prefer pre-approval. Option B is documented as escalation path if testing reveals persistent drift problems.

---

## 11. Core Workflow

### Workflow Gates

| Gate | Purpose |
|------|---------|
| **Session Setup** | Bootstrap, see if Dax already installed, fix if not; validate PRD/Epics exist; detect fresh vs existing project; create or resume sprint branch |
| **Decomposition** | Decompose epic via MDAP → User Stories + ACs; save AC summary to repo docs |
| **Implementation** | Implement code; in-sprint commits allowed |
| **Unit Test Gate** | Create and run new unit tests (derived from ACs); if fail → fix code |
| **E2E Test Gate** | Create and run new E2E tests for user journey; if fail → fix code |
| **Regression Gate** | Run full test suite (all unit + E2E); if fail → fix code |
| **Stakeholder Review** | Present increment; AC Summary available if needed; approve, amend or reject |
| **Merge** | Merge sprint branch to main (exactly once) |
| **Validation** | Automated main branch actions; validate authority docs |
| **Next Sprint** | Move to next epic or work package inside same epic; start with decomposition and repeat loop |

### Gate Behavior
- All gates are warn-only
- If stakeholder ignores warnings, agent continues
- Dax will surface the same guidance again at the next gate


## 12. Package Contents

Based on current repository structure:

```
agent/
  bootstrap.sh              # Entrypoint
  check_start_gateway.sh
  ensure_execution_summary.sh

dax/runtime/
  RUNTIME_DEFINITION.json
  RUNTIME_LOCKFILE.json

docs/
  authority/                # Identity, workflow, decomposition rules
  control/                  # Gate policies, rollback, regression ownership
  examples/
  fallback/
  install/
  prompts/
    OPENING_MESSAGE.md      # Canonical opening message
  visual/

MANIFEST.json
install.sh
README.md
REPOSITORY_MAP.md
```

All files are human-readable Markdown or minimal JSON.


## 13. Constraints

- **Warn-only**: Dax cannot block execution. If ignored, work continues.
- **Agent-agnostic**: Must work with any file-editing implementation agent.
- **Human-readable**: All Dax files must be understandable without tooling.
- **Minimal dependencies**: Shell scripts and Markdown. No Python/Node/Go runtime required for core.
- **Adaptable location**: Dax integrates with existing project documentation structure.
- **Session-resilient**: Progress state persists in repo; work survives session breaks.
- **No AI self-assessment**: Do not rely on agent confidence levels for gating decisions.


## 14. Success Criteria (v0)

Dax v0 is successful when:

1. A user can install Dax to a production repo via a single command
2. The implementation agent's behavior visibly changes to follow the workflow
3. The agent decomposes epics into minimal user stories before coding
4. ACs are derived, documented and used as source of truth for tests
5. Tests verify code correctness; code is changed to pass tests (not vice versa)
6. Stakeholder receives short, clear, non-technical summaries at review gates using as much haptic and visual demo as possible
7. Work can be approved, amended or rejected without understanding code
8. Work can be resumed across sessions using progress documentation
9. The workflow can be repeated across multiple sprints without re-engineering


## 15. Open Questions

| Question | Resolution Path |
|----------|-----------------|
| Optimal sprint length | we learn during real usage |
| Exact stakeholder review cadence | Default to per-epic; refine based on feedback |
| Installation mechanism | Determined during Dax development; then standardized (likely npm/pnpm or curl) |
| Progress documentation format | Define during development |
| Sandbox vs repo installation behavior | Depends on agent capabilities |
| AC review timing | Start with Option A; stakeholder can enable Option C; escalate to Option B if drift persists |


## 16. Out of Scope (v0)

- Hard enforcement / blocking
- GUI or visual dashboards *(targeted for v1/v2)*
- Direct LLM API calls
- Backup or snapshot systems (rely on git)
- Communication style customization
- Full MAKER implementation (K error correction, red-flagging)
- AI confidence-based gating (unreliable with current technology)
