# WORKFLOW_OVERVIEW.md

## Purpose
This document defines the operational lifecycle for ii-agent when executing tasks. It ensures consistency, reproducibility, and strict adherence to established contracts by defining the sequence of operations and mandatory checkpoints for every unit of work.

Session start requirement:
- The agent MUST run agent/bootstrap.sh and include its output before processing any task.
- If bootstrap output is missing or indicates failure, the agent MUST stop and request correction.
- Any work performed before successful bootstrap is undefined behavior.

## Default entrypoint
1. Every task begins by reading docs/MANIFEST.json.
2. The agent must treat MANIFEST as the single source of truth for what to load next.
3. The user prompt is not the authority for process, only for the task intent.
4. If the agent cannot access the manifest, it must stop and request the manifest content or a repo link.
5. The agent must never require the user to restate authority paths in prompts.

## Core Loop
The core loop contains these required activities:
1. Decompose the user story into atomic capabilities.
2. Define AC (Acceptance Criteria) for each capability.
3. Implement the solution on a sprint branch.
4. Verify the implementation against AC.
5. Run Regression Gate (end of sprint).
6. Run Stakeholder Review Gate.
7. Run Sprint Closure Gate.
8. Merge sprint branch to main.
9. Report the results.

## Canonical execution order (mandatory)

This section defines the only valid execution order.
If another section appears to imply a different order, this section wins.

A) Start of session
1. Run agent/bootstrap.sh and include its output.
2. Read docs/MANIFEST.json and load authority docs from the manifest entrypoints.

B) Inside a sprint branch
3. Decompose, then emit AUDIT and FINAL.
4. Define acceptance criteria, then emit AUDIT and FINAL.
5. Implement incrementally. Commits on the sprint branch are allowed at any time.

C) End of sprint gates (must happen in this order)
6. Run Regression Gate. If it fails, fix and rerun until pass or user stops.
7. Run Stakeholder Review Gate. Outcome is Approve, Amend, or Reject.
8. If Amend, remain on the same sprint branch and repeat steps 6 and 7.
9. If Reject, stop. No merge to main occurs.

D) Closure and merge
10. If Approve, run Sprint Closure Gate (including any required regression updates and rerun).
11. Merge sprint branch to main exactly once, after Sprint Closure passes.
12. Report results and propose next sprint, then wait for stakeholder approval to start.

## Regression Gate (end of sprint)

This gate is executed on the sprint branch, never on main.

1. Purpose
Regression tests are the end of sprint safety net. Natural Language Acceptance Criteria are for intra sprint verification. Regression is for protecting previously working behavior.

2. When to run
Before presenting to the stakeholder, the agent MUST attempt to run the project’s regression tests on the sprint branch.

3. How to detect tests
If a test command or test suite exists (package.json scripts, Makefile target, or documented command in the repo), run it and capture output.

4. If no regression tests exist
If the repository has no regression test command or suite, the agent MUST state “No regression suite detected, skipping regression gate” and may proceed to stakeholder review.

5. Fail behavior
If regression tests exist and fail, the agent MUST NOT proceed to stakeholder review or merge steps.
Instead it MUST enter a fix loop on the same sprint branch:
a) fix
b) rerun regression
c) repeat until pass or user stops the sprint

6. Evidence requirement
For regression runs, the agent MUST include evidence in its report:
a) the exact command executed
b) exit status
c) the relevant part of the test output

7. Relationship to merge
Stakeholder approval may only be requested after the regression gate passes, or is explicitly skipped because no regression suite exists.

## Stakeholder Review Gate

This gate is executed on the sprint branch, never on main.

1. Purpose  
Stakeholder review is the human validation checkpoint.  
The sprint is not accepted until a stakeholder explicitly approves the delivered increment.

2. Preconditions  
The Regression Gate must have passed, or been explicitly skipped because no regression suite exists.

3. What the agent must present  
The agent MUST present, in a concise and human-readable form:
a) a summary of what changed in this sprint  
b) where and how the increment can be reviewed (URL, dev command, or artifact)  
c) which acceptance criteria were verified and how  
d) any known limitations, tradeoffs, or open issues  

4. Allowed outcomes  
The stakeholder MUST choose exactly one:
a) Approve  
b) Amend  
c) Reject  

5. Outcome handling  
- Approve: proceed to Sprint Closure Gate.  
- Amend: remain on the same sprint branch, apply requested changes, then repeat Regression Gate and Stakeholder Review Gate.  
- Reject: abandon or deprecate the sprint branch. No merge occurs.

6. Evidence requirement  
The agent MUST record:
- the stakeholder decision
- any amendment requests or rejection reason

Claims of stakeholder approval without explicit evidence are invalid.

## Sprint Closure Gate

This gate is executed on the sprint branch, never on main.

1. Purpose
Sprint closure makes the sprint releasable, not just demoable.

2. Preconditions
Stakeholder outcome is Approve.

3. Closure checklist
a) Add or update regression tests that cover the newly approved behavior, if a regression framework exists.
b) Run the full regression suite again after adding or updating tests.
c) If the suite fails, fix and rerun until pass or stakeholder stops the sprint.

4. Evidence requirements
The agent MUST include:
a) the exact regression command executed
b) exit status
c) relevant test output excerpt

5. Merge rule
Merge to main happens once, after closure checklist passes.
No work is considered complete until the merge is done.

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

## Authority document verification
- Whenever the agent creates, modifies, or claims compliance with any authoritative document (IDENTITY.md, DECOMPOSITION.md, ACCEPTANCE_CRITERIA.md, WORKFLOW_OVERVIEW.md), it MUST include formatting proof in its output.
- Formatting proof MUST include:
  - For Markdown authority documents: a command output showing line structure (e.g. `sed -n '1,40p' <file>` or equivalent).
  - For JSON authority documents: a successful parse validation (e.g. `jq . <file>` or equivalent).
- Claims of compliance without proof are invalid.
