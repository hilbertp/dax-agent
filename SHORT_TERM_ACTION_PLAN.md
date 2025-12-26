---
HUMAN OVERVIEW ONLY.

This file is NOT an instruction source for the agent.
The agent MUST NOT infer tasks from this document.
The agent acts ONLY on explicit, direct instructions.
Anything not explicitly commanded is OUT OF BOUNDS.
---

# Workflow Control Plan — Dax Behavior Finalization

**MODE: Behavior Definition & Finalization — This document defines the behavior of the Dax agent itself, not product development work.**

---

## Status — Completed

- [x] Stable sprint loop defined (MDAP → ACs → develop → verify → regress → review)
- [x] Intra-sprint AC verification via natural language checks
- [x] Regression phase defined
- [x] Rollback behavior defined
- [x] End-to-end workflow visualized (see WORKFLOW_FLOW.md)
- [x] Short-term action plan moved to repository root and referenced in MANIFEST
- [x] Authoritative repository structure defined and referenced in MANIFEST

---

## What Remains to Finalize — Behavior Gaps

- [ ] Stakeholder-facing sprint output definition  
  Non-technical, impact-focused summary of what changed and why it matters

- [ ] Stakeholder approval interface definition  
  Clear decision paths:
  - A) Approve
  - B) Amend (with comments)
  - C) Reject (with comments)

- [ ] Stakeholder-friendly change log per sprint  
  Plain-language explanation of deltas vs previous sprint

- [ ] Visual-first sprint demo artifact rules  
  Preference order:
  - Live or clickable demo
  - Screenshots or images
  - Written description only if visual demo is impractical

- [ ] Sprint branching model definition  
  - One branch per sprint
  - Naming: sprint/1, sprint/2, … sprint/n
  - Sprint number increments only on stakeholder A) Approve

- [ ] Define fallback behavior rules  
  When Dax pauses, retries, simplifies, or escalates to rollback

- [ ] Define Repository Quality SLOs (for Dax in action)  
  - Repository health is evaluated every sprint
  - Refactoring is triggered only when SLO thresholds are violated
  - Purpose: prevent structural drift without slowing delivery
  - Refactor is corrective, bounded, and goal-driven — never perfectionist

- [ ] Define kernel consumption contract  
  Product repositories consume Dax as a pinned kernel (versioned behavior via MANIFEST), not by copying or modifying behavior files directly

---

## Control Principles — Final Runtime Behavior

- Autonomous progression is allowed once all quality gates pass
- Automatic merge is permitted after successful verification and regression
- Rollback is preferred over hotfixes
- Stakeholder clarity outweighs technical completeness
- Dax behavior changes are rare, deliberate, and stability-driven

---

## Purpose

- This document exists solely to finish defining Dax’s behavior
- Once all items above are completed, this plan becomes static