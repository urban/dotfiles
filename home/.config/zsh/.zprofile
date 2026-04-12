# Homebrew on macOS
if [[ -x "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Set editors
export EDITOR='vim'
export GIT_EDITOR='vim'
export PATH="/Volumes/Code/personal/ralph:$PATH"
