#!/usr/bin/env bash

command_exists() {
    type "$1" > /dev/null 2>&1
}

echo "Installing dotfiles."

cd "$(dirname "${BASH_SOURCE}")" || exit;

echo "Updating dotfiles from repository"
git pull origin master;

if test ! "$(which brew)"; then
  echo "Installing Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Update Homebrew"
brew update

echo "Install all dependencies with bundle (See Brewfile)"
brew tap homebrew/bundle
brew bundle

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
  prettier

echo "Done. Please reload your terminal."
