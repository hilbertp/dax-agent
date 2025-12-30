#!/bin/sh
set -e

# check_start_gateway.sh - Development Start Gateway checker
# Warns if PRD and EPICS are missing or underspecified using content search.
# Exit code always 0 (warn-only, no blocking).

# -------------------------------
# Utility helpers
# -------------------------------
trim() {
    echo "$1" | sed 's/^ *//;s/ *$//'
}

dirname_safe() {
    # POSIX-safe dirname alternative
    echo "$1" | sed 's:[^/]*$::;s:/*$::'
}

# -------------------------------
# Resolve target repo root
# -------------------------------
if [ -n "$TARGET_ROOT" ]; then
    TARGET_REPO_ROOT="$(cd "$TARGET_ROOT" && pwd)"
else
    if command -v git >/dev/null 2>&1; then
        if git rev-parse --show-toplevel >/dev/null 2>&1; then
            TARGET_REPO_ROOT="$(git rev-parse --show-toplevel)"
        else
            TARGET_REPO_ROOT="$(pwd)"
        fi
    else
        TARGET_REPO_ROOT="$(pwd)"
    fi
fi

# Absolute paths
TARGET_REPO_ROOT="$(cd "$TARGET_REPO_ROOT" && pwd)"
UPLOAD_FALLBACK="${UPLOAD_FALLBACK:-/upload}"

# -------------------------------
# Candidate discovery
# -------------------------------
EXCLUDES="-name .git -o -name node_modules -o -name dist -o -name build -o -name vendor -o -name .dax"
MAX_SIZE="-1024k"

find_candidates() {
    BASE="$1"
    find "$BASE" \
        \( $EXCLUDES \) -prune -o \
        -type f \( -name "*.md" -o -name "*.txt" -o -name "*.rst" -o -name "*.adoc" \) \
        -size $MAX_SIZE -print 2>/dev/null
}

# Scoring functions
score_prd() {
    FILE="$1"
    score=0
    problem=0
    constraints=0
    success=0
    phrase=0

    if grep -qi "problem" "$FILE"; then
        problem=1
    fi
    if grep -qi "constraint\|timeline\|budget\|tech\|technical" "$FILE"; then
        constraints=1
    fi
    if grep -qi "success criteria\|success\|criteria\|deliverable\|outcome" "$FILE"; then
        success=1
    fi
    if grep -qi "product requirements\|prd" "$FILE"; then
        phrase=1
    fi

    score=$((problem + constraints + success + phrase))

    coverage=$((problem + constraints + success))
    if [ $score -ge 4 ] || [ $coverage -ge 3 ]; then
        confidence="high"
    elif [ $score -ge 2 ] && [ $coverage -ge 2 ]; then
        confidence="medium"
    elif [ $score -ge 1 ]; then
        confidence="low"
    else
        confidence="none"
    fi

    echo "$score|$confidence"
}

score_epics() {
    FILE="$1"
    score=0
    epics_word=0
    numbered=0
    epic_refs=0

    if grep -qi "epic" "$FILE"; then
        epics_word=1
    fi
    if grep -q "^[0-9][0-9]*\." "$FILE"; then
        count=$(grep -c "^[0-9][0-9]*\." "$FILE" || echo 0)
        if [ "$count" -ge 3 ]; then
            numbered=2
        elif [ "$count" -ge 1 ]; then
            numbered=1
        fi
    fi
    if grep -qi "epic \\|epic:" "$FILE"; then
        epic_refs=1
    fi

    score=$((epics_word + numbered + epic_refs))

    if [ $score -ge 3 ] && [ $numbered -ge 2 ] && [ $epics_word -ge 1 ]; then
        confidence="high"
    elif [ $score -ge 2 ]; then
        confidence="medium"
    elif [ $score -ge 1 ]; then
        confidence="low"
    else
        confidence="none"
    fi

    echo "$score|$confidence"
}

lower_conf() {
    case "$1" in
        high) echo "medium";;
        medium) echo "low";;
        low) echo "low";;
        *) echo "$1";;
    esac
}

append_reason() {
    base="$1"
    note="$2"
    if [ -z "$base" ]; then
        echo "$note"
    else
        echo "$base; $note"
    fi
}

collect_candidates() {
    BASE="$1"
    TYPE="$2" # prd | epics

    TMP_FILE="$3"

    find_candidates "$BASE" | while IFS= read -r file; do
        [ -f "$file" ] || continue

        if [ "$TYPE" = "prd" ]; then
            result=$(score_prd "$file")
        else
            result=$(score_epics "$file")
        fi
        score="$(echo "$result" | cut -d'|' -f1)"
        conf="$(echo "$result" | cut -d'|' -f2)"
        if [ "$score" -gt 0 ]; then
            echo "$score|$conf|$file" >> "$TMP_FILE"
        fi
    done
}

