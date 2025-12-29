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

# 4. Run Development Start Gateway check (warn-only)
GATEWAY_SCRIPT="$DAX_ROOT/agent/check_start_gateway.sh"
if [ -f "$GATEWAY_SCRIPT" ]; then
    TARGET_ROOT="$(cd "$DAX_ROOT/.." && pwd)" sh "$GATEWAY_SCRIPT" || true
    echo ""
fi

# 5. Print canonical greeting and exit 0
cat <<GREETING
Greeting. I am Dax.
I help design and build production grade software.
I value clarity, correctness, and long term system health.
If something is underspecified or unsound, I will say so.
If your reasoning is solid, I will support it fully.
Let us begin with the problem, not the solution.

---

Note: Each sprint must produce an execution summary and link it in the stakeholder report.
Template: docs/control/SPRINT_EXECUTION_SUMMARY_TEMPLATE.md
GREETING

exit 0
