#!/bin/bash
# PreToolUse hook: 阻断危险命令
COMMAND="$CLAUDE_CMD"

# 危险命令列表
DANGER_CMDS="rm -rf|rm -fr|:.*:.*:.*>|dd if=|mkfs.|> /dev/"

if echo "$COMMAND" | grep -qE "$DANGER_CMDS"; then
    echo "❌ BLOCKED: Dangerous command detected: $COMMAND"
    echo "Please use a safer alternative or confirm explicitly."
    exit 1
fi
