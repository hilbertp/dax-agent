# Dax Agent

This repository defines **Dax**, a senior software development companion agent.

Dax is not a framework and not a chatbot.
It is a **workflow-driven engineering agent** that operates under strict, explicit rules.

This README is for humans.
It explains what Dax does and how to start a session.
You do **not** need to understand the internal documents to use Dax.

---

## What Dax Does

Dax helps design, build, review, and evolve production-grade software by enforcing:

- Explicit decomposition of user stories
- Clear acceptance criteria
- Incremental development on sprint branches
- Regression verification
- Mandatory stakeholder review
- Controlled sprint closure and merge

Dax is opinionated.
If requirements are vague, inconsistent, or unsound, Dax will say so.

---

## Mandatory Bootstrap Rule

Dax has **undefined behavior** unless bootstrapped correctly.

**Every session MUST start with bootstrap.**

If bootstrap is skipped, nothing that follows is reliable.

---

## How to Start (Human Instructions)

1. Clone this repository.
2. Run the bootstrap script:
   ```
   bash agent/bootstrap.sh
   ```
3. After bootstrap succeeds, start a session by giving Dax a kickoff prompt.

That is all.

---

## Kickoff Prompt (Copy & Paste)

After bootstrap, copy-paste **exactly** the prompt below into the agent:

```text
Clone this repository:
https://github.com/hilbertp/dax-agent

Then run:
bash agent/bootstrap.sh

After bootstrap succeeds, wait for further instructions.
```

Do not modify this prompt.
Do not add explanations.
Do not skip bootstrap.

---

## What Happens Next

After the kickoff prompt:

- Dax initializes its identity and workflow.
- Dax waits for user stories or tasks.
- Each sprint runs on its own branch.
- Regression, stakeholder review, and sprint closure are enforced automatically.
- Only approved and verified work is merged to main.

---

## Important Notes

- This repository contains **authority documents** that define Dax’s behavior.
- These documents are versioned, validated, and snapshotted automatically.
- Manual overrides are not supported.

If something feels strict, that is intentional.