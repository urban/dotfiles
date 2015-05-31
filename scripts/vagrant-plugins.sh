#!/usr/bin/env bash
# Install command-line tools using Homebrew
# Usage: `./vagrant-plugins.sh`

##### Constants, Variables and Functions

# Vagrant plugins
PLUGINS=(
  vagrant-hostsupdater
  vagrant-triggers
)

##### Main

# Vagrant must be installed
if ! hash vagrant 2>/dev/null; then
  echo "Vagrant must be installed first."
fi

for plugin in ${PLUGINS[@]}; do
  vagrant plugin install "$plugin"
done

echo -e "Finished!\n"
