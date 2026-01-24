# Homebrew on macOS
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set editors
export EDITOR='vim'
export GIT_EDITOR='vim'

# Amend path
export PATH=/usr/local/bin:$PATH