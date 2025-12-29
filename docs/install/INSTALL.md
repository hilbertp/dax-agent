## Dax v0.1 Installation

install.sh downloads the Dax runtime files into a hidden `.dax/` folder in your target repository. It is POSIX sh, non-interactive, and defaults to the `main` reference unless `DAX_REF` is provided.

### Required Inputs

Dax relies on two documents to shape workflow reliably:

1. **PRD.md** – Product Requirements Description
   - Problem statement: what are you solving?
   - Constraints: timeline, tech stack, compliance, budget
   - Success criteria: how do you know you succeeded?

2. **EPICS.md** – Ranked Epic List
   - 3+ numbered epics
   - Prioritized by dependency or business value
   - Brief description for each

See [docs/examples/PRD_EXAMPLE.md](../examples/PRD_EXAMPLE.md) and [docs/examples/EPIC_LIST_EXAMPLE.md](../examples/EPIC_LIST_EXAMPLE.md) for realistic examples.

**The Development Start Gateway will warn if PRD.md or EPICS.md are missing or underspecified.** This is a warn-only gate–it does not block installation. However, implementation agents operating without clear inputs may hallucinate requirements and introduce unexpected scope.

### Quick install (curl | sh)
```bash
curl -fsSL https://raw.githubusercontent.com/hilbertp/dax-agent/main/install.sh | sh
```

### Pinned install (recommended)
```bash
DAX_REF=<commit-or-tag> curl -fsSL https://raw.githubusercontent.com/hilbertp/dax-agent/main/install.sh | sh
```

### Local run
```bash
curl -fsSL https://raw.githubusercontent.com/hilbertp/dax-agent/main/install.sh -o install.sh
chmod +x install.sh
./install.sh /path/to/target
```

### Verify
```bash
.dax/agent/bootstrap.sh
```

### Important Limitations

**Dax cannot prevent implementation agents from proceeding incorrectly.**

Dax shapes workflow and review–it does not implement. When bootstrap runs, it checks for PRD.md and EPICS.md and warns if they are missing or underspecified. But implementation agents (like ii-agent, code generators, or LLMs) often operate independently. They may:

- Generate code without validating it against your PRD
- Introduce scope not in your epic list
- Misinterpret constraints or success criteria
- Produce work that does not align with your actual goals

A **complete, clear PRD and ranked epic list is your primary mechanism for steering the work.** Dax surfaces the risk; you must ensure your planning documents are specific and comprehensive.
