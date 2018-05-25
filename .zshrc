source /usr/local/share/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git

export NVM_AUTO_USE=true
antigen bundle lukechilds/zsh-nvm

antigen bundle ssh-agent

antigen bundle tmux

antigen bundle yarn

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme https://github.com/denysdovhan/spaceship-prompt spaceship

# Tell Antigen that you're done.
antigen apply

ZSH_THEME="spaceship"

source $HOME/.aliases

# for Node Version Management
if hash brew 2> /dev/null && [ -f "$(brew --prefix nvm)/nvm.sh" ]; then
  export NVM_DIR=~/.nvm
  # this loads nvm
  source $(brew --prefix nvm)/nvm.sh
  # for bash completion
fi;

export TERM='xterm-256color'
export EDITOR='nvim'
export GIT_EDITOR='nvim'

export PATH=/usr/local/bin:$PATH

# add /usr/local/sbin
if [[ -d /usr/local/sbin ]]; then
    export PATH=/usr/local/sbin:$PATH
fi
