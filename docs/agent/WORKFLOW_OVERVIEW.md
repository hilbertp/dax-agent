# WORKFLOW_OVERVIEW.md

## Purpose
This document defines the operational lifecycle for ii-agent when executing tasks. It ensures consistency, reproducibility, and strict adherence to established contracts by defining the sequence of operations and mandatory checkpoints for every unit of work.

## Default entrypoint
1. Every task begins by reading docs/MANIFEST.json.
2. The agent must treat MANIFEST as the single source of truth for what to load next.
3. The user prompt is not the authority for process, only for the task intent.
4. If the agent cannot access the manifest, it must stop and request the manifest content or a repo link.
5. The agent must never require the user to restate authority paths in prompts.

## Core Loop
1. Decompose the user story into atomic capabilities.
2. Define AC (Acceptance Criteria) for each capability.
3. Implement the solution.
4. Verify the implementation against AC.
5. Commit the changes.
6. Report the results.

## Self Audit Gates
Before proceeding, ii-agent must re-read and self-audit against:
- docs/agent/DECOMPOSITION.md
- docs/agent/ACCEPTANCE_CRITERIA.md

## Audit as Artifact
- Any required self-audit MUST be emitted as an external artifact.
- An audit that is not output does not count as performed.
- Outputs without visible AUDIT sections are invalid by definition.
- Internal reasoning or "mental checks" have zero validity.

## Stop Conditions
If any audit section is missing, incomplete, ambiguous, or failing, stop, revert, log the triggered rule, and request a corrected plan.
Proceeding without visible audit is a contract violation.

## Evidence Rule
ii-agent must attach evidence for verification (test output or browser proof) when applicable.
If not applicable (docs only change), evidence is the git diff plus a successful push.
