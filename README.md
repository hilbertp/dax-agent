# Dax Agent

This repository defines **Dax**, a workflow framework for production-grade software work.

Dax does not implement software. Dax does not replace the implementation agent. Dax shapes how work is defined, executed, verified, and reviewed.

This README is for humans understanding what Dax does and how to start.

**When you're ready to begin, run:** `agent/bootstrap.sh`

The bootstrap will print the full opening message explaining what Dax needs and what it will do.

---

## Quick Start

1. Clone this repository or run the installer from another repo.
2. Prepare two documents in your repo root:
   - **PRD.md** – Product Requirements Description
   - **EPICS.md** – Ranked list of epics (3+)
3. Run `./agent/bootstrap.sh` and read the opening message.
4. Provide the PRD and EPICS.md when prompted.

---

## What Dax Does

Dax v0 is a **behavioral framework** for implementation agents.

It works by:
- Requiring clear inputs: a Product Requirements Description and ranked Epic list
- Injecting explicit rules and expectations into an implementation agent
- Enforcing decomposition, checkpoints, review cycles, and explicit sprint artifacts
- Surfacing uncertainty and drift instead of hiding them

Dax does **not** own process integrity yet. The implementation agent executes the work. Dax shapes *how* that work is approached and reported.

**Dax cannot prevent an implementation agent from hallucinating or proceeding incorrectly.** It can only warn when required inputs are missing and ensure that work is verified and reviewed before progress continues.

---

## What Dax Is Not

- Not a replacement for engineers
- Not a project management tool
- Not an autonomous system
- Not a decision-maker with its own agenda
- **Not a blocker** – Dax cannot and does not prevent implementation agents from executing

Dax does not refuse to work.
If something is unclear, Dax surfaces options, tradeoffs, and unknowns instead of inventing assumptions.

**Dax does not implement software.** Dax shapes how implementation agents approach the work and report on it.

---

## Core Behaviors Enforced by Dax

When applied correctly, Dax biases the agent toward:

- Explicit decomposition of work
- Clear acceptance criteria
- Incremental, demoable progress
- Regression awareness
- Stakeholder-facing reporting
- Controlled sprint boundaries

These behaviors are enforced **through convention and repetition**, not hard technical guarantees.

---

## Mandatory Bootstrap Rule

Dax has **undefined behavior** unless bootstrapped correctly.

**Every session MUST start with bootstrap.**

Bootstrap is the entry point.
If bootstrap is skipped, Dax is not active.

Before bootstrap, you must create:
- **PRD.md** – Product Requirements Description (problem, constraints, success criteria)
- **EPICS.md** – Ranked list of 3+ work units

Bootstrap will warn if either is missing or underspecified.

---

## How to Start (Human Instructions)

1. Clone this repository.
2. Run the bootstrap script:
   ```bash
   bash agent/bootstrap.sh
