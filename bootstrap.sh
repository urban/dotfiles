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
  mkdir -p "$DEV_DIR"
fi

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
echo_header "===== Dotfiles setup ====="

if [ -d "$DOTFILES_DIR" ]; then
  echo "Updating dotfiles from repository"
  git -C "$DOTFILES_DIR" pull origin master;
else
  git clone https://github.com/urban/dotfiles.git "$DOTFILES_DIR"
fi

read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " REPLY_SYNC;
echo "";
if [[ "$REPLY_SYNC" =~ ^[Yy]$ ]]; then
  echo "Syncing dotfiles with rsync"
  rsync -avh --no-perms --no-owner --no-group \
    --exclude={'.git/','.DS_Store','Brewfile','bootstrap.sh','README.md','LICENSE-MIT.txt'} \
    "$DOTFILES_DIR" "$HOME";
fi
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

# ===== Node version manager
echo ""
echo_header "===== Fast Node Manager (fnm) ====="
FISH_CONFIG_DIR="$HOME/.config/fish/conf.d"
FNM_FISH_CONFIG="$FISH_CONFIG_DIR/fnm.fish"
if [ -f "$FNM_FISH_CONFIG" ]; then
  echo "Fish shell already set up for FNM. Skipping..."
else
  # Shell setup
  echo "Setup Fish shell for FNM."
  mkdir -p "$FISH_CONFIG_DIR"
  touch "$FNM_FISH_CONFIG"
  fnm env --use-on-cd --shell fish | source
  # Completions
  fnm completions --shell fish
fi

# ===== Git
echo ""
echo_header "===== GIT config ====="
read -p "This may overwrite existing .gitconfig in your home directory. Are you sure? (y/n) " REPLY_GIT;
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
  SSH_KEY_NAME="id_ed25519" # Default key name, so that a config file is not necessary
  read -p "This may overwrite any existing $HOME/.ssh/$SSH_KEY_NAME. Are you sure? (y/n) " REPLY_SSH;
  echo "";
  if [[ "$REPLY_SSH" =~ ^[Yy]$ ]]; then
    ssh-keygen -o -a 100 -t ed25519 -N "" -f $HOME/.ssh/$SSH_KEY_NAME -C "$GIT_EMAIL" -q
    echo "DONE. Keys are at ~/.ssh/$SSH_KEY_NAME"
    # SSH_KEY_NAME is unset at the end of the script
  fi
  # REPLY_SSH is unset at the end of the script
fi;
unset REPLY_GIT

echo ""
echo_emphasis "DONE"

# Provide additional instructions if an SSH key for GIT was created
if [[ "$REPLY_SSH" =~ ^[Yy]$ ]]; then
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
unset REPLY_SSH

# ===== Cleanup
unset DOTFILES_DIR
unset DEV_DIR
unset HEADER_COLOR
unset EMPHASIS_COLOR
unset END_COLOR
unset echo_header
unset echo_emphasis
