#!/bin/sh

# agent/bootstrap.sh
# Mandatory behavioral bootstrap for the agent.
# Relocatable: works from any invocation directory.

# 1. Determine DAX_ROOT by resolving this script's location
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DAX_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# 2. Verify files exist (using absolute paths derived from DAX_ROOT)
missing_files=0

check_file() {
    local rel_path="$1"
    local abs_path="$DAX_ROOT/$rel_path"
    if [ ! -f "$abs_path" ]; then
        echo "Error: missing $abs_path"
        missing_files=1
    fi
}

# Verify existence of every file listed in runtime definition
check_file "docs/MANIFEST.json"
check_file "docs/authority/WORKFLOW_OVERVIEW.md"
check_file "docs/authority/DECOMPOSITION.md"
check_file "docs/authority/ACCEPTANCE_CRITERIA.md"
check_file "docs/authority/IDENTITY.md"

# 3. Exit with status 1 if any file is missing
if [ "$missing_files" -ne 0 ]; then
    exit 1
fi

# 4. Print canonical opening message FIRST (read from file, do not modify)
OPENING_MESSAGE_FILE="$DAX_ROOT/docs/prompts/OPENING_MESSAGE.md"
if [ -f "$OPENING_MESSAGE_FILE" ]; then
    cat "$OPENING_MESSAGE_FILE"
else
    echo "Error: Opening message file not found: $OPENING_MESSAGE_FILE"
    exit 1
fi

# 5. Run Development Start Gateway check AFTER opening message (warn-only, visible)
echo ""
GATEWAY_SCRIPT="$DAX_ROOT/agent/check_start_gateway.sh"
if [ -f "$GATEWAY_SCRIPT" ]; then
    TARGET_ROOT="$(cd "$DAX_ROOT/.." && pwd)" sh "$GATEWAY_SCRIPT" || true
fi

exit 0
