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
check_file "docs/agent/WORKFLOW_OVERVIEW.md"
check_file "docs/agent/DECOMPOSITION.md"
check_file "docs/agent/ACCEPTANCE_CRITERIA.md"
check_file "docs/agent/IDENTITY.md"

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
EOF

exit 0
