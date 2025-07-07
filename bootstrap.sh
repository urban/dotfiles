#!/usr/bin/env bash

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
  mkdir -p $DEV_DIR
fi

# ===== Spotlight
echo ""
echo_header "===== Exclude ~/dev from Spotlight indexing ====="

SPOTLIGHT_PLIST="/System/Volumes/Data/.Spotlight-V100/VolumeConfiguration.plist"
IS_SPOTLIGHT_PLIST_MODIFIED=false

exclude_dir_from_spotlight() {
  if ! (sudo /usr/libexec/PlistBuddy -c "Print :Exclusions" $1 | grep -Fq "$2"); then
    echo "Excluding $2 from Spotlight indexing..."
    sudo /usr/libexec/PlistBuddy -c "Add :Exclusions: string $2" $1
    IS_SPOTLIGHT_PLIST_MODIFIED=true
  else
    echo "$2 is already excluded"
  fi
}

echo "(Enter your password if prompted)"
exclude_dir_from_spotlight $SPOTLIGHT_PLIST $DEV_DIR
if [ "$IS_SPOTLIGHT_PLIST_MODIFIED" = true ]; then
  echo "Restarting 'mds' process..."
  # restart spotlight
  sudo launchctl stop com.apple.metadata.mds && sudo launchctl start com.apple.metadata.mds
fi
unset exclude_dir_from_spotlight
unset IS_SPOTLIGHT_PLIST_MODIFIED
unset SPOTLIGHT_PLIST

# ===== Homebrew 
echo ""
echo_header "===== Install Homebrew and Xcode Command Line Tools ====="
if brew -v &>/dev/null; then
  echo "Homebrew is already installed"
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
# Ensures 'brew' command is available
eval "$(/opt/homebrew/bin/brew shellenv)"

# ===== Dotfiles
echo ""
echo_header "===== Dotfiles setup ====="

if [ -d "$DOTFILES_DIR" ]; then
  echo "Updating dotfiles from repository"
  git -C "$DOTFILES_DIR" pull origin master;
else
  git clone https://github.com/urban/dotfiles.git "$DOTFILES_DIR"
fi

sync_dot_files() {
  echo "Syncing dotfiles with rsync"
  rsync --exclude ".git/" \
    --exclude ".DS_Store" \
    --exclude "Brewfile" \
    --exclude "bootstrap.sh" \
    --exclude "README.md" \
    --exclude "LICENSE-MIT.txt" \
    -avh --no-perms "$DOTFILES_DIR" "$HOME";
}

if [[ $1 == --force || $1 == -f ]]; then
  sync_dot_files;
else
  read "REPLY_SYNC?This may overwrite existing files in your home directory. Are you sure? (y/n) ";
  echo "";
  if [[ "$REPLY_SYNC" =~ ^[Yy]$ ]]; then
    sync_dot_files;
  fi;
fi;
unset sync_dot_files;

# ===== Install dependencies
echo ""
echo_header "===== Install all dependencies with bundle (See Brewfile) ====="
brew bundle --file="$DOTFILES_DIR/Brewfile"

# ===== Command shell
echo ""
echo_header "===== Fish command line shell ====="
FISH_PATH=$(which fish)
chsh -s "$FISH_PATH"
fish_add_path "$FISH_PATH"
unset FISH_PATH

# ===== Git
echo ""
echo_header "===== GIT config ====="
read "REPLY_GIT?This may overwrite existing .gitconfig in your home directory. Are you sure? (y/n) ";
echo "";
if [[ "$REPLY_GIT" =~ ^[Yy]$ ]]; then
  echo 'Enter your git user.name (e.g. "First Last" without quotes).'
  echo "This value will be set as your git config's user.name."
  read -p "Git username: " GIT_USERNAME
  if [ -z "$GIT_USERNAME" ]; then
    echo "Git username cannot be empty. Skipping..."
  else
    git config --global user.name "$GIT_USERNAME"
    echo "user.name: $GIT_USERNAME"
  fi
  unset GIT_USERNAME

  echo ""
  echo 'Enter your git email (e.g. "first.last@gmail.com" without quotes).'
  echo "This value will be set as your git config's user.email."
  read -p "Git email: " GIT_EMAIL
  if [ -z "$GIT_EMAIL" ]; then
    echo "Git email cannot be empty. Skipping..."
  else
    git config --global user.email "$GIT_EMAIL"
    echo "user.email: $GIT_EMAIL"
  fi
  unset GIT_EMAIL

  # SSH key
  echo ""
  echo_header "===== Generating SSH Keys for Git ====="
  read "REPLY_SSH?This may overwrite existing .gitconfig in your home directory. Are you sure? (y/n) ";
  echo "";
  if [[ "$REPLY_SSH" =~ ^[Yy]$ ]]; then
    SSH_KEY_NAME="id_ed25519" # Default key name, so that a config file is not necessary
    ssh-keygen -o -a 100 -t ed25519 -N "" -f $HOME/.ssh/$SSH_KEY_NAME -C "$GIT_EMAIL" -q
    echo "DONE. Keys are at ~/.ssh/$SSH_KEY_NAME"
    # SSH_KEY_NAME is unset at the end of the script
  fi
  unset REPLY_SSH
fi;
unset REPLY_GIT

echo ""
echo_emphasis "DONE"

# Provide additional instructions if an SSH key for GIT was created
if [ -z "$SSH_KEY_NAME" ]; then
  echo ""
  echo_header "===== Git final setup ====="
  echo "    1. Copy your PUBLIC key to clipboard (contents of $HOME/.ssh/$SSH_KEY_NAME.pub)."
  echo "       You can manually do this or use pbcopy to copy the contents to clipboard by running:"
  echo
  echo "cat $HOME/.ssh/$SSH_KEY_NAME.pub | pbcopy"
  echo
  echo "    2. Go to you GitHub account,navigate to your account settings, then go to \"SSH and GPG keys\", and click on \"New SSH key\". Paste your public key into the \"Key\" field, give it a descriptive title, and click \"Add SSH key\""
  echo ""

  unset SSH_KEY_NAME
fi

# ===== Cleanup
unset DOTFILES_DIR
unset DEV_DIR
unset HEADER_COLOR
unset EMPHASIS_COLOR
unset END_COLOR
unset echo_header
unsset echo_emphasis
