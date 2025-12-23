#!/bin/sh
set -e

# agent/snapshot_authority.sh
# Automated fallback snapshot generator

# 1. Run bootstrap
if ! ./agent/bootstrap.sh; then
    echo "Bootstrap failed. Aborting."
    exit 1
fi

# 2. Validate authority files
REQUIRED_FILES="docs/agent/WORKFLOW_OVERVIEW.md docs/agent/DECOMPOSITION.md docs/agent/ACCEPTANCE_CRITERIA.md docs/agent/IDENTITY.md"

for f in $REQUIRED_FILES; do
    if [ ! -f "$f" ]; then
        echo "Error: Missing authority document $f"
        exit 1
    fi
done

# 3. Check Gate Status
# Checks for explicit failure markers if a GATES.md exists.
GATE_FILE="docs/GATES.md"
if [ -f "$GATE_FILE" ]; then
    if grep -Eq "Regression Gate:.*(Failed|Pending)" "$GATE_FILE"; then
        echo "Aborting: Regression gate marked failed or pending."
        exit 1
    fi
    if grep -Eq "Stakeholder Review Gate:.*(Amend|Reject)" "$GATE_FILE"; then
        echo "Aborting: Stakeholder gate marked Amend or Reject."
        exit 1
    fi
fi

# 4. Create Snapshot
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

# 5. Commit
# Configure git if needed (CI environment usually needs this)
# We assume the caller (GitHub Action) has set up auth, but we need to configure identity if not present.
if [ -z "$(git config user.name)" ]; then
    git config user.name "github-actions[bot]"
    git config user.email "github-actions[bot]@users.noreply.github.com"
fi

git add "$SNAPSHOT_DIR"
git commit -m "chore: automated authority snapshot $TIMESTAMP"
# Push is handled by the caller or explicit push command
# The prompt says "Commit the snapshot automatically", implying the action does it. 
# We'll leave the push to the workflow to handle authentication securely if needed, 
# or do `git push` here if we assume the token is in the remote URL.
# Typically actions use `ad-m/github-push-action` or `git push` with GITHUB_TOKEN.
