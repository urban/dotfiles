source $HOME/.aliases

# add /usr/local/sbin
if [[ -d /usr/local/sbin ]]; then
    export PATH=/usr/local/sbin:$PATH
fi

# Load FNM
eval "$(fnm env --use-on-cd --shell zsh)"

# Load oh-my-posh theme
eval "$(oh-my-posh init zsh --config /opt/homebrew/opt/oh-my-posh/themes/star.omp.json)"