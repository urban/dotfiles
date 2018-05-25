#!/usr/bin/env bash

command_exists() {
    type "$1" > /dev/null 2>&1
}

echo "Installing dotfiles."

cd "$(dirname "${BASH_SOURCE}")" || exit;

echo "Updating dotfiles from repository"
git pull origin spring-cleaning;

if test ! "$(which brew)"; then
  echo "Installing Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Update Homebrew"
brew update

echo "Install all dependencies with bundle (See Brewfile)"
brew tap homebrew/bundle
brew bundle

echo "Update neovim-python client"
pip3 install neovim --upgrade

if ! [[ -d "~/.tmux/plugins/tpm" ]]; then
    echo "Installing Tmux Plugin Manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if ! command_exists zsh; then
    echo "zsh not found. Please install and then re-run installation scripts"
    exit 1
elif ! [[ $SHELL =~ .*zsh.* ]]; then
    echo "Configuring zsh as default shell"
    chsh -s "$(which zsh)"
fi

function doIt() {
  echo "Syncing dotfiles with rsync"
  rsync --exclude ".git/" \
    --exclude ".DS_Store" \
    --exclude "Brewfile" \
    --exclude "bootstrap.sh" \
    --exclude "README.md" \
    --exclude "LICENSE-MIT.txt" \
    -avh --no-perms . ~;
  mkdir -p ~/.nvm
}

if [[ $1 == --force || $1 == -f ]]; then
  doIt;
else
  read "REPLY?This may overwrite existing files in your home directory. Are you sure? (y/n) ";
  echo "";
  if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    doIt;
  fi;
fi;
unset doIt;

echo "Load shell config"
source ~/.zshrc;

echo "Install Global Yarn Packages"
yarn global add \
  babel-cli \
  babel-eslint \
  eslint \
  eslint_d \
  eslint-config-prettier \
  eslint-plugin-prettier \
  prettier \
  trash-cli

echo "Load Tmux config"
tmux source ~/.tmux.conf;

echo "Done. Please reload your terminal."
