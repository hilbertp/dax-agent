#!/bin/sh
set -e

# agent/snapshot_authority.sh
# Automated fallback snapshot generator

# Note: Bootstrap MUST be run by the caller (workflow) before this script.
# This script assumes the environment is already bootstrapped and valid.

# 1. Validate authority files
REQUIRED_FILES="docs/authority/WORKFLOW_OVERVIEW.md docs/authority/DECOMPOSITION.md docs/authority/ACCEPTANCE_CRITERIA.md docs/authority/IDENTITY.md"

for f in $REQUIRED_FILES; do
    if [ ! -f "$f" ]; then
        echo "Error: Missing authority document $f"
        exit 1
    fi
done

# 2. Check Gate Status in Authority Documents
# Stakeholder Gate Checks
if grep -q "Stakeholder Review Gate: Amend" $REQUIRED_FILES; then
    echo "Stakeholder Gate marked Amend. No snapshot created."
    exit 0
fi

if grep -q "Stakeholder Review Gate: Reject" $REQUIRED_FILES; then
    echo "Stakeholder Gate marked Reject. No snapshot created."
    exit 0
fi

# Regression Gate Checks
if grep -q "Regression Gate: Failed" $REQUIRED_FILES; then
    echo "Regression Gate marked Failed. No snapshot created."
    exit 0
fi

# 3. Create Snapshot
TIMESTAMP=$(date -u +%Y-%m-%d-%H%M)
SNAPSHOT_DIR="docs/fallback/$TIMESTAMP"

mkdir -p "$SNAPSHOT_DIR"

for f in $REQUIRED_FILES; do
    cp "$f" "$SNAPSHOT_DIR/"
done

# Create FALLBACK.json
COMMIT_SHA=$(git rev-parse HEAD)
cat <<EOF > "$SNAPSHOT_DIR/FALLBACK.json"
{
  "source_commit": "$COMMIT_SHA",
  "timestamp": "$TIMESTAMP",
  "validation": "automated",
  "scope": "authority-docs-only"
}
EOF

echo "Snapshot created at $SNAPSHOT_DIR"

# 4. Commit
# Note: Git config is handled by the environment or workflow if needed,
# but setting it here ensures the commit works even if not globally set.
git config user.name "github-actions[bot]"
git config user.email "github-actions[bot]@users.noreply.github.com"

git add "$SNAPSHOT_DIR"
git commit -m "chore: automated authority snapshot $TIMESTAMP"
