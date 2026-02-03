# Dax 

## Table of Content

1. Mission Statement
2. Product Requirement Document
3. Epic List
4. Readme

## 1. Mission Statement

Dax empowers non-developers to ship production-ready software features by guiding AI agents through disciplined, professional development workflows - ensuring every change is transparent, revertible, and safe for team collaboration.

---- 

## 2. PRD

### Business Context & Problem

What specific pain point does Dax solve?
Dax mediates the inability of current software developent agents to stay on course and deliver exactly what a stakeholder asks for. No matter how clearly the business logic is explained currently, on the way of putting them into code and increment, there is so much hallicination/drift which multiplies quickly into a fully garbled increment. The user cannot see where the AI went of course and has to try and diagnose and improve very incrementally. 
While he does that, working code is also chaanged making the attempt completely superfluous. AI agents just don't have the ability to stay inbounds currently.

### Who is the primary user?

All sorts of roles are possible. A manager, a team lead, a business owner, an non-technical employee. Anyone who is willing to think and learn and who doesnt scare away from seftware development with the help of AI. So, if we want to characterize these people more carefully: smart, adaptable, learning users who can describe business logic clearly and then evaluate the outcome, decribe the delta and continue until they have a feature that they like. 
The agent will do everything technical, the user is the stakeholder and product owner of the feature. The AI will guide the user through a predifined worklflow, so the user always knows what is currently expect/required/recommended.

Currently, the only way to develop in business reality is to hire full teams including a product owner, architect, development engineers and QA engineers. Without these roles, a software project fails; With or without AI. 

With Dax, all the technical roles will be filled by the AI, the user can fully concentrate on judging the increments/artifacts and make estimated guesses or escalate to team members, the team lead or a techical human or AI pro.


### Core Requirements

#### What does "production-ready" mean for your users?

The user and agent together can touch an already running and operational software. While doing that, they follow clear best practices including CI/CD with full rollout and rollback capabilities. The agent uses branching, committing, merging, linting and building, passing regression tests, adding new unit and regression tests and so on. They employ practices like a team of humans would do when they need to develop on the same code base and ensure fully compliant and operationally secure software: production-grade.  

#### What level of control does the user need?

Users will be treated liek stakeholder and product owner. They define what they want and the Dax agent workflow will deliver each shippable increment for review. User give (a) thumbs up, (b) okay, but needs changes or (c) realize they are on the wrong track and start anew.

#### What's the handoff point with professional teams?
Every merging to main must first be code reviewed by a human or a proven code review AI agent when we have found one. It must pass regression tests and it must include new regression and new unit tests. In teams of human and AIs this step is mandatory and needs to be done BEFORE showing the increment to the stakeholder user.
If it is just the user and the Dax agent without additional team members, the code review will be done by an extra AI with limited context.

### Constraints

#### What can we assume exists in v0/MVP?

Git repository?
Specific programming languages/frameworks?
Local development environment?


What's explicitly out of scope for MVP?

## 4. Readme

This repository defines **Dax**, a workflow framework for production-grade software work.

Dax does not implement software. Dax does not replace the implementation agent. Dax shapes how work is defined, executed, verified, and reviewed.

This README is for humans understanding what Dax does and how to start.

**When you're ready to begin, run:** `agent/bootstrap.sh`

The bootstrap will print the full opening message explaining what Dax needs and what it will do.

---

### Quick Start

1. Clone this repository or run the installer from another repo.
2. Prepare two documents in your repo root:
   - **PRD.md** – Product Requirements Description
   - **EPICS.md** – Ranked list of epics (3+)
3. Run `./agent/bootstrap.sh` and read the opening message.
4. Provide the PRD and EPICS.md when prompted.

---

### What Dax Does

Dax v0 is a **behavioral framework** for implementation agents.

It works by:
- Requiring clear inputs: a Product Requirements Description and ranked Epic list
- Injecting explicit rules and expectations into an implementation agent
- Enforcing decomposition, checkpoints, review cycles, and explicit sprint artifacts
- Surfacing uncertainty and drift instead of hiding them

Dax does **not** own process integrity yet. The implementation agent executes the work. Dax shapes *how* that work is approached and reported.

**Dax cannot prevent an implementation agent from hallucinating or proceeding incorrectly.** It can only warn when required inputs are missing and ensure that work is verified and reviewed before progress continues.

---

### What Dax Is Not

- Not a replacement for engineers
- Not a project management tool
- Not an autonomous system
- Not a decision-maker with its own agenda
- **Not a blocker** – Dax cannot and does not prevent implementation agents from executing

Dax does not refuse to work.
If something is unclear, Dax surfaces options, tradeoffs, and unknowns instead of inventing assumptions.

**Dax does not implement software.** Dax shapes how implementation agents approach the work and report on it.

---

### Core Behaviors Enforced by Dax

When applied correctly, Dax biases the agent toward:

- Explicit decomposition of work
- Clear acceptance criteria
- Incremental, demoable progress
- Regression awareness
- Stakeholder-facing reporting
- Controlled sprint boundaries

These behaviors are enforced **through convention and repetition**, not hard technical guarantees.

---

### Mandatory Bootstrap Rule

Dax has **undefined behavior** unless bootstrapped correctly.

**Every session MUST start with bootstrap.**

Bootstrap is the entry point.
If bootstrap is skipped, Dax is not active.

Before bootstrap, you must create:
- **PRD.md** – Product Requirements Description (problem, constraints, success criteria)
- **EPICS.md** – Ranked list of 3+ work units

Bootstrap will warn if either is missing or underspecified.

---

### How to Start (Human Instructions)

1. Clone this repository.
2. Run the bootstrap script:
   ```bash
   bash agent/bootstrap.sh