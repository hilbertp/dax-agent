# ACCEPTANCE_CRITERIA.md
## Canonical Definition and Enforcement Rule

Definition
Acceptance criteria are observable, binary conditions that must be true for a capability to be considered satisfied.

They describe what must be true, never how it is implemented or tested.

Valid acceptance criteria
1. Observable by inspection of behavior or UI.
2. Binary pass or fail.
3. 1:1 mapped to a declared capability.
4. Implementation-agnostic.

Acceptance criteria are NOT
1. Capabilities or decomposition.
2. Implementation instructions.
3. Test scripts or selectors.
4. Vague language (appropriate, visible, identifiable).
5. New feature requests.

Enforcement
Whenever writing acceptance criteria, this file is authoritative.
Violations are drift.

Audit Requirement
- Output MUST contain an "AUDIT" section before the "FINAL" list.
- Audit must explicitly list each rule as PASS or FAIL.
- Missing audit means the criteria are invalid.

Output rule
Only a numbered list in the FINAL section.
One sentence per item.
No prose before or after the list.
