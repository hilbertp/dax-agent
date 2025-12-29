# Bootstrap Relocatable Design

## Overview

The Dax bootstrap script (`agent/bootstrap.sh`) has been redesigned to be **relocatable**, meaning it can be invoked from any working directory and will correctly locate all runtime files.

## What "Relocatable" Means

A relocatable bootstrap:
- Does not depend on the current working directory (`pwd`)
- Does not assume a specific repo name or location
- Resolves its own location at runtime
- Computes the Dax root directory (`DAX_ROOT`) dynamically
- Uses absolute paths for all runtime file verification

## Assumptions Removed

**Before (fragile):**
```bash
check_file "docs/MANIFEST.json"  # Assumes pwd is repo root
```

**After (robust):**
```bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DAX_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
check_file "$DAX_ROOT/docs/MANIFEST.json"  # Works from anywhere
```

### Specific Changes

1. **Dynamic DAX_ROOT derivation:**
   - Script resolves its own directory: `SCRIPT_DIR`
   - Computes repo root as parent of agent directory: `DAX_ROOT=$SCRIPT_DIR/..`

2. **Absolute path verification:**
   - `check_file()` now takes relative paths and constructs absolute paths
   - Error messages show full absolute paths for clarity

3. **No pwd dependency:**
   - Bootstrap succeeds regardless of invocation directory
   - All file checks use `$DAX_ROOT`-relative paths

## How DAX_ROOT is Derived

```
Directory structure:
  dax-agent/
  ├── agent/
  │   └── bootstrap.sh    ← invoked from here
  ├── docs/
  │   ├── authority/
  │   └── control/
  └── ...

Derivation:
  1. dirname "$0"          → ../agent (relative to script)
  2. cd + pwd              → /absolute/path/to/dax-agent/agent
  3. cd .. + pwd           → /absolute/path/to/dax-agent (DAX_ROOT)
```

## Example Invocations

### From repo root
```bash
cd /path/to/dax-agent
./agent/bootstrap.sh
# Works: finds docs/MANIFEST.json, etc.
```

### From any directory (key benefit)
```bash
cd /tmp
/path/to/dax-agent/agent/bootstrap.sh
# Works: still finds docs/MANIFEST.json via DAX_ROOT resolution
```

### Symlinked or copied bootstrap
```bash
ln -s /path/to/dax-agent/agent/bootstrap.sh /usr/local/bin/dax-bootstrap
dax-bootstrap
# Works: resolves DAX_ROOT from symlink target
```

## Runtime Verification

The bootstrap verifies all files in the runtime definition:
- `docs/MANIFEST.json`
- `docs/authority/WORKFLOW_OVERVIEW.md`
- `docs/authority/DECOMPOSITION.md`
- `docs/authority/ACCEPTANCE_CRITERIA.md`
- `docs/authority/IDENTITY.md`

Failure to locate any file exits with status 1. Success outputs the canonical Dax greeting and exits 0.

## Testing Relocatability

```bash
# Test from different working directory
cd /tmp
/path/to/dax-agent/agent/bootstrap.sh

# Should output greeting and exit 0
# If any file is missing, shows absolute path in error
```

## Backwards Compatibility

- Same input files verified (unchanged from runtime definition)
- Same output format (canonical greeting)
- Same exit codes (0 = success, 1 = missing files)
- Behavior is identical; only invocation location changed
