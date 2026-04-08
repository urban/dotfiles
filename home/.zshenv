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
# uv
export PATH="$HOME/.local/bin:$PATH"
# bun
export PATH="$HOME/.bun/bin:$PATH"