select_best() {
    TMP_FILE="$1"
    MIN_THRESHOLD="$2"

    if [ ! -s "$TMP_FILE" ]; then
        echo "missing|||"
        return
    fi

    best_line=$(sort -t'|' -k1,1nr "$TMP_FILE" | head -1)
    best_score="$(echo "$best_line" | cut -d'|' -f1)"
    best_conf="$(echo "$best_line" | cut -d'|' -f2)"
    best_path="$(echo "$best_line" | cut -d'|' -f3- | sed 's/^ *//')"

    if [ "$best_score" -ge "$MIN_THRESHOLD" ]; then
        status="found"
    else
        status="missing"
    fi

    # Top three for reporting (flattened to one line)
    top_three=$(sort -t'|' -k1,1nr "$TMP_FILE" | head -3 | cut -d'|' -f3- | tr '\n' '; ' | sed 's/; $//')

    echo "$status|$best_conf|$best_path|$top_three"
}

# -------------------------------
# Search repository first
# -------------------------------
PRD_TMP=$(mktemp)
EPICS_TMP=$(mktemp)

collect_candidates "$TARGET_REPO_ROOT" "prd" "$PRD_TMP"
collect_candidates "$TARGET_REPO_ROOT" "epics" "$EPICS_TMP"

PRD_SELECTION=$(select_best "$PRD_TMP" 2)
EPICS_SELECTION=$(select_best "$EPICS_TMP" 2)

rm -f "$PRD_TMP" "$EPICS_TMP"

PRD_STATUS=$(echo "$PRD_SELECTION" | cut -d'|' -f1)
PRD_CONF=$(echo "$PRD_SELECTION" | cut -d'|' -f2)
PRD_PATH=$(echo "$PRD_SELECTION" | cut -d'|' -f3)
PRD_ALT=$(echo "$PRD_SELECTION" | cut -d'|' -f4-)
PRD_REASON=""

EPICS_STATUS=$(echo "$EPICS_SELECTION" | cut -d'|' -f1)
EPICS_CONF=$(echo "$EPICS_SELECTION" | cut -d'|' -f2)
EPICS_PATH=$(echo "$EPICS_SELECTION" | cut -d'|' -f3)
EPICS_ALT=$(echo "$EPICS_SELECTION" | cut -d'|' -f4-)
EPICS_REASON=""

# Default statuses if parsing fails
[ -z "$PRD_STATUS" ] && PRD_STATUS="missing"
[ -z "$EPICS_STATUS" ] && EPICS_STATUS="missing"

# -------------------------------
# Confidence dampening and distinct evidence
# -------------------------------
same_file=0
if [ "$PRD_STATUS" = "found" ] && [ "$EPICS_STATUS" = "found" ] && [ -n "$PRD_PATH" ] && [ "$PRD_PATH" = "$EPICS_PATH" ]; then
    same_file=1
    PRD_CONF=$(lower_conf "$PRD_CONF")
    EPICS_CONF=$(lower_conf "$EPICS_CONF")
    PRD_REASON=$(append_reason "$PRD_REASON" "Same file selected for PRD and Epics; confidence reduced")
    EPICS_REASON=$(append_reason "$EPICS_REASON" "Same file selected for PRD and Epics; confidence reduced")
fi

# Dampening based on path semantics (conservative)
dampen_if_generic() {
    CONF="$1"
    PATH_VAL="$2"
    ROLE="$3" # prd|epics
    REASON_IN="$4"

    # Generic terms that often indicate summaries/diagnostics rather than planning
    if echo "$PATH_VAL" | grep -Eiq "report|summary|diagnostic|log|notes|readme"; then
        CONF=$(lower_conf "$CONF")
        REASON_IN=$(append_reason "$REASON_IN" "Path looks like a report/summary; confidence reduced")
    fi

    if [ "$ROLE" = "prd" ]; then
        if ! echo "$PATH_VAL" | grep -Eiq "prd|requirement|spec|plan"; then
            CONF=$(lower_conf "$CONF")
            REASON_IN=$(append_reason "$REASON_IN" "Path does not suggest requirements/plan; confidence reduced")
        fi
    else
        if ! echo "$PATH_VAL" | grep -Eiq "epic|roadmap|plan|backlog"; then
            CONF=$(lower_conf "$CONF")
            REASON_IN=$(append_reason "$REASON_IN" "Path does not suggest epics/roadmap; confidence reduced")
        fi
    fi

    echo "$CONF|$REASON_IN"
}

if [ "$PRD_STATUS" = "found" ]; then
    result=$(dampen_if_generic "$PRD_CONF" "$PRD_PATH" "prd" "$PRD_REASON")
    PRD_CONF=$(echo "$result" | cut -d'|' -f1)
    PRD_REASON=$(echo "$result" | cut -d'|' -f2-)
fi

