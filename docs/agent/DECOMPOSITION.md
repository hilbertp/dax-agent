# DECOMPOSITION.md
## Canonical Definition and Enforcement Rule

Definition
Decomposition is breaking a user story into the smallest possible set of functional capabilities that must exist for the story to be true.

Each item represents a capability that, if missing, makes the story false or incomplete.

Decomposition describes what must exist, never how it is built, tested, or deployed.

Valid decomposition items
1. Exactly one functional capability.
2. Implementation-agnostic.
3. Verification-agnostic.
4. Atomic and necessary.

Decomposition is NOT
1. Actions or steps.
2. Environment or tooling setup.
3. Design or implementation details.
4. Verification or acceptance criteria.
5. Work sequencing.

Enforcement
Whenever decomposing, this file is authoritative.
Violations are drift.

Output rule
Only a numbered list of capabilities.
No prose before or after.
