# Dax Installation Guide

## Overview

`install.sh` installs the Dax runtime into a target repository, creating a `.dax/` folder with all necessary runtime files.

## Quick Start

```bash
# Install Dax into current directory
curl -fsSL https://raw.githubusercontent.com/hilbertp/dax-agent/main/install.sh | sh

# Or download and run locally
wget https://raw.githubusercontent.com/hilbertp/dax-agent/main/install.sh
chmod +x install.sh
./install.sh
```

## Usage

### Basic Installation

```bash
# Install into current directory
./install.sh

# Install into specific directory
./install.sh /path/to/target/repo
```

### Pinned Installation (Recommended for Production)

Use the `DAX_REF` environment variable to pin to a specific commit, tag, or branch:

```bash
# Install from specific commit
DAX_REF=9f9cc6b ./install.sh

# Install from specific tag (when available)
DAX_REF=v0.1.0 ./install.sh

# Install from main branch (default)
DAX_REF=main ./install.sh
```

## Installation Behavior

### Safety Checks

1. **Self-detection**: Refuses to run inside the `dax-agent` repository itself
2. **Network requirements**: Requires `curl` or `wget`
3. **File verification**: Verifies all files downloaded successfully
4. **Permission verification**: Ensures shell scripts are executable
5. **Relocatability test**: Runs bootstrap from different directory to verify installation

### Installed Structure

```
.dax/
├── agent/
│   ├── bootstrap.sh                    (executable)
│   ├── snapshot_authority.sh           (executable)
│   └── ensure_execution_summary.sh     (executable)
└── docs/
    ├── MANIFEST.json
    ├── authority/
    │   ├── WORKFLOW_OVERVIEW.md
    │   ├── DECOMPOSITION.md
    │   ├── ACCEPTANCE_CRITERIA.md
    │   └── IDENTITY.md
    └── control/
        ├── STAKEHOLDER_SPRINT_OUTPUT.md
        └── SPRINT_EXECUTION_SUMMARY_TEMPLATE.md
```

Total: **10 runtime files** across 4 categories (bootstrap, authority, control, enforcement)

## Verification

After installation, the script automatically:

1. Verifies all 10 files exist
2. Verifies shell scripts have execute permissions
3. Runs bootstrap test from `/tmp` to prove relocatability

Manual verification:

```bash
# Run bootstrap to verify installation
.dax/agent/bootstrap.sh

# Expected output: Dax greeting message
# Exit code: 0 (success)
```

## What Gets Installed

The installer fetches files from GitHub based on `dax/runtime/RUNTIME_LOCKFILE.json`:

### Bootstrap (2 files)
- `agent/bootstrap.sh` - Entry point and initialization
- `docs/MANIFEST.json` - Runtime file manifest

### Authority (4 files)
- `docs/authority/WORKFLOW_OVERVIEW.md` - Workflow definitions
- `docs/authority/DECOMPOSITION.md` - Task decomposition guidelines
- `docs/authority/ACCEPTANCE_CRITERIA.md` - Sprint acceptance criteria
- `docs/authority/IDENTITY.md` - Agent identity and behavior

### Control (2 files)
- `docs/control/STAKEHOLDER_SPRINT_OUTPUT.md` - Sprint output policy
- `docs/control/SPRINT_EXECUTION_SUMMARY_TEMPLATE.md` - Execution summary template

### Enforcement (2 files)
- `agent/snapshot_authority.sh` - Authority snapshot generation
- `agent/ensure_execution_summary.sh` - Sprint summary verification

## Troubleshooting

### "Error: Neither curl nor wget found"
Install either `curl` or `wget`:
```bash
# macOS
brew install curl

# Ubuntu/Debian
sudo apt install curl

# RHEL/CentOS
sudo yum install curl
```

### "Error: Detected dax-agent repository"
You're running the installer inside the Dax source repository. Navigate to your target repository first:
```bash
cd /path/to/your/project
/path/to/dax-agent/install.sh
```

### "Error: Failed to fetch ..."
Check:
1. Internet connectivity
2. GitHub is accessible
3. DAX_REF points to a valid commit/branch/tag
4. Repository is public or you have access

### Bootstrap test fails
If verification fails:
1. Check all files were downloaded (verify file count)
2. Check permissions: `ls -la .dax/agent/`
3. Manually test: `cd /tmp && /path/to/target/.dax/agent/bootstrap.sh`

## Updating Dax

To update an existing installation:

```bash
# Remove old installation
rm -rf .dax

# Install new version
DAX_REF=new-commit ./install.sh
```

## Uninstallation

```bash
rm -rf .dax
```

## Source of Truth

The installer uses `dax/runtime/RUNTIME_LOCKFILE.json` as the authoritative list of runtime files. This file defines what gets installed and is separate from `docs/MANIFEST.json`, which provides raw URLs for external agents.

## Security Considerations

**Pinning is strongly recommended for production:**

```bash
# Inspect installer before running
curl -fsSL https://raw.githubusercontent.com/hilbertp/dax-agent/main/install.sh | less

# Pin to verified commit
DAX_REF=9f9cc6b ./install.sh
```

**Never install from untrusted sources or unverified commits.**

## Next Steps

After installation:

1. Run bootstrap to verify: `.dax/agent/bootstrap.sh`
2. Review authority documents in `.dax/docs/authority/`
3. Review control policies in `.dax/docs/control/`
4. Begin your first sprint following the Dax workflow
