#!/bin/sh

# agent/ensure_execution_summary.sh
# Warn-only check for mandatory sprint execution summary.
# Accepts sprint ID or infers from current branch.

set -e

# Default to inferring from branch if not provided
SPRINT_ID="${1:$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo 'unknown')}"

# Check if summary exists
SUMMARY_PATH="docs/sprints/${SPRINT_ID}/EXECUTION_SUMMARY.md"

if [ -f "$SUMMARY_PATH" ]; then
    echo "✓ OK: Sprint execution summary found at $SUMMARY_PATH"
    exit 0
else
    echo "⚠ WARNING: Sprint execution summary not found at $SUMMARY_PATH"
    echo "Each sprint must produce an execution summary before stakeholder approval."
    echo "Template: docs/control/SPRINT_EXECUTION_SUMMARY_TEMPLATE.md"
    exit 0
fi
