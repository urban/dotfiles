source ~/.aliases

# Load oh-my-posh theme
eval "$(oh-my-posh init zsh --config /opt/homebrew/opt/oh-my-posh/themes/star.omp.json)"

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# Direnv
eval "$(direnv hook zsh)"
