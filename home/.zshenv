# config
export ZDOTDIR="$HOME/.config/zsh"

if [[ -z "${DOTFILES_DIR:-}" && -L "$HOME/.zshenv" ]]; then
  _dotfiles_zshenv="$(readlink "$HOME/.zshenv")"
  if [[ "${_dotfiles_zshenv}" != /* ]]; then
    _dotfiles_zshenv="$HOME/${_dotfiles_zshenv}"
  fi
  export DOTFILES_DIR="$(cd "$(dirname "${_dotfiles_zshenv}")/.." && pwd)"
  unset _dotfiles_zshenv
fi

export HOMEBREW_BUNDLE_FILE="$HOME/Brewfile"

# Load shared PATH setup for every zsh shell.
if [[ -f "$ZDOTDIR/path.zsh" ]]; then
  source "$ZDOTDIR/path.zsh"
fi
