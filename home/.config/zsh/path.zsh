# Shared PATH setup loaded from ~/.zshenv so new zsh sessions pick it up
# whether the terminal starts a login shell or not.

typeset -U path PATH

path_prepend() {
  local dir
  for dir in "$@"; do
    [[ -d "$dir" ]] && path=("$dir" $path)
  done
}

path_append() {
  local dir
  for dir in "$@"; do
    [[ -d "$dir" ]] && path=($path "$dir")
  done
}

# User-installed tools.
path_prepend "$HOME/.local/bin"
path_prepend "$HOME/.bun/bin"

# Homebrew.
if [[ -d "/opt/homebrew/bin" ]]; then
  path_prepend "/opt/homebrew/sbin"
  path_prepend "/opt/homebrew/bin"
elif [[ -d "/usr/local/bin" ]]; then
  path_prepend "/usr/local/sbin"
  path_prepend "/usr/local/bin"
fi

# Repo commands when the dotfiles are stowed into $HOME.
if [[ -n "${DOTFILES_DIR:-}" && -d "${DOTFILES_DIR}" ]]; then
  path_prepend "${DOTFILES_DIR}"
fi

# Some tools still install here on macOS.
path_prepend "/usr/local/sbin"
path_append "/usr/local/bin"

export PATH
unset -f path_prepend path_append
