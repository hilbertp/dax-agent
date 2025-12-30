#!/bin/sh
set -eu

# install.sh - Minimal Dax runtime installer
# Installs Dax runtime files into target repository

# Configuration
REPO="hilbertp/dax-agent"
DAX_REF="${DAX_REF:-main}"
BASE_URL="https://raw.githubusercontent.com/${REPO}/${DAX_REF}"
INSTALL_DIR=".dax"

# Runtime files to install (from dax/runtime/RUNTIME_LOCKFILE.json)
# This list must be kept in sync with RUNTIME_LOCKFILE.json
RUNTIME_FILES="
agent/bootstrap.sh
agent/check_start_gateway.sh
docs/MANIFEST.json
docs/authority/WORKFLOW_OVERVIEW.md
docs/authority/DECOMPOSITION.md
docs/authority/ACCEPTANCE_CRITERIA.md
docs/authority/IDENTITY.md
docs/control/STAKEHOLDER_SPRINT_OUTPUT.md
docs/control/SPRINT_EXECUTION_SUMMARY_TEMPLATE.md
docs/control/DEVELOPMENT_START_GATEWAY.md
agent/snapshot_authority.sh
agent/ensure_execution_summary.sh
"

# Detect if running inside dax-agent repo itself
if [ -f "dax/runtime/RUNTIME_DEFINITION.json" ] && [ -f "dax/runtime/RUNTIME_LOCKFILE.json" ]; then
    echo "Error: Detected dax-agent repository. This script installs Dax into OTHER repositories."
    echo "You are already in the Dax source repository. No installation needed here."
    exit 1
fi

# Determine target directory
TARGET_DIR="${1:-.}"
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"

echo "=== Dax Runtime Installer ==="
echo "Target directory: $TARGET_DIR"
echo "Install location: $TARGET_DIR/$INSTALL_DIR"
echo "Dax reference: $DAX_REF"
echo ""

# Verify curl or wget available
if command -v curl >/dev/null 2>&1; then
    FETCH="curl -fsSL"
elif command -v wget >/dev/null 2>&1; then
    FETCH="wget -qO-"
else
    echo "Error: Neither curl nor wget found. Please install one of them."
    exit 1
fi

# Create install directory structure
echo "Creating directory structure..."
mkdir -p "$TARGET_DIR/$INSTALL_DIR/agent"
mkdir -p "$TARGET_DIR/$INSTALL_DIR/docs/authority"
mkdir -p "$TARGET_DIR/$INSTALL_DIR/docs/control"

# Install runtime files
echo "Installing runtime files..."
installed_count=0
for file in $RUNTIME_FILES; do
    file_trimmed="$(echo "$file" | xargs)"  # Trim whitespace
    [ -z "$file_trimmed" ] && continue
    
    target_path="$TARGET_DIR/$INSTALL_DIR/$file_trimmed"
    source_url="$BASE_URL/$file_trimmed"
    
    echo "  - $file_trimmed"
    
    if ! $FETCH "$source_url" > "$target_path"; then
        echo "Error: Failed to fetch $source_url"
        exit 1
    fi
    
    installed_count=$((installed_count + 1))
done

echo ""
echo "Installed $installed_count files."

# Set executable permissions on shell scripts
echo ""
echo "Setting executable permissions..."
chmod +x "$TARGET_DIR/$INSTALL_DIR/agent/bootstrap.sh"
chmod +x "$TARGET_DIR/$INSTALL_DIR/agent/snapshot_authority.sh"
chmod +x "$TARGET_DIR/$INSTALL_DIR/agent/ensure_execution_summary.sh"
chmod +x "$TARGET_DIR/$INSTALL_DIR/agent/check_start_gateway.sh"

# Verify installation
echo ""
echo "=== Verification ==="

# Check all files exist
missing_files=0
for file in $RUNTIME_FILES; do
    file_trimmed="$(echo "$file" | xargs)"
    [ -z "$file_trimmed" ] && continue
    
    if [ ! -f "$TARGET_DIR/$INSTALL_DIR/$file_trimmed" ]; then
        echo "✗ Missing: $file_trimmed"
        missing_files=$((missing_files + 1))
    fi
done

if [ "$missing_files" -gt 0 ]; then
    echo "Error: $missing_files file(s) missing after install"
    exit 1
fi
echo "✓ All $installed_count runtime files present"

# Verify shell scripts are executable
if [ ! -x "$TARGET_DIR/$INSTALL_DIR/agent/bootstrap.sh" ]; then
    echo "✗ bootstrap.sh not executable"
    exit 1
fi
echo "✓ Shell scripts are executable"

# Test bootstrap relocatability
echo ""
echo "Testing bootstrap from different working directory..."
cd /tmp
if ! "$TARGET_DIR/$INSTALL_DIR/agent/bootstrap.sh" >/dev/null 2>&1; then
    echo "✗ Bootstrap test failed"
    exit 1
fi
echo "✓ Bootstrap test passed"

# Success summary
echo ""
echo "=== Installation Complete ==="
echo ""
echo "Dax runtime installed to: $TARGET_DIR/$INSTALL_DIR"
echo "Reference: $DAX_REF"
echo "Runtime files: $installed_count"
echo ""
echo "Next: Run bootstrap to see the opening message and learn what to provide."
echo "  $TARGET_DIR/$INSTALL_DIR/agent/bootstrap.sh"
