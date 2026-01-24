#!/usr/bin/env bash

# Exit immediately if any command or pipeline returns a non-zero exit status
set -euo pipefail

# ===== Print colors
readonly RED='\033[0;31m'
readonly GREEN="\033[0;32m"
readonly BLUE="\033[0;35m"
readonly YELLOW="033[0;33m"
readonly CYAN='\033[0;36m'
readonly RESET="\033[0m"
readonly BOLD='\033[1m'

# ===== Configuration
readonly CODE_DIR="${HOME}/Code"
readonly DOTFILES_DIR="${CODE_DIR}/personal/dotfiles"
readonly HOME_DIR="${DOTFILES_DIR}/home"
readonly PACKAGES_DIR="${DOTFILES_DIR}/packages"

# =====  Script metadata
readonly SCRIPT_NAME="dotfiles"
readonly VERSION="0.1.0"

print_header() {
    echo -e "\n${BOLD}${BLUE}$1${RESET}${RESET}"
}

print_success() {
    echo -e "${GREEN}$1${RESET}"
}

print_error() {
    echo -e "${RED}✗${RESET} $1" >&2
}

print_warning() {
    echo -e "${YELLOW}⚠${RESET} $1"
}

print_info() {
    echo -e "${GREEN}$1${RESET}"
}

command_exist() {
    command -v "$1" >/dev/null 2>&1
}

confirm() {
    local prompt="${1:-Continue?}"
    local default="${2:-n}"

    if [[ "$default" == "y" ]]; then
        prompt="$prompt [Y/n]: "
    else
        prompt="$prompt [y/N]: "
    fi

    read -r -p "$prompt" response

    case "$response" in
        [yY][eE][sS]|[yY]) return 0 ;;
        [nN][oO]|[nN]) return 1 ;;
        "")
            if [[ "$default" == "y" ]]; then
                return 0
            else
                return 1
            fi
            ;;
        *) return 1 ;;
    esac
}

initialize_code_environment() {
    # ===== ~/Code directory
    if [ ! -d "$CODE_DIR" ]; then
        echo "Make ~/Code directory"
        mkdir -p "$CODE_DIR"

        # ===== Spotlight
        print_header "===== Exclude ~/Code from Spotlight indexing ====="
        echo "(Enter your password if prompted)"
        SPOTLIGHT_PLIST="/System/Volumes/Data/.Spotlight-V100/VolumeConfiguration.plist"
        IS_SPOTLIGHT_PLIST_MODIFIED=false
        if ! (sudo /usr/libexec/PlistBuddy -c "Print :Exclusions" $SPOTLIGHT_PLIST | grep -Fq "$CODE_DIR"); then
            echo "Excluding $CODE_DIR from Spotlight indexing..."
            sudo /usr/libexec/PlistBuddy -c "Add :Exclusions: string $CODE_DIR" $SPOTLIGHT_PLIST
            IS_SPOTLIGHT_PLIST_MODIFIED=true
        else
            print_info "$CODE_DIR is already excluded"
        fi

        if [ "$IS_SPOTLIGHT_PLIST_MODIFIED" = true ]; then
            print_info "Restarting 'mds' process..."
            # restart spotlight
            sudo launchctl stop com.apple.metadata.mds && sudo launchctl start com.apple.metadata.mds
        fi
        unset IS_SPOTLIGHT_PLIST_MODIFIED
        unset SPOTLIGHT_PLIST
    fi
}

# ===== Homebrew
install_homebrew() {
    if ! command_exist brew; then
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
        print_info "Homebrew is already installed"
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
        print_success "Xcode command line tools installed."
    else
        print_info "Xcode command line tools are already installed"
    fi
}

# ===== Install configs
install_config() {
    print_header "===== Install config and shell files ====="
    if confirm "This may overwrite existing files in your home directory. Are you sure?" "y"; then
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
}

install_vsCode_settings() {
    print_header "===== Install VSCode settings ====="
    if confirm "This may overwrite existing files in your home directory. Are you sure?" "y"; then
        print_info "Install VSCode Settings"
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
}

symlink_dotfiles() {
    print_header "Symlink dotfiles"

    if ! command_exist stow; then
        print_error "GNU Stow is not installed"
        print_info "Please install stow via Homebrew: brew install stow"
        return 1
    fi

    print_info "Symlinking files from ${HOME_DIR} to ${HOME}..."

    backup_files "${HOME}"

    if stow -R -v -d "${DOTFILES_DIR}" -t "${HOME}" home; then
       print_success "Dotfiles symlinked successfully"
    else
        print_error "Failed to symlink dotfiles"
        return 1
    fi
}

