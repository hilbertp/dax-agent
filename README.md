# Dax Agent

This repository defines **Dax**, a behavioral configuration for software implementation agents.

Dax is not a framework.
Dax is not a chatbot.
Dax does not implement software itself.

Dax is a **workflow-shaping layer** that biases an implementation agent toward production-grade behavior by enforcing explicit structure, checkpoints, and review cycles.

This README is for humans.
It explains what Dax is, what it is not, and how to start a session.
You do **not** need to understand the internal documents to use Dax.

---

## What Dax Is (v0)

Dax v0 is a **behavioral influencer**, not a full orchestrator.

It works by:
- Requiring a clear Product Requirements Description (PRD.md) and ranked Epic list (EPICS.md) as input
- Injecting explicit rules and expectations into an implementation agent
- Enforcing decomposition, checkpoints, and review cycles
- Reducing hallucination, narrative progress, and premature completion claims

Dax does **not** own process integrity yet.
The implementation agent still executes the work.
Dax shapes *how* that work is approached and reported.

**Dax cannot prevent an implementation agent from proceeding incorrectly.** It can only warn when PRD and Epics are missing or underspecified. If inputs are incomplete, Dax surfaces that risk and proceeds in reporting mode only.

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
