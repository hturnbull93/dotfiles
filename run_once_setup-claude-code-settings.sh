#!/usr/bin/env bash
set -e

REPO="https://github.com/hturnbull93/claude-code-settings"
TARGET="$HOME/claude-code-settings"

if [[ ! -d "$TARGET/.git" ]]; then
  git clone "$REPO" "$TARGET"
else
  git -C "$TARGET" pull
fi

mkdir -p "$HOME/.claude"

ln -sf "$TARGET/settings.json" "$HOME/.claude/settings.json"
ln -sf "$TARGET/statusline-command.sh" "$HOME/.claude/statusline-command.sh"

echo "claude-code-settings: symlinks created"
