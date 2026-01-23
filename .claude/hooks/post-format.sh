#!/bin/bash
# PostToolUse hook: 自动格式化修改的文件
FILE="$CLAUDE_FILE_PATH"

# 根据文件扩展名选择格式化工具
case "$FILE" in
    *.ts|*.tsx|*.js|*.jsx)
        command -v prettier >/dev/null 2>&1 && prettier --write "$FILE" 2>/dev/null
        ;;
    *.py)
        command -v black >/dev/null 2>&1 && black "$FILE" 2>/dev/null
        ;;
    *.go)
        command -v gofmt >/dev/null 2>&1 && gofmt -w "$FILE" 2>/dev/null
        ;;
esac
