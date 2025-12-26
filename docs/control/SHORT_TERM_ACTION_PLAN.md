# Workflow Control Plan — Dax Behavior Finalization

**MODE: Behavior Definition & Finalization — This document defines the behavior of the Dax agent itself, not product development work.**

---

## Status — Completed

- [x] Stable sprint loop defined (MDAP → ACs → develop → verify → regress → review)
- [x] Intra-sprint AC verification via natural language checks
- [x] Regression phase defined
- [x] Rollback behavior defined
- [x] End-to-end workflow visualized (see WORKFLOW_FLOW.md)

---

## What Remains to Finalize — Behavior Gaps

- [ ] Stakeholder-facing sprint output definition  
	(non-technical, impact-focused summary of what changed and why it matters)

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

---

## Control Principles — Final Runtime Behavior

- Autonomous progression is allowed once all quality gates pass
- Automatic merge is permitted after successful verification and regression
- Rollback is preferred over hotfixes
- Stakeholder clarity outweighs technical completeness
- Dax behavior changes are rare, deliberate, and stability-driven

---

## Purpose

- This document exists to finish defining Dax’s behavior
- Once all items above are completed, this plan becomes static