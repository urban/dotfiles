# config
export ZDOTDIR="$HOME/.config/zsh"

export HOMEBREW_BUNDLE_FILE="$HOME/Brewfile"

# Load shared PATH setup for every zsh shell.
if [[ -f "$ZDOTDIR/path.zsh" ]]; then
  source "$ZDOTDIR/path.zsh"
fi
