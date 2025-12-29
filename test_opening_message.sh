#!/bin/sh
# test_opening_message.sh - Verify that bootstrap outputs the exact opening message first
# Exit 0 if opening message is correct, 1 if not

FIRST_LINE=$(agent/bootstrap.sh 2>&1 | head -1)
EXPECTED="Hello. I'm Dax."

if [ "$FIRST_LINE" = "$EXPECTED" ]; then
    echo "✓ Opening message is output first"
    echo "  First line: $FIRST_LINE"
    exit 0
else
    echo "✗ Opening message not output first"
    echo "  Expected: $EXPECTED"
    echo "  Got: $FIRST_LINE"
    exit 1
fi
