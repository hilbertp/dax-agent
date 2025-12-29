# Sprint Execution Summary Template

This template defines the mandatory structure for every Dax sprint execution summary.
Exactly one summary file MUST be created per sprint and linked from the stakeholder report.

---

## 1. Sprint ID

**Sprint ID:** [e.g., 2025-12-29-1400]

**Branch:** [branch name, e.g., main]

---

## 2. Authority Reference

**Authority Document:** docs/authority/WORKFLOW_OVERVIEW.md

**Version:** [link to authority commit/version]

**Decomposition Reference:** [link to authority DECOMPOSITION.md section]

---

## 3. Scope Initialization

**Objective:** [Plain-language goal for this sprint]

**In Scope:**
- [Item 1]
- [Item 2]
- [Item 3]

**Out of Scope:**
- [Item 1]
- [Item 2]

---

## 4. Decomposition Steps

**Step 1:** [Description]
- Inputs: [what required]
- Outputs: [what produced]

**Step 2:** [Description]
- Inputs: [what required]
- Outputs: [what produced]

**Step 3:** [Description]
- Inputs: [what required]
- Outputs: [what produced]

[Add additional steps as needed]

---

## 5. Implementation Actions

**Action 1:** [Task name]
- Command: `[shell command if applicable]`
- Files changed: [list of files]
- Lines of code: [approximate count]

**Action 2:** [Task name]
- Command: `[shell command if applicable]`
- Files changed: [list of files]
- Lines of code: [approximate count]

[Add additional actions as needed]

---

## 6. Artifacts Produced

**Path:** docs/sprints/[SPRINT_ID]/EXECUTION_SUMMARY.md
**Type:** Proof artifact (mandatory)

**Additional Artifacts:**
- [Artifact 1]: [path/to/artifact]
- [Artifact 2]: [path/to/artifact]

**Git Commits:**
- [Commit 1]: `[hash]` - [message]
- [Commit 2]: `[hash]` - [message]

---

## 7. Deviations and Limits

**Constraints Encountered:**
- [Constraint 1]
- [Constraint 2]

**Workarounds Applied:**
- [Workaround 1]
- [Workaround 2]

**Known Limitations:**
- [Limitation 1]
- [Limitation 2]

---

## 8. Stakeholder Decision Placeholder

**Stakeholder Approval Status:**

- [ ] A) Approve - Sprint closes, regression suite updated, next sprint begins
- [ ] B) Amend - Changes applied, sprint remains open, no regression update until re-approved
- [ ] C) Reject - Sprint abandoned or rolled back, no forward progression

**Stakeholder Comments:**
[Placeholder for stakeholder feedback]

---

## 9. Compliance Statement

This sprint execution summary certifies:

- ✓ Exactly one summary file created for this sprint
- ✓ Summary created BEFORE stakeholder approval was requested
- ✓ All mandatory sections completed (Sprint ID, Authority Reference, Scope, Decomposition, Actions, Artifacts, Deviations, Decision, Compliance)
- ✓ Clickable link exists in stakeholder report (STAKEHOLDER_SPRINT_OUTPUT.md)
- ✓ No framework changes or unrelated refactors applied
- ✓ Bootstrap behavior remains unchanged

**Summary Created:** [TIMESTAMP]
**Created By:** [agent identifier or user]
**Approval Status:** [Pending / Approved / Amended / Rejected]

