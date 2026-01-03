#!/bin/bash
set -e

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_SUFFIX=".backup.$(date +%Y%m%d%H%M%S)"

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}==>${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}==>${NC} $1"
}

# 备份函数
backup_if_needed() {
    local target=$1
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        local backup="$target$BACKUP_SUFFIX"
        log_warn "Backing up: $backup"
        mv "$target" "$backup"
    fi
}

# 创建 symlink 函数
symlink() {
    local source=$1
    local target=$2

    backup_if_needed "$target"
    log_info "Linking: $target -> $source"
    ln -sf "$source" "$target"
}

log_info "Installing dotfiles from: $DOTFILES_ROOT"

# Git
symlink "$DOTFILES_ROOT/git/.gitconfig" "$HOME/.gitconfig"
symlink "$DOTFILES_ROOT/git/.gitignore_global" "$HOME/.gitignore_global"

# VS Code
VSCODE_DIR="$HOME/Library/Application Support/Code/User"
if [ -d "$VSCODE_DIR" ]; then
    symlink "$DOTFILES_ROOT/vscode/settings.json" "$VSCODE_DIR/settings.json"
else
    log_warn "VS Code not installed, skipping..."
fi

# Karabiner (已存在配置，无需 symlink)
log_info "Karabiner: configuration in place, skipping..."

echo ""
log_info "Done! Run 'git config --list' to verify."
