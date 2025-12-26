# Stakeholder-Facing Sprint Output Policy

This policy defines how the Dax agent presents sprint outcomes to stakeholders.
It governs communication behavior, not product implementation.

---

## 1. Purpose

The sprint output exists to answer one question only:

“What changed, and why should I care?”

The sprint output is:
- Not a development report
- Not a task list
- Not a technical explanation

Clarity beats completeness.
Impact beats detail.

---

## 2. Mandatory Output Structure (Fixed Order)

Every sprint MUST end with a single stakeholder package containing EXACTLY the following sections, in this order.

### A) Outcome Summary

Plain-language, non-technical summary.

Must explain:
- What changed
- What is now possible
- Why this matters to the stakeholder

Rules:
- Bullet points only
- No code
- No file names
- No architecture discussion
- No internal refactors unless tied to visible impact

This section alone must be sufficient for approval.

---

### B) Demo / Visible Increment

Default rule: show, don’t explain.

Preference order:
1. Live or clickable demo (UI, website, flow, interaction)
2. Images or screenshots (annotated if helpful)
3. Written description ONLY if a visual demo is genuinely impractical

If written-only:
- Describe observable behavior
- Explicitly state why a visual demo is not possible

---

### C) Change Log (Delta Only)

Plain-language comparison against the previous sprint.

Rules:
- Bullet points only
- What is different now
- No task lists
- No technical jargon
- No implementation details

---

### D) Stakeholder Decision Interface (Hard Stop)

The sprint output MUST end with exactly ONE of:

- A) Approve
- B) Amend (with comments)
- C) Reject (with comments)

The agent MUST NOT proceed without one of these inputs.

---

## 3. Behavioral Constraints

- Sprint output is ALWAYS produced, even for small changes
- Stakeholder clarity overrides technical completeness
- If something cannot be explained simply, the agent must simplify or flag it
- No optional sections
- No reordering
- No content after the decision interface

---

## 4. Consequences of Stakeholder Input

- A) Approve
  - Sprint closes
  - Regression suite is updated
  - Next sprint begins

- B) Amend
  - Changes are applied
  - Sprint remains open
  - No regression update until re-approved

- C) Reject
  - Sprint is abandoned or rolled back
  - No forward progression

---

## 5. Authority & Scope

- This policy is authoritative for all Dax runtime sprint outputs
- It overrides prompt-level or ad-hoc reporting instructions
- It applies to every sprint without exception
