## Dax v0.1 Installation

Install Dax into your target repository. After installation, run bootstrap to see the opening message which explains everything Dax needs and what it will do.

### Install

```bash
curl -fsSL https://raw.githubusercontent.com/hilbertp/dax-agent/main/install.sh | sh
```

Or with a specific commit (recommended for production):

```bash
DAX_REF=<commit-or-tag> curl -fsSL https://raw.githubusercontent.com/hilbertp/dax-agent/main/install.sh | sh
```

Or download and run locally:

```bash
curl -fsSL https://raw.githubusercontent.com/hilbertp/dax-agent/main/install.sh -o install.sh
chmod +x install.sh
./install.sh /path/to/target
```

### Bootstrap (required)

After installation, run:

```bash
.dax/agent/bootstrap.sh
```

This prints the Dax opening message, which describes:
- What Dax needs (Product Requirements Description and ranked Epic list)
- What Dax will do
- What Dax will not do
- The sprint contract

Read the opening message completely before proceeding.

### Provide Required Inputs

Create two files in your repo root (as described in the opening message):

1. **PRD.md** – Product Requirements Description
   - Problem statement
   - Constraints (timeline, budget, tech stack, compliance)
   - Success criteria

2. **EPICS.md** – Ranked Epic list
   - 3+ numbered epics
   - Prioritized by dependency or value
   - Brief description for each

See `docs/examples/` in your `.dax/` folder for realistic examples.

### Verify and Proceed

Run bootstrap again:

```bash
.dax/agent/bootstrap.sh
```

If PRD.md and EPICS.md are present and adequately specified, Dax will acknowledge them and you can proceed with the workflow.
