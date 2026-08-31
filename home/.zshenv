# config
export ZDOTDIR="$HOME/.config/zsh"

export HOMEBREW_BUNDLE_FILE="$HOME/Brewfile"

export EDITOR="zed --wait"
export VISUAL="$EDITOR"
export GIT_EDITOR="$EDITOR"

# Repair zsh's function search path when a stale FPATH is inherited.
typeset -gaU fpath
if [[ -d "/opt/homebrew/share/zsh/functions" ]]; then
  fpath=(/opt/homebrew/share/zsh/functions /opt/homebrew/share/zsh/site-functions $fpath)
fi
if [[ -d "/usr/local/share/zsh/functions" ]]; then
  fpath=(/usr/local/share/zsh/functions /usr/local/share/zsh/site-functions $fpath)
fi
fpath=(${^fpath}(N-/))
export FPATH="${(j/:/)fpath}"

# Load shared PATH setup for every zsh shell.
if [[ -f "$ZDOTDIR/path.zsh" ]]; then
  source "$ZDOTDIR/path.zsh"
fi
