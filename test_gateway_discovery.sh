#!/bin/sh
# test_gateway_discovery.sh - Minimal smoke test for Development Start Gateway discovery heuristics.
# Creates PRD and epics in arbitrary folders, a decoy, and exercises /upload fallback.

set -e

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
GATEWAY="$REPO_ROOT/agent/check_start_gateway.sh"

TMP_REPO="$(mktemp -d /tmp/dax_gateway_repo.XXXX)"
TMP_UPLOAD="$(mktemp -d /tmp/dax_gateway_upload.XXXX)"
trap 'rm -rf "$TMP_REPO" "$TMP_UPLOAD"' EXIT

# Scenario 1: Repo contains good PRD and epics in arbitrary folders, plus a decoy
mkdir -p "$TMP_REPO/docs" "$TMP_REPO/nested/prd" "$TMP_REPO/epic_area" "$TMP_REPO/decoy"
cat > "$TMP_REPO/nested/prd/product_requirements.txt" <<'EOF'
# Product Requirements
Problem: improve reliability
Constraints: budget, technical risk
Success criteria: latency under 200ms and error budget respected
EOF

cat > "$TMP_REPO/epic_area/roadmap.md" <<'EOF'
# Epics

1. Authentication hardening
2. Observability uplift
3. Performance tuning
EOF

cat > "$TMP_REPO/decoy/notes.md" <<'EOF'
Random notes about success but not a full PRD.
EOF

echo "--- Scenario 1: repo content ---"
echo "Repo fixture: $TMP_REPO"
find "$TMP_REPO" -maxdepth 4 -type f -print
TARGET_ROOT="$TMP_REPO" UPLOAD_FALLBACK="$TMP_UPLOAD" sh "$GATEWAY" || true

# Scenario 2: Remove repo artifacts, place candidates in /upload to exercise fallback
rm -rf "$TMP_REPO"/*
cat > "$TMP_UPLOAD/prd_upload.md" <<'EOF'
# PRD (upload)
Problem: data quality gaps
Constraints: budget, timeline
Success criteria: automated validation at 95% coverage
EOF

cat > "$TMP_UPLOAD/epics_upload.md" <<'EOF'
# Epics (upload)
1. Detect anomalies
2. Remediate bad records
3. Report coverage
EOF

echo "--- Scenario 2: /upload fallback ---"
echo "Upload fixture: $TMP_UPLOAD"
find "$TMP_UPLOAD" -maxdepth 2 -type f -print
TARGET_ROOT="$TMP_REPO" UPLOAD_FALLBACK="$TMP_UPLOAD" sh "$GATEWAY" || true

# Scenario 3: Diagnostic report should not dominate both PRD and Epics with high confidence
rm -rf "$TMP_REPO"/* "$TMP_UPLOAD"/*

mkdir -p "$TMP_REPO/reports" "$TMP_REPO/specs" "$TMP_REPO/backlog"
cat > "$TMP_REPO/reports/DIAGNOSTIC_REPORT.md" <<'EOF'
# Diagnostic Report
Product Requirements deep dive
Problem: reliability incidents
Constraints: budget and timeline pressures
Success criteria: availability 99.9% and latency < 200ms

Epics overview:
1. Epic 1: Authentication hardening
2. Epic 2: Observability uplift
3. Epic 3: Performance tuning
EOF

cat > "$TMP_REPO/specs/prd.md" <<'EOF'
# Product requirements
Problem: background sync is slow
Success criteria: sync completes under 30s
EOF

cat > "$TMP_REPO/backlog/epics.md" <<'EOF'
# Backlog
1. Authentication improvements
2. Observability improvements
3. Performance improvements
EOF

echo "--- Scenario 3: diagnostic report reuse ---"
echo "Repo fixture: $TMP_REPO"
find "$TMP_REPO" -maxdepth 3 -type f -print

OUTPUT=$(TARGET_ROOT="$TMP_REPO" UPLOAD_FALLBACK="$TMP_UPLOAD" sh "$GATEWAY" || true)
echo "$OUTPUT"

DIAG_PATH="$TMP_REPO/reports/DIAGNOSTIC_REPORT.md"
if printf '%s
' "$OUTPUT" | awk -v diag="$DIAG_PATH" '
/PRD: Found \(high confidence\)/{getline; if(index($0, diag)) prd=1}
/Epics: Found \(high confidence\)/{getline; if(index($0, diag)) epic=1}
END{exit (prd && epic ? 0 : 1)}
'; then
	echo "ERROR: Diagnostic report was selected as PRD and Epics with high confidence"
	exit 1
fi
