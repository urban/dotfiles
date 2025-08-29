source $HOME/.aliases

# add /usr/local/sbin
if [[ -d /usr/local/sbin ]]; then
    export PATH=/usr/local/sbin:$PATH
fi

# Load oh-my-posh theme
eval "$(oh-my-posh init zsh --config /opt/homebrew/opt/oh-my-posh/themes/star.omp.json)"

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# Direnv
eval "$(direnv hook zsh)"