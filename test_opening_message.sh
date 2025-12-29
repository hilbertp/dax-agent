#!/bin/sh
# test_opening_message.sh - Verify opening message is printed verbatim from canonical file
# Exit 0 if message matches exactly, 1 if not

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DAX_ROOT="$(cd "$SCRIPT_DIR" && pwd)"
CANONICAL_FILE="$DAX_ROOT/docs/prompts/OPENING_MESSAGE.md"

if [ ! -f "$CANONICAL_FILE" ]; then
    echo "✗ Canonical file not found: $CANONICAL_FILE"
    exit 1
fi

# Capture bootstrap output, extract opening message (everything before any gateway warning)
BOOTSTRAP_OUTPUT="$($DAX_ROOT/agent/bootstrap.sh 2>&1)"

# Extract just the opening message (stop at "⚠" if present, otherwise whole output)
OPENING_MESSAGE=$(echo "$BOOTSTRAP_OUTPUT" | sed '/^⚠/,$d')

# Read canonical file
CANONICAL_MESSAGE=$(cat "$CANONICAL_FILE")

# Compare byte-for-byte
if [ "$OPENING_MESSAGE" = "$CANONICAL_MESSAGE" ]; then
    echo "✓ Opening message matches canonical file exactly"
    
    # Also verify gateway warning appears after if file missing
    if echo "$BOOTSTRAP_OUTPUT" | grep -q "⚠ Development Start Gateway WARNING"; then
        echo "✓ Gateway warning appears after opening message"
    fi
    exit 0
else
    echo "✗ Opening message does not match canonical file"
    echo ""
    echo "=== Expected (canonical) ==="
    cat "$CANONICAL_FILE" | head -20
    echo ""
    echo "=== Got (bootstrap output) ==="
    echo "$OPENING_MESSAGE" | head -20
    exit 1
fi
