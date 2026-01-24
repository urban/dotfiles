#!/usr/bin/env bash

# Exit immediately if any command or pipeline returns a non-zero exit status
set -euo pipefail

# bootstrap.sh
# Usage:
#   ./bootstrap.sh <command>
# Example:
#   ./bootstrap.sh init

# ===== Print colors
HEADER_COLOR="\033[35m"
EMPHASIS_COLOR="\033[32m"
END_COLOR="\033[0m"

# ===== Configuration
CODE_DIR="$HOME/Code"
DOTFILES_DIR="$CODE_DIR/personal/dotfiles"
PACKAGES_DIR="$DOTFILES_DIR/packages"
# CODE_DIR and DOTFILES_DIR are unset at the end of the script

print_header() {
  echo ""
  echo -e "${HEADER_COLOR}$1${END_COLOR}"
}

print_emphasis() {
  echo -e "${EMPHASIS_COLOR}$1${END_COLOR}"
}

does_command_exist() {
    command -v "$1" >/dev/null 2>&1
}

initialize_code_environment() {
  # ===== ~/Code directory
  if [ ! -d "$CODE_DIR" ]; then
    echo "Make ~/Code directory"
    mkdir -p "$CODE_DIR"

    # ===== Spotlight
    echo ""
    print_header "===== Exclude ~/Code from Spotlight indexing ====="
    echo "(Enter your password if prompted)"
    SPOTLIGHT_PLIST="/System/Volumes/Data/.Spotlight-V100/VolumeConfiguration.plist"
    IS_SPOTLIGHT_PLIST_MODIFIED=false
    if ! (sudo /usr/libexec/PlistBuddy -c "Print :Exclusions" $SPOTLIGHT_PLIST | grep -Fq "$CODE_DIR"); then
      echo "Excluding $CODE_DIR from Spotlight indexing..."
      sudo /usr/libexec/PlistBuddy -c "Add :Exclusions: string $CODE_DIR" $SPOTLIGHT_PLIST
      IS_SPOTLIGHT_PLIST_MODIFIED=true
    else
      echo "$CODE_DIR is already excluded"
    fi

    if [ "$IS_SPOTLIGHT_PLIST_MODIFIED" = true ]; then
      echo "Restarting 'mds' process..."
      # restart spotlight
      sudo launchctl stop com.apple.metadata.mds && sudo launchctl start com.apple.metadata.mds
    fi
    unset IS_SPOTLIGHT_PLIST_MODIFIED
    unset SPOTLIGHT_PLIST
  fi
}

# ===== Homebrew
install_homebrew() {
  if ! does_command_exist brew; then
    print_header "===== Install Homebrew ====="
    echo "(Enter your password if prompted)"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    local brew_path=""
    if [[ -x /opt/homebrew/bin/brew ]]; then
      brew_path="/opt/homebrew/bin/brew"
    elif [[ -x /usr/local/bin/brew ]]; then
      brew_path="/usr/local/bin/brew"
    else
      brew_path="$(command -v brew)"
    fi

    local shellenv_line="eval \"\$(${brew_path} shellenv)\""
    if ! grep -Fqs "$shellenv_line" "$HOME/.zprofile"; then
      printf '\n%s\n' "$shellenv_line" >> "$HOME/.zprofile"
    fi
    eval "$("$brew_path" shellenv)"
  else
    echo "Homebrew is already installed"
  fi
}

# ===== Xcode command line tools
install_xcode_tools() {
  print_header "===== Install Xcode command line tools ====="
  echo "(Enter your password if prompted)"
  # Xcode command line tools
  if ! xcode-select -p &> /dev/null; then
    echo "Installing Xcode command line tools..."
    xcode-select --install
    # Wait until the Xcode Command Line Tools are installed
    echo "Waiting for Xcode command line tools to be installed..."
    until xcode-select -p &> /dev/null; do
      sleep 5
    done
    echo "Xcode command line tools installed."
  else
    echo "Xcode command line tools are already installed"
  fi
}

