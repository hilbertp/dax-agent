# Repository Structure — Authoritative Invariants

This document defines the meaning and invariants of repository folders. It is short, explicit, and focused on stable behavior definitions.

---

## docs/authority/
- Contains ONLY core behavior rules — the constitution of Dax
- Any behavior change is made here (rare, deliberate)

## docs/control/
- Supporting operational policies that implement authority-defined behavior
- Must not override authority; implements it

## docs/visual/
- Explanatory content for humans
- No rules and no enforcement

## docs/fallback/
- Archival snapshots and recovery artifacts
- Never treated as active rules
- MUST NOT be referenced in `docs/MANIFEST.json`

## docs/MANIFEST.json
- Canonical index of behavior-relevant files
- MUST point to `main` only, never branches

## agent/
- Helper and bootstrap scripts only
- No behavior definition logic

## .github/workflows/
- Automation only (snapshots, checks)
- Workflow files MUST reside in `.github/workflows/`, never in repository root

## Repository Root
- `SHORT_TERM_ACTION_PLAN.md` is allowed in root (HUMAN OVERVIEW ONLY, non-authoritative)
- No workflow files permitted in root
- `README.md` may be helpful but is never authoritative
- No behavior authority

---

## Behavioral Authority Invariant
- The only locations allowed to define or constrain agent behavior are `docs/authority` and `docs/control`.
- `README.md` may be helpful but is never authoritative.
- Any exception requires updating `docs/authority/REPO_STRUCTURE.md` and `docs/MANIFEST.json` together.
