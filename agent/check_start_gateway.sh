#!/bin/sh
set -e

# check_start_gateway.sh - Development Start Gateway checker
# Warns if PRD and EPICS are missing or underspecified in the target repo.
# Exit code always 0 (warn-only, no blocking).

# Resolve TARGET_ROOT (where .dax was installed)
if [ -z "$TARGET_ROOT" ]; then
    # If running from inside .dax/agent/, resolve parent
    SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
    if [ -d "$SCRIPT_DIR/../../.." ]; then
        # We are in .dax/agent/, so go up three levels
        TARGET_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
    else
        # Fallback: assume current directory
        TARGET_ROOT="."
    fi
fi

# Ensure TARGET_ROOT is absolute
TARGET_ROOT="$(cd "$TARGET_ROOT" && pwd)"

# Files to check
PRD_FILE="$TARGET_ROOT/PRD.md"
EPICS_FILE="$TARGET_ROOT/EPICS.md"

# Status tracking
HAS_PRD=0
HAS_EPICS=0
PRD_OK=0
EPICS_OK=0

# Check if PRD exists and is adequately specified
if [ -f "$PRD_FILE" ]; then
    HAS_PRD=1
    
    # Lightweight heuristics: check for key sections
    if grep -qi "problem" "$PRD_FILE" && \
       grep -qi "constraint\|timeline\|budget\|tech\|technical" "$PRD_FILE" && \
       grep -qi "success\|criteria\|deliverable\|outcome" "$PRD_FILE"; then
        PRD_OK=1
    fi
fi

# Check if EPICS exists and is adequately specified
if [ -f "$EPICS_FILE" ]; then
    HAS_EPICS=1
    
    # Lightweight heuristics: check for numbered list with at least 3 items
    EPIC_COUNT=$(grep -c "^[0-9]\+\." "$EPICS_FILE" || echo 0)
    if [ "$EPIC_COUNT" -ge 3 ]; then
        EPICS_OK=1
    fi
fi

# Determine if we should warn
WARN=0

if [ $HAS_PRD -eq 0 ] || [ $HAS_EPICS -eq 0 ]; then
    WARN=1
elif [ $PRD_OK -eq 0 ] || [ $EPICS_OK -eq 0 ]; then
    WARN=1
fi

# Output
if [ $WARN -eq 1 ]; then
    echo ""
    echo "⚠ Development Start Gateway WARNING ⚠"
    echo ""
    
    if [ $HAS_PRD -eq 0 ]; then
        echo "  PRD.md: Not found"
    elif [ $PRD_OK -eq 0 ]; then
        echo "  PRD.md: Missing required sections (problem, constraints, success criteria)"
    fi
    
    if [ $HAS_EPICS -eq 0 ]; then
        echo "  EPICS.md: Not found"
    elif [ $EPICS_OK -eq 0 ]; then
        echo "  EPICS.md: Found but needs 3+ ranked epics"
    fi
    
    echo ""
    echo "  Create PRD.md and EPICS.md in repo root before expecting high-quality workflow guidance."
    echo "  Implementation agents may hallucinate requirements or introduce unexpected scope."
    echo ""
else
    echo "✓ Development Start Gateway: OK"
fi

exit 0
