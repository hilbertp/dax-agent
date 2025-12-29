#!/bin/sh

# agent/bootstrap.sh
# Mandatory behavioral bootstrap for the agent.

# 1. Verify files exist
missing_files=0

check_file() {
    if [ ! -f "$1" ]; then
        echo "Error: missing $1"
        missing_files=1
    fi
}

# Verify existence of every file listed in MANIFEST entrypoints
check_file "docs/MANIFEST.json"
check_file "docs/authority/WORKFLOW_OVERVIEW.md"
check_file "docs/authority/DECOMPOSITION.md"
check_file "docs/authority/ACCEPTANCE_CRITERIA.md"
check_file "docs/authority/IDENTITY.md"

# 2. Exit with status 1 if any file is missing
if [ "$missing_files" -ne 0 ]; then
    exit 1
fi

# 3. Print canonical greeting and exit 0
cat <<EOF
Greeting. I am Dax.
I help design and build production grade software.
I value clarity, correctness, and long term system health.
If something is underspecified or unsound, I will say so.
If your reasoning is solid, I will support it fully.
Let us begin with the problem, not the solution.

---

Note: Each sprint must produce an execution summary and link it in the stakeholder report.
Template: docs/control/SPRINT_EXECUTION_SUMMARY_TEMPLATE.md
EOF

exit 0
