# Development Start Gateway

This gateway validates that required inputs are present and adequately specified before Dax begins shaping the workflow.

**Purpose:** Dax relies on a Product Requirements Description and ranked Epic list to steer reliably. If these are missing or underspecified, implementation agents are likely to fill gaps by inference or hallucination. This gateway warns if that risk is present.

**Important:** This gateway is **warn-only**. Dax cannot and does not prevent implementation agents from proceeding. It can only surface the risk clearly and ensure the risk is reviewed. Exit code is always `0`.

## How It Finds PRD and Epics (Repository-First)

1. Determine the repository root via `git rev-parse --show-toplevel`; if unavailable, use the current working directory.
2. Search **only** within the repository for candidate files (persistent context), then fall back to `/upload` (session-scoped) **only if missing in the repo**.
3. Searchable extensions: `.md`, `.txt`, `.rst`, `.adoc` (text files under 1 MB).
4. Excluded directories: `.git`, `node_modules`, `dist`, `build`, `vendor`, `.dax`.
5. The gateway never moves files; it only reports what it finds.

## Heuristics (Content-Based, Warn-Only)

### PRD candidate signals
- Mentions of **Problem**, **Constraints**, **Success Criteria** (headings or text)
- Phrases: **Product Requirements** or **PRD**
- Confidence mapping: `high` when signals cover all three core concepts or phrase + breadth; `medium` when at least two core concepts are present; `low` when only one is present.

Confidence dampening (not enforcement):
- If the same file is selected for PRD and Epics, confidence for both is reduced.
- If the path looks like a report/summary/diagnostic/log/notes/readme, confidence is reduced.
- If the path does not suggest requirements/planning (e.g., lacks `prd`, `requirement`, `spec`, `plan`), confidence is reduced.

### Epic list candidate signals
- Mentions of **Epics**
- Numbered items (3 or more) using `1.`, `2.`, `3.` …
- References like `Epic 1` or `Epic:`
- Confidence mapping: `high` when epics are named and 3+ numbered items exist; `medium` with partial coverage; `low` with minimal evidence.

Confidence dampening (not enforcement):
- If the same file is selected for PRD and Epics, confidence for both is reduced.
- If the path looks like a report/summary/diagnostic/log/notes/readme, confidence is reduced.
- If the path does not suggest epics/roadmap/backlog/plan, confidence is reduced.

## Selection and Reporting
- Picks the highest-scoring PRD and Epic file above a minimum threshold; lists top three candidates if confidence is `medium`.
- Reports:
  - Whether PRD and epics were found
  - Selected file paths
  - Confidence (`high`, `medium`, `low`)
  - Alternatives (when confidence is `medium`)
- If missing in the repository but found in `/upload`, prints a warning that `/upload` is session-scoped and recommends copying into the repo.
- If missing everywhere, warns and asks for a PRD and ranked epic list.

## Output Rules

- Opening message is printed **first** by `bootstrap.sh`, then this gateway runs.
- If both PRD and epics are found with `high` confidence in the repo: prints `OK` and paths.
- If confidence is `medium` or `low`, or if `/upload` was used: prints `WARNING` with guidance on next steps.
- If missing: prints `WARNING` with explicit asks for PRD and epics.

## What It Checks

Before Dax will provide implementation guidance, two documents must be present and sufficiently specified in the target repository:

### 1. Product Requirements Description (PRD.md)

A document that captures the **what** and **why** of the work.

**Required sections:**
- **Problem Statement**: What is the user trying to solve or build? Why does it matter?
- **Constraints**: Budget, timeline, technical limits, stakeholder requirements.
- **Success Criteria**: Measurable outcomes. How do we know the work succeeded?

**Examples:**
- Good: [PRD_EXAMPLE.md](../examples/PRD_EXAMPLE.md)
- Bad: "We need a login page."
- Bad: "Build the feature mentioned in ticket #42" (no explanation).

### 2. Ranked Epic List (EPICS.md)

A prioritized breakdown of the work into logical units.

**Required:**
- At least 3 ranked epics (numbered 1, 2, 3, ...).
- Each epic has a one-line title and brief description.
- Epics are ordered by priority or dependency.

**Examples:**
- Good: [EPIC_LIST_EXAMPLE.md](../examples/EPIC_LIST_EXAMPLE.md)
- Bad: "Epic 1: Stuff. Epic 2: More stuff." (no priority, no structure).
- Bad: A single epic called "Build the whole feature."

## What Happens If Missing or Underspecified

The `check_start_gateway.sh` script (runs at bootstrap and before guidance is given) will:

1. **If either file is missing**: Print a WARNING block listing what is missing.
2. **If present but underspecified** (e.g., no success criteria in PRD, fewer than 3 epics): Print a WARNING listing what is incomplete.
3. **If both are present and adequately specified**: Print OK.
4. **In all cases**: Exit with status 0 (warn-only; no blocking).

Dax will:
- Issue the warning prominently.
- State that implementation agents may continue anyway.
- **Explicitly note** that implementation agents (like ii-agent) may hallucinate requirements, introduce unnecessary scope, or miss constraints if guidance is inadequate.
- Provide clarification and reporting guidance only, not implementation claims.

## Risk Awareness

**Do not expect Dax to prevent implementation agents from proceeding without a complete PRD and epic list.** 

Implementation agents (ii-agent, code generation systems) often operate independently and may:
- Assume requirements not stated in PRD.
- Introduce features not in the epic list.
- Misinterpret constraints or success criteria.
- Generate code that does not align with your actual goals.

**A complete PRD and ranked epic list is your mechanism for steering.**

## Testing the Gateway

### Expected output when PRD or EPICS missing:

```
⚠ Development Start Gateway WARNING ⚠

Missing required planning documents:
  - PRD.md: Not found (required: problem, constraints, success criteria)
  - EPICS.md: Not found (required: 3+ ranked epics)

Create PRD.md and EPICS.md in repo root before expecting high-quality workflow guidance.
See docs/examples/ for templates and examples.

Dax will proceed in WARN/REPORT mode only. Implementation agents may hallucinate scope.
```

### Expected output when both present and adequately specified:

```
✓ Development Start Gateway: OK
```

### Local test

Run from inside dax-agent repo with TARGET_ROOT set:

```bash
# Test warning case (empty temp dir)
TARGET_ROOT=/tmp/test-empty .dax/agent/check_start_gateway.sh

# Test OK case (after creating PRD.md and EPICS.md)
mkdir -p /tmp/test-complete
echo "# Problem: Users need auth." > /tmp/test-complete/PRD.md
echo "1. Backend auth" > /tmp/test-complete/EPICS.md
TARGET_ROOT=/tmp/test-complete .dax/agent/check_start_gateway.sh
```

## Files and Links

- Policy: [docs/control/DEVELOPMENT_START_GATEWAY.md](DEVELOPMENT_START_GATEWAY.md) (this file)
- Check script: [agent/check_start_gateway.sh](../../agent/check_start_gateway.sh)
- PRD example: [docs/examples/PRD_EXAMPLE.md](../examples/PRD_EXAMPLE.md)
- Epic example: [docs/examples/EPIC_LIST_EXAMPLE.md](../examples/EPIC_LIST_EXAMPLE.md)
