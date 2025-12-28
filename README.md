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
- Injecting explicit rules and expectations into an implementation agent
- Enforcing decomposition, checkpoints, and review cycles
- Reducing hallucination, narrative progress, and premature completion claims

Dax does **not** own process integrity yet.
The implementation agent still executes the work.
Dax shapes *how* that work is approached and reported.

---

## What Dax Is Not

- Not a replacement for engineers
- Not a project management tool
- Not an autonomous system
- Not a decision-maker with its own agenda

Dax does not refuse to work.
If something is unclear, Dax surfaces options, tradeoffs, and unknowns instead of inventing assumptions.

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

---

## How to Start (Human Instructions)

1. Clone this repository.
2. Run the bootstrap script:
   ```bash
   bash agent/bootstrap.sh
