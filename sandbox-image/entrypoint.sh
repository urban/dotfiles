#!/bin/bash

if ! command -v nix >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux \
        --extra-conf "sandbox = false" \
        --no-start-daemon \
        --no-confirm

    nix profile add \
        nixpkgs#coreutils \
        nixpkgs#curl \
        nixpkgs#direnv \
        nixpkgs#fd \
        nixpkgs#gh \
        nixpkgs#git \
        nixpkgs#gnused \
        nixpkgs#jq \
        nixpkgs#less \
        nixpkgs#nodejs_24 \
        nixpkgs#ripgrep \
        nixpkgs#tree \
        nixpkgs#wget
else
    groupadd -r nixbld
    for n in $(seq 1 32); do
        useradd -c "Nix build user $n" -d /var/empty -g nixbld -G nixbld -M -N -r -s "$(which nologin)" nixbld$n;
    done
fi

export PATH="$(npm config get prefix -g)/bin:$PATH"

npm i -g npm@latest @openai/codex
eval "$(direnv hook bash)"

if [ ! -f ~/.codex/auth.json ]; then
    codex login --device-auth
fi

if [ ! -f ~/.config/gh/hosts.yml ]; then
    gh auth login
fi

git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"
gh auth setup-git

if [ -f .envrc ]; then
  direnv allow || true
fi

if [ "$#" -gt 0 ]; then
    exec "$@"
else
    exec /bin/bash
fi
