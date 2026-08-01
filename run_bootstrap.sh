#!/usr/bin/env bash
set -e

# Clone or update claude-code-settings and symlink into ~/.claude
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

# Linux-only tool installs
if [[ "$(uname)" == "Linux" ]]; then

  # NVM
  if [[ ! -d "$HOME/.nvm" ]]; then
    echo "installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  fi

  # gh CLI
  if ! command -v gh &>/dev/null; then
    echo "installing gh CLI..."
    sudo dnf install -y gh
  fi

  # fzf
  if ! command -v fzf &>/dev/null; then
    echo "installing fzf..."
    sudo dnf install -y fzf
  fi

  # lsof (needed by kill-p)
  if ! command -v lsof &>/dev/null; then
    echo "installing lsof..."
    sudo dnf install -y lsof
  fi

fi
