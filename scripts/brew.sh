#!/usr/bin/env bash
# Install command-line tools using Homebrew
# Usage: `./brew.sh`

# Homebrew taps
TAPS=(
  homebrew/versions
  # Cask
  caskroom/versions
)

# Homebrew formulas
FORMULAS=(
  # Install GNU core utilities (those that come with OS X are outdated)
  coreutils
  # Install some other useful utilities like `sponge`
  moreutils
  # Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
  findutils
  # Install GNU `sed`, overwriting the built-in `sed`
  gnu-sed --default-names
  # Install Bash 4
  bash
  bash-completion
  # Install wget with IRI support
  wget --enable-iri
  # Install more recent versions of some OS X tools
  vim --override-system-vi
  homebrew/dupes/grep
  # Install other useful binaries
  git
  git-extras
  md5sha1sum
  rename
  tmux
  tree
  webkit2png
  z
  # Install development tools
  chruby
  flow
  nvm
  phantomjs
  ruby-install
  # Install Cask
  caskroom/cask/brew-cask
)

# Homebrew casks
CASKS=(
  # essential
  adium
  caffeine
  dropbox
  1password
  # dev
  arduino
  atom
  charles
  github
  heroku-toolbelt
  iterm2
  macvim
  sublime-text3
  transmission
  transmit
  vagrant
  virtualbox
  # utils
  divvy
  rightzoom
  the-unarchiver
  vlc
  # browsers
  firefox
  google-chrome
  google-chrome-canary
  # others
  skype
  calibre
  gitter
  hipchat
  sketch
  sketch-beta
  # quick look plugins (https://github.com/sindresorhus/quick-look-plugins)
  qlcolorcode
  qlstephen
  qlmarkdown
  quicklook-json
  qlprettypatch
  quicklook-csv
  betterzipql
  webpquicklook
  suspicious-package
)

# Install Homebrew if it doesn't exist
if ! hash brew 2>/dev/null; then
  echo "Installing Homebrew"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

#================================================================================

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

# Add additional formulae lookup repos
brew tap ${TAPS[@]}

# Install formulas
brew install ${FORMULAS[@]}

# Setup info
echo "Don't forget to add \`/usr/local/bin/bash to /etc/shells\` before running \`chsh\`."
echo "Don't forget to add \`\$(brew --prefix coreutils)/libexec/gnubin\` to \`\$PATH\`."

# Install casks
brew cask install ${CASKS[@]}

# Additional info
echo "Put your license in Sublime"
echo "Install io.js with \`nvm install iojs\`" # install io.js

# Remove outdated versions from the cellar
brew cleanup

