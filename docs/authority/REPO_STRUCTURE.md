# Repository Structure — Authoritative Invariants

This document defines the meaning and invariants of the repository folders. It is short, explicit, and focused on stable behavior definitions.

---

## docs/authority/
- Contains ONLY documents that define Dax’s core behavior
- These files are the constitution of the agent
- Any behavior change requires modifying files here (rare, deliberate)

## docs/control/
- Operational policies and routines that support authority-defined behavior
- Examples: rollback policy, post-merge regression policy, stakeholder sprint output
- Implements authority; does not override it

## docs/visual/
- Human-readable diagrams and explanations
- No rules, no enforcement; explanatory only
- Example: WORKFLOW_FLOW.md

## docs/fallback/
- Archival snapshots and recovery artifacts
- NEVER treated as active rules or behavior sources
- Must not be referenced as authority

## docs/MANIFEST.json
- Canonical index of behavior-relevant files
- MUST point to `main` only, never branches
- Used by the agent to discover rules

## agent/
- Bootstrap and helper scripts only
- No behavior definition logic

## .github/workflows/
- Automation only (snapshots, checks)
- No behavior authority

---

## Precedence and Evolution
- Authority documents override control documents
- Control documents may evolve; authority documents change rarely
- Folder structure changes require updating this document and `docs/MANIFEST.json` together
