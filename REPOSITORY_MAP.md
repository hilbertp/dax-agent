# Repository Structure Map

**Repository:** hilbertp/dax-agent  
**Branch:** main  
**Generated:** 2025-12-29

---

## Directory Tree

```
dax-agent/
├── .github/
│   └── workflows/
│       └── authority_snapshot.yml
├── agent/
│   ├── bootstrap.sh
│   └── snapshot_authority.sh
├── docs/
│   ├── authority/
│   │   ├── ACCEPTANCE_CRITERIA.md
│   │   ├── DECOMPOSITION.md
│   │   ├── IDENTITY.md
│   │   ├── REPO_STRUCTURE.md
│   │   └── WORKFLOW_OVERVIEW.md
│   ├── control/
│   │   ├── MERGE_TRIGGER.md
│   │   ├── POST_MERGE_REGRESSION_POLICY.md
│   │   ├── REGRESSION_OWNERSHIP.md
│   │   ├── ROLLBACK_POLICY.md
│   │   ├── STAKEHOLDER_SPRINT_OUTPUT.md
│   │   └── WORKFLOW_BASELINE.md
│   ├── fallback/
│   │   ├── 2025-12-24-0016/
│   │   │   ├── ACCEPTANCE_CRITERIA.md
│   │   │   ├── DECOMPOSITION.md
│   │   │   ├── FALLBACK.json
│   │   │   ├── IDENTITY.md
│   │   │   └── WORKFLOW_OVERVIEW.md
│   │   ├── 2025-12-24-0020/
│   │   │   ├── ACCEPTANCE_CRITERIA.md
│   │   │   ├── DECOMPOSITION.md
│   │   │   ├── FALLBACK.json
│   │   │   ├── IDENTITY.md
│   │   │   └── WORKFLOW_OVERVIEW.md
│   │   ├── 2025-12-24-1253/
│   │   │   ├── ACCEPTANCE_CRITERIA.md
│   │   │   ├── DECOMPOSITION.md
│   │   │   ├── FALLBACK.json
│   │   │   ├── IDENTITY.md
│   │   │   └── WORKFLOW_OVERVIEW.md
│   │   ├── 2025-12-26-1333/
│   │   │   ├── ACCEPTANCE_CRITERIA.md
│   │   │   ├── DECOMPOSITION.md
│   │   │   ├── FALLBACK.json
│   │   │   ├── IDENTITY.md
│   │   │   └── WORKFLOW_OVERVIEW.md
│   │   ├── 2025-12-26-1412/
│   │   │   ├── ACCEPTANCE_CRITERIA.md
│   │   │   ├── DECOMPOSITION.md
│   │   │   ├── FALLBACK.json
│   │   │   ├── IDENTITY.md
│   │   │   └── WORKFLOW_OVERVIEW.md
│   │   ├── 2025-12-26-1620/
│   │   │   ├── ACCEPTANCE_CRITERIA.md
│   │   │   ├── DECOMPOSITION.md
│   │   │   ├── FALLBACK.json
│   │   │   ├── IDENTITY.md
│   │   │   └── WORKFLOW_OVERVIEW.md
│   │   ├── 2025-12-26-1757/
│   │   │   ├── ACCEPTANCE_CRITERIA.md
│   │   │   ├── DECOMPOSITION.md
│   │   │   ├── FALLBACK.json
│   │   │   ├── IDENTITY.md
│   │   │   └── WORKFLOW_OVERVIEW.md
│   │   ├── 2025-12-26-1821/
│   │   │   ├── ACCEPTANCE_CRITERIA.md
│   │   │   ├── DECOMPOSITION.md
│   │   │   ├── FALLBACK.json
│   │   │   ├── IDENTITY.md
│   │   │   └── WORKFLOW_OVERVIEW.md
│   │   └── 2025-12-27-0022/
│   │       ├── ACCEPTANCE_CRITERIA.md
│   │       ├── DECOMPOSITION.md
│   │       ├── FALLBACK.json
│   │       ├── IDENTITY.md
│   │       └── WORKFLOW_OVERVIEW.md
│   ├── visual/
│   │   └── WORKFLOW_FLOW.md
│   └── MANIFEST.json
├── README.md
├── REPOSITORY_MAP.md
└── SHORT_TERM_ACTION_PLAN.md
```

---

## Directory Breakdown

### Root Level
- `README.md` - Repository documentation
- `REPOSITORY_MAP.md` - This file (complete directory and file structure map)
- `SHORT_TERM_ACTION_PLAN.md` - Current sprint action plan

### `.github/workflows/`
- `authority_snapshot.yml` - GitHub Actions workflow for authority snapshots

### `agent/`
Bootstrap and automation scripts:
- `bootstrap.sh` - Agent bootstrap script
- `snapshot_authority.sh` - Authority snapshot generation script

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
- `STAKEHOLDER_SPRINT_OUTPUT.md` - Stakeholder sprint output format
- `WORKFLOW_BASELINE.md` - Frozen baseline workflow version

#### `docs/fallback/`
Historical authority snapshots (timestamped):
- `2025-12-24-0016/`
- `2025-12-24-0020/`
- `2025-12-24-1253/`
- `2025-12-26-1333/`
- `2025-12-26-1412/`
- `2025-12-26-1620/`
- `2025-12-26-1757/`
- `2025-12-26-1821/`
- `2025-12-27-0022/`

Each fallback snapshot contains:
- `ACCEPTANCE_CRITERIA.md`
- `DECOMPOSITION.md`
- `FALLBACK.json` - Snapshot metadata
- `IDENTITY.md`
- `WORKFLOW_OVERVIEW.md`

#### `docs/visual/`
- `WORKFLOW_FLOW.md` - Visual workflow documentation

#### `docs/`
- `MANIFEST.json` - Complete file manifest with raw GitHub URLs, SHA-256 hashes, and file sizes

---

## File Count Summary

- **Total directories:** 16 (excluding .git)
- **Total files:** 63 (excluding .git)
  - Root: 3 (README.md, REPOSITORY_MAP.md, SHORT_TERM_ACTION_PLAN.md)
  - `.github/workflows/`: 1
  - `agent/`: 2
  - `docs/authority/`: 5
  - `docs/control/`: 6
  - `docs/fallback/`: 45 (9 snapshots × 5 files each)
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
