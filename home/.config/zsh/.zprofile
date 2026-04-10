# Homebrew on macOS
if [[ -x "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

if [[ -n "${DOTFILES_DIR:-}" && -d "${DOTFILES_DIR}" && ":$PATH:" != *":${DOTFILES_DIR}:"* ]]; then
  export PATH="${DOTFILES_DIR}:$PATH"
fi

# Set editors
export EDITOR='vim'
export GIT_EDITOR='vim'

if [[ -d "/usr/local/bin" && ":$PATH:" != *":/usr/local/bin:"* ]]; then
  export PATH="$PATH:/usr/local/bin"
fi