backup_files() {
    local dir="$1"
    print_info "Backing up files from ${dir}"
    local backup_dir
    backup_dir="${DOTFILES_DIR}/backups/$(date +%Y%m%d_%H%M%S)"
    local files_to_backup=()

    # Check for existing files that would be overwritten
    while IFS= read -r -d '' file; do
        local relative_path="${file#"${HOME_DIR}"/}"
        local target_path="${dir}/${relative_path}"

        if [[ -e "$target_path" && ! -L "$target_path" ]]; then
            files_to_backup+=("$relative_path")
        fi
    done < <(find "${HOME_DIR}" -type f -print0)

    if [[ ${#files_to_backup[@]} -gt 0 ]]; then
        print_warning "The following files will be replaced:"
        printf "  %s\n" "${files_to_backup[@]}"

        if confirm "Create backups of existing files?" "y"; then
            mkdir -p "$backup_dir"
            for file in "${files_to_backup[@]}"; do
                local src="${dir}/${file}"
                local dst="${backup_dir}/${file}"
                mkdir -p "$(dirname "$dst")"
                if ! cp -p "$src" "$dst"; then
                    print_error "Failed to backup: $src"
                    return 1
                fi
            done
            print_success "Backups created in ${backup_dir}"
        fi
    fi
}

# ===== Update dotfiles repo
update_dotfiles() {
    print_header "Update dotfiles"

    if git -C "$DOTFILES_DIR" pull; then
        print_success "Repository updated"
    else
        print_error "Failed to update repository"
        return 1
    fi
}

# ===== Install packages from Brewfile
install_packages() {
    print_header "===== Install all dependencies with bundle (See Brewfile) ====="
    if ! command_exist brew; then
        print_error "Homebrew is not available. Run init or install_homebrew first."
        return 1
    fi
    if [ ! -f "$PACKAGES_DIR/Brewfile" ]; then
        print_error "Brewfile not found at $PACKAGES_DIR/Brewfile"
        return 1
    fi
    brew bundle --file="$PACKAGES_DIR/Brewfile"
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

update_packages() {
    print_info "Updating Homebrew..."

    brew update
    brew upgrade

    print_info "Packages updated"

    if confirm "Clean up old versions?" "y"; then
        print_info "Cleaning up old package versions..."
        brew cleanup
        print_success "Cleanup completed"
    fi
}

# Command functions
cmd_init() {
    print_header "Initializing dotfiles"

    initialize_code_environment || return 1
    symlink_dotfiles || return 1
    # install_config || return 1
    install_xcode_tools || return 1
    install_homebrew || return 1
    install_packages || return 1
    install_nix || return 1
    install_vsCode_settings || return 1

    print_header "Initialization complete! 🎉"
}

cmd_update() {
    print_header "Updating dotfiles"

    if confirm "Update dotfile symlinks?" "y"; then
        symlink_dotfiles
    fi

    if confirm "Pull latest changes?" "y"; then
        update_dotfiles
    fi

    if confirm "Update Homebrew packages?" "y"; then
        update_packages
    fi
}

cmd_help() {
    echo -e "${BOLD}${SCRIPT_NAME}${RESET} - New machine management tool"
    echo "Version: ${VERSION}"
    echo ""

    echo "Usage: ./dotfiles [command]"
    echo ""

    echo "Commands:"
    echo "  help      Show this help message (default)"
    echo "  init      Initialize a new machine"
    echo "  update    Update dotfiles and packages"
    echo ""

    echo -e "${BOLD}OPTIONS:${RESET}"
    echo "    --version       Show version information"
    echo "    -h, --help      Show this help message"
    echo ""

    echo "If no command is provided, 'help' will be executed."
    echo ""
}

# Main function
main() {
    # Parse global options
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --version)
                echo "${SCRIPT_NAME} version ${VERSION}"
                exit 0
                ;;
            -h|--help)
                cmd_help
                exit 0
                ;;
            *)
                break
                ;;
        esac
    done

    # Get command from first argument, default to 'help'
    local command="${1:-help}"

    case "$command" in
        help)
            cmd_help
            ;;
        init)
            cmd_init
            ;;
        update)
            cmd_update
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
