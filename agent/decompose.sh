    #!/bin/bash

    # Configuration - specific to this repo's structure for now
    # In a real dynamic setup, these might be arguments or discovered
    PRD_PATH="01_documentation/02 - Dax - Product Requirements Document v1.md"
    EPIC_LIST_PATH="01_documentation/03 - Dax - Epic List v1.md"

    # 1. Argument Check
    if [ -z "$1" ]; then
        echo "Usage: $0 <epic_id>"
        echo "Example: $0 1"
        exit 1
    fi
    TARGET_ID="$1"

    echo "Dax Decomposition CLI initiated for Epic ID: $TARGET_ID"

    # 2. PRD Validation
    if [ ! -f "$PRD_PATH" ]; then
        echo "Warning: PRD file not found at: '$PRD_PATH'"
    else
        echo "✓ Found PRD: $PRD_PATH"
    fi

    # 3. Epic List Validation
    if [ ! -f "$EPIC_LIST_PATH" ]; then
        echo "Warning: Epic List file not found at: '$EPIC_LIST_PATH'"
    else
        echo "✓ Found Epic List: $EPIC_LIST_PATH"
        
        # 4. Extract Epic Name and Content
        # Matches "## Epic <ID>:" or "## Epic <ID>" case insensitive
        EPIC_HEADER=$(grep -i -m 1 "## Epic ${TARGET_ID}" "$EPIC_LIST_PATH")
        
        if [ -n "$EPIC_HEADER" ]; then
            echo "✓ Found Target: $EPIC_HEADER"
            
            # Extract PRD Content
            PRD_CONTENT=$(cat "$PRD_PATH")
            
            # Extract Epic Content
            # Uses awk to print from the found header until the next "## Epic" or end of file
            # We search for the specific header we found
            EPIC_CONTENT=$(awk -v header="$EPIC_HEADER" '
                $0 ~ header { flag=1; print; next }
                flag && /^## Epic/ { flag=0; exit }
                flag { print }
            ' "$EPIC_LIST_PATH")
            
            echo "---------------------------------------------------"
            
            # 5. Assemble and Pending Task
            PROMPT_TEMPLATE_PATH="dax/prompts/DECOMPOSITION_PROMPT.md"
            PENDING_TASK_PATH="dax/pending_task.md"

            if [ ! -f "$PROMPT_TEMPLATE_PATH" ]; then
                echo "Error: Prompt template not found at $PROMPT_TEMPLATE_PATH"
                exit 1
            fi

            PROMPT_TEMPLATE=$(cat "$PROMPT_TEMPLATE_PATH")

            # Create proper separation/headings for the context to ensure the LLM understands boundaries
            FULL_PROMPT="$PROMPT_TEMPLATE

    ---

    # CONTEXT: PRODUCT REQUIREMENTS DOCUMENT (PRD)
    $PRD_CONTENT

    ---

    # CONTEXT: TARGET EPIC
    $EPIC_CONTENT
    "
            
            echo "$FULL_PROMPT" > "$PENDING_TASK_PATH"
            echo "✓ Decomposition prompt assembled at: $PENDING_TASK_PATH"
            
            # 6. Artifact Persistence Setup (Story 5)
            OUTPUT_DIR="dax/epics"
            OUTPUT_FILE="${OUTPUT_DIR}/epic_${TARGET_ID}_decomposition.md"
            
            if [ ! -d "$OUTPUT_DIR" ]; then
                echo "Creating output directory: $OUTPUT_DIR"
                mkdir -p "$OUTPUT_DIR"
            fi
            
            echo ""
            echo "---------------------------------------------------"
            echo "INSTRUCTIONS:"
            echo "1. Read '$PENDING_TASK_PATH'"
            echo "2. Generate the decomposition"
            echo "3. Save the result to: $OUTPUT_FILE"
            echo "---------------------------------------------------"
            
        else
            echo "Warning: Epic $TARGET_ID not found in list."
            exit 1
        fi
    fi