# ===== Install configs
install_config() {
  print_header "===== Install config and shell files ====="
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " REPLY_SYNC;
  if [[ "$REPLY_SYNC" =~ ^[Yy]$ ]]; then
    echo "";
    # Sync config
    echo "Syncing config"
    rsync -avh --no-perms --no-owner --no-group \
      "$DOTFILES_DIR/config/" "$HOME/";
    # Sync shell
    echo "Syncing shell"
    rsync -avh --no-perms --no-owner --no-group \
      "$DOTFILES_DIR/shell/" "$HOME/";
  else
    echo "Skipped syncing."
  fi
  unset REPLY_SYNC
}

# ===== Update dotfiles repo
update_dotfiles() {
  print_header "===== Update dotfiles ====="
  if [ -d "$DOTFILES_DIR" ]; then
    echo "Updating dotfiles from repository"
    local current_branch=""
    if current_branch="$(git -C "$DOTFILES_DIR" symbolic-ref --short HEAD 2>/dev/null)"; then
      git -C "$DOTFILES_DIR" pull --ff-only origin "$current_branch"
    else
      git -C "$DOTFILES_DIR" pull --ff-only
    fi
  else
    echo "Dotfiles directory does not exist. Cloning repository."
    git clone https://github.com/urban/dotfiles.git "$DOTFILES_DIR"
  fi
}

# ===== Install packages from Brewfile
install_packages() {
  print_header "===== Install all dependencies with bundle (See Brewfile) ====="
  if ! does_command_exist brew; then
    echo "Homebrew is not available. Run init or install_homebrew first."
    return 1
  fi
  if [ ! -f "$PACKAGES_DIR/Brewfile" ]; then
    echo "Brewfile not found at $PACKAGES_DIR/Brewfile"
    return 1
  fi
  brew bundle --file="$PACKAGES_DIR/Brewfile"
}

install_vsCode_settings() {
  print_header "===== Install VSCode settings ====="
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " REPLY_SYNC_VSCODE;
  if [[ "$REPLY_SYNC_VSCODE" =~ ^[Yy]$ ]]; then
    echo "";
    echo "Install VSCode Settings"
    # Sync vscode
    VSCODE_USER_PATH="$HOME/Library/Application Support/Code/User"
    mkdir -p "$VSCODE_USER_PATH"
    echo "Syncing vscode"
    rsync -avh --no-perms --no-owner --no-group \
      "$DOTFILES_DIR/vscode/" "$VSCODE_USER_PATH/";
    unset VSCODE_USER_PATH
  else
    echo "Skipped VSCode syncing."
  fi
  unset REPLY_SYNC_VSCODE
}

# ===== Install Nix
install_nix() {
  if nix-env --version &> /dev/null; then
    echo ""
    echo "Nix is installed."
  else
    echo ""
    print_header "===== Install Nix ====="
    bash <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
  fi
}

# ===== Cleanup
cleanup() {
  unset DOTFILES_DIR
  unset CODE_DIR
  unset PACKAGES_DIR
  unset HEADER_COLOR
  unset EMPHASIS_COLOR
  unset END_COLOR
  unset print_header
  unset print_emphasis
}

# Command functions
cmd_init() {
  print_emphasis "START BOOTSTRAP"
  initialize_code_environment
  # update_dotfiles
  install_config
  install_xcode_tools
  install_homebrew
  install_packages
  install_nix
  install_vsCode_settings

  print_emphasis "END BOOTSTRAP"
}

cmd_help() {
  print_header "===== This script sets up your new MacOS machine for development ====="
  echo ""
  echo "Usage: ./bootstrap [command]"
  echo ""
  echo "Commands:"
  echo "  init      Initialize a new machine"
  echo "  help      Show this help message (default)"
  echo ""
  echo "If no command is provided, 'help' will be executed."
}

# Main function
main() {
  # Get command from first argument, default to 'help'
  local command="${1:-help}"
  trap cleanup EXIT

  case "$command" in
    init)
      cmd_init
      ;;
    help)
      cmd_help
      ;;
    *)
      echo "Unknown command: $command"
      cmd_help
      exit 1
      ;;
  esac
}

# Run main function with all script arguments
main "$@"
