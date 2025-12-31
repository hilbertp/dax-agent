# Repository Structure Map

**Repository:** hilbertp/dax-agent  
**Branch:** main  
**Generated:** 2025-12-30

---

## Directory Tree

```
dax-agent/
├── agent/
│   ├── bootstrap.sh
│   ├── check_start_gateway.sh
│   └── ensure_execution_summary.sh
├── dax/
│   └── runtime/
│       ├── RUNTIME_DEFINITION.json
│       └── RUNTIME_LOCKFILE.json
├── docs/
│   ├── authority/
│   │   ├── ACCEPTANCE_CRITERIA.md
│   │   ├── DECOMPOSITION.md
│   │   ├── IDENTITY.md
│   │   ├── REPO_STRUCTURE.md
│   │   └── WORKFLOW_OVERVIEW.md
│   ├── control/
│   │   ├── DEVELOPMENT_START_GATEWAY.md
│   │   ├── MERGE_TRIGGER.md
│   │   ├── POST_MERGE_REGRESSION_POLICY.md
│   │   ├── REGRESSION_OWNERSHIP.md
│   │   ├── ROLLBACK_POLICY.md
│   │   ├── SPRINT_EXECUTION_SUMMARY_TEMPLATE.md
│   │   ├── STAKEHOLDER_SPRINT_OUTPUT.md
│   │   └── WORKFLOW_BASELINE.md
│   ├── examples/
│   │   ├── EPIC_LIST_EXAMPLE.md
│   │   └── PRD_EXAMPLE.md
│   ├── install/
│   │   ├── BOOTSTRAP_RELOCATABLE.md
│   │   └── INSTALL.md
│   ├── prompts/
│   │   └── OPENING_MESSAGE.md
│   ├── visual/
│   │   └── WORKFLOW_FLOW.md
│   └── MANIFEST.json
├── install.sh
├── README.md
├── REPOSITORY_MAP.md
├── test_gateway_discovery.sh
└── test_opening_message.sh
```

---

## Directory Breakdown

### Root Level
- `README.md` - Repository overview
- `REPOSITORY_MAP.md` - This file (structure map)
- `install.sh` - Runtime installer
- `test_gateway_discovery.sh` - Gateway discovery smoke tests
- `test_opening_message.sh` - Opening message integrity test

### `agent/`
Bootstrap and automation scripts:
- `bootstrap.sh` - Agent bootstrap script
- `check_start_gateway.sh` - Development Start Gateway heuristic checker (warn-only)
- `ensure_execution_summary.sh` - Sprint execution summary verification script

### `docs/`
Primary documentation directory

#### `docs/authority/`
Authoritative workflow definitions:
- `ACCEPTANCE_CRITERIA.md` - Sprint acceptance criteria
- `DECOMPOSITION.md` - Task decomposition guidelines
- `IDENTITY.md` - Agent identity and behavioral guidelines
- `REPO_STRUCTURE.md` - Repository structure documentation
- `WORKFLOW_OVERVIEW.md` - Complete workflow overview

#### `docs/control/`
Workflow control policies:
- `MERGE_TRIGGER.md` - Merge trigger rules
- `POST_MERGE_REGRESSION_POLICY.md` - Post-merge regression test policy
- `REGRESSION_OWNERSHIP.md` - Regression suite ownership guidelines
- `ROLLBACK_POLICY.md` - Production rollback policy
- `SPRINT_EXECUTION_SUMMARY_TEMPLATE.md` - Sprint execution summary template
- `STAKEHOLDER_SPRINT_OUTPUT.md` - Stakeholder sprint output format
- `DEVELOPMENT_START_GATEWAY.md` - Development Start Gateway policy (relocated from docs/gateways/)
- `WORKFLOW_BASELINE.md` - Frozen baseline workflow version

#### `docs/examples/`
Templates and examples:
- `PRD_EXAMPLE.md` - Product Requirements Description example
- `EPIC_LIST_EXAMPLE.md` - Epic list example

#### `docs/install/`
Install and relocation notes:
- `INSTALL.md` - Install instructions
- `BOOTSTRAP_RELOCATABLE.md` - Relocatability guidance

#### `docs/prompts/`
- `OPENING_MESSAGE.md` - Canonical kickoff message printed by bootstrap

#### `docs/visual/`
- `WORKFLOW_FLOW.md` - Visual workflow documentation

#### `docs/`
- `MANIFEST.json` - Complete file manifest with raw GitHub URLs, SHA-256 hashes, and file sizes

---

## File Count Summary

- **Total directories:** 13 (excluding .git)
- **Total files:** 30 (excluding .git)
  - Root: 5 (README.md, REPOSITORY_MAP.md, install.sh, test_gateway_discovery.sh, test_opening_message.sh)
  - `agent/`: 3
  - `dax/runtime/`: 2
  - `docs/authority/`: 5
  - `docs/control/`: 8 (includes DEVELOPMENT_START_GATEWAY.md)
  - `docs/examples/`: 2
  - `docs/install/`: 2
  - `docs/prompts/`: 1
  - `docs/visual/`: 1
  - `docs/`: 1 (MANIFEST.json)

---

## Access Points

**Public Manifest URL:**  
https://raw.githubusercontent.com/hilbertp/dax-agent/main/docs/MANIFEST.json

The manifest provides programmatic access to all repository files with:
- Full raw URLs (branch and commit-specific)
- SHA-256 content hashes
- File sizes in bytes
