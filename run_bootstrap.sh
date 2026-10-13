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

# mise (replaces nvm; tool versions in ~/.config/mise/config.toml)
if ! command -v mise &>/dev/null && [[ ! -x "$HOME/.local/bin/mise" ]]; then
  echo "installing mise..."
  if [[ "$(uname)" == "Darwin" ]]; then
    brew install mise
  else
    curl -fsSL https://mise.run | sh
  fi
fi
MISE="$(command -v mise || echo "$HOME/.local/bin/mise")"
"$MISE" install --yes

# Linux-only tool installs
if [[ "$(uname)" == "Linux" ]]; then

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