if [ "$EPICS_STATUS" = "found" ]; then
    result=$(dampen_if_generic "$EPICS_CONF" "$EPICS_PATH" "epics" "$EPICS_REASON")
    EPICS_CONF=$(echo "$result" | cut -d'|' -f1)
    EPICS_REASON=$(echo "$result" | cut -d'|' -f2-)
fi

# -------------------------------
# Fallback to /upload if missing in repo
# -------------------------------
USED_UPLOAD=0
if [ "$PRD_STATUS" != "found" ] || [ "$EPICS_STATUS" != "found" ]; then
    if [ -d "$UPLOAD_FALLBACK" ]; then
        PRD_TMP=$(mktemp)
        EPICS_TMP=$(mktemp)
        collect_candidates "$UPLOAD_FALLBACK" "prd" "$PRD_TMP"
        collect_candidates "$UPLOAD_FALLBACK" "epics" "$EPICS_TMP"
        PRD_UPLOAD=$(select_best "$PRD_TMP" 2)
        EPICS_UPLOAD=$(select_best "$EPICS_TMP" 2)
        rm -f "$PRD_TMP" "$EPICS_TMP"

        if [ "$PRD_STATUS" != "found" ]; then
            up_status=$(echo "$PRD_UPLOAD" | cut -d'|' -f1)
            if [ "$up_status" = "found" ]; then
                USED_UPLOAD=1
                PRD_STATUS="upload"
                PRD_CONF=$(echo "$PRD_UPLOAD" | cut -d'|' -f2)
                PRD_PATH=$(echo "$PRD_UPLOAD" | cut -d'|' -f3)
                PRD_ALT=$(echo "$PRD_UPLOAD" | cut -d'|' -f4-)
            fi
        fi

        if [ "$EPICS_STATUS" != "found" ]; then
            up_status=$(echo "$EPICS_UPLOAD" | cut -d'|' -f1)
            if [ "$up_status" = "found" ]; then
                USED_UPLOAD=1
                EPICS_STATUS="upload"
                EPICS_CONF=$(echo "$EPICS_UPLOAD" | cut -d'|' -f2)
                EPICS_PATH=$(echo "$EPICS_UPLOAD" | cut -d'|' -f3)
                EPICS_ALT=$(echo "$EPICS_UPLOAD" | cut -d'|' -f4-)
            fi
        fi
    fi
fi

# -------------------------------
# Output decisions
# -------------------------------
print_candidates() {
    LABEL="$1"
    STATUS="$2"
    CONF="$3"
    PATH_MAIN="$4"
    ALT_LIST="$5"
    REASON="$6"

    case "$STATUS" in
        found)
            echo "  $LABEL: Found ($CONF confidence)"
            echo "    Path: $PATH_MAIN"
            if [ "$CONF" = "medium" ]; then
                echo "    Other candidates:"
                echo "$ALT_LIST" | sed 's/^/      - /'
            fi
            if [ -n "$REASON" ]; then
                echo "    Note: $REASON"
            fi
            ;;
        upload)
            echo "  $LABEL: Found in /upload ($CONF confidence)"
            echo "    Path: $PATH_MAIN"
            echo "    Note: /upload is session-scoped. Copy into the repository for persistence."
            ;;
        missing)
            echo "  $LABEL: Not found"
            ;;
    esac
}

overall_status="OK"

if [ "$PRD_STATUS" = "found" ] && [ "$EPICS_STATUS" = "found" ] && [ "$PRD_CONF" = "high" ] && [ "$EPICS_CONF" = "high" ]; then
    echo "✓ Development Start Gateway: OK"
else
    overall_status="WARN"
    echo "⚠ Development Start Gateway WARNING ⚠"
fi

print_candidates "PRD" "$PRD_STATUS" "$PRD_CONF" "$PRD_PATH" "$PRD_ALT" "$PRD_REASON"
print_candidates "Epics" "$EPICS_STATUS" "$EPICS_CONF" "$EPICS_PATH" "$EPICS_ALT" "$EPICS_REASON"

if [ "$overall_status" = "WARN" ]; then
    echo ""
    if [ "$PRD_STATUS" = "missing" ]; then
        echo "  Provide a Product Requirements Description (problem, constraints, success criteria)."
    elif [ "$PRD_CONF" = "low" ]; then
        echo "  PRD candidate confidence is low; confirm or provide a clearer PRD."
    fi

    if [ "$EPICS_STATUS" = "missing" ]; then
        echo "  Provide a ranked epic list with 3+ numbered epics."
    elif [ "$EPICS_CONF" = "low" ]; then
        echo "  Epic list confidence is low; confirm ordering and numbering."
    fi

    if [ $USED_UPLOAD -eq 1 ]; then
        echo "  Documents found in /upload are session-scoped; copy them into the repository for persistence."
    fi
fi

exit 0
