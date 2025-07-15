#!/usr/bin/env bash

# Exit immediately if any command or pipeline returns a non-zero exit status
set -e

# ===== Print utils
HEADER_COLOR="\033[35m"
EMPHASIS_COLOR="\033[32m"
END_COLOR="\033[0m"

echo_header() {
  echo -e "${HEADER_COLOR}$1${END_COLOR}"
}

echo_emphasis() {
  echo -e "${EMPHASIS_COLOR}$1${END_COLOR}"
}

echo ""
echo_header "===== This script sets up your new MacOS machine for development ====="

DEV_DIR="$HOME/dev"
DOTFILES_DIR="$DEV_DIR/dotfiles"
# DEV_DIR and DOTFILES_DIR are unset at the end of the script

# ===== ~/dev directory
if [ ! -d "$DEV_DIR" ]; then
  echo "Make ~/dev directory"
  mkdir -p "$DEV_DIR"

  # ===== Spotlight
  echo ""
  echo_header "===== Exclude ~/dev from Spotlight indexing ====="
  echo "(Enter your password if prompted)"
  SPOTLIGHT_PLIST="/System/Volumes/Data/.Spotlight-V100/VolumeConfiguration.plist"
  IS_SPOTLIGHT_PLIST_MODIFIED=false
  if ! (sudo /usr/libexec/PlistBuddy -c "Print :Exclusions" $SPOTLIGHT_PLIST | grep -Fq "$DEV_DIR"); then
    echo "Excluding $DEV_DIR from Spotlight indexing..."
    sudo /usr/libexec/PlistBuddy -c "Add :Exclusions: string $DEV_DIR" $SPOTLIGHT_PLIST
    IS_SPOTLIGHT_PLIST_MODIFIED=true
  else
    echo "$DEV_DIR is already excluded"
  fi

  if [ "$IS_SPOTLIGHT_PLIST_MODIFIED" = true ]; then
    echo "Restarting 'mds' process..."
    # restart spotlight
    sudo launchctl stop com.apple.metadata.mds && sudo launchctl start com.apple.metadata.mds
  fi
  unset IS_SPOTLIGHT_PLIST_MODIFIED
  unset SPOTLIGHT_PLIST
fi

# ===== Homebrew 
echo ""
echo_header "===== Install Homebrew and Xcode Command Line Tools ====="
echo "(Enter your password if prompted)"
if brew -v &>/dev/null; then
  echo "Homebrew is already installed"
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo >> "$HOME/.zprofile"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
  eval "$(/opt/homebrew/bin shellenv)"
fi
# Ensures 'brew' command is available
eval "$(/opt/homebrew/bin/brew shellenv)"

# ===== Dotfiles
echo ""
echo_header "===== Config setup ====="

if [ -d "$DOTFILES_DIR" ]; then
  echo "Updating dotfiles from repository"
  git -C "$DOTFILES_DIR" pull origin master;
else
  git clone https://github.com/urban/dotfiles.git "$DOTFILES_DIR"
fi

# ===== Install dependencies
echo ""
echo_header "===== Install all dependencies with bundle (See Brewfile) ====="
brew bundle --file="$DOTFILES_DIR/Brewfile"

# read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " REPLY_SYNC_CONFIG
read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " REPLY_SYNC;
echo "";
if [[ "$REPLY_SYNC" =~ ^[Yy]$ ]]; then
  echo "Syncing with rsync."
  # Sync config
  echo "Syncing config"
  rsync -avh --no-perms --no-owner --no-group \
    "$DOTFILES_DIR/config/" "$HOME/";
  # Sync shell
  echo "Syncing shell"
  rsync -avh --no-perms --no-owner --no-group \
    "$DOTFILES_DIR/shell/" "$HOME/";
  # Sync vscode
  VSCODE_USER_PATH="$HOME/Library/Application Support/Code/User"
  mkdir -p "$VSCODE_USER_PATH"
  echo "Syncing vscode"
  rsync -avh --no-perms --no-owner --no-group \
    "$DOTFILES_DIR/vscode/" "$VSCODE_USER_PATH/";
  unset VSCODE_USER_PATH
else 
  echo "Skipped syncing."
fi
unset REPLY_SYNC

echo ""
echo_emphasis "DONE"

# ===== Cleanup
unset DOTFILES_DIR
unset DEV_DIR
unset HEADER_COLOR
unset EMPHASIS_COLOR
unset END_COLOR
unset echo_header
unset echo_emphasis
