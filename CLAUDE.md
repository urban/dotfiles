# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for macOS development environment setup. The repository automatically configures a new macOS machine with development tools, applications, and personalized settings.

## Key Commands

### Bootstrap CLI Tool
The main entry point is the `bootstrap` script:
- `bootstrap init` - Complete new machine setup (creates ~/dev, installs configs, Homebrew, packages, Nix, VSCode)
- `bootstrap help` - Show available commands

### Installation Process
```bash
# Remote installation (from README)
/bin/bash -c "$(curl -fsSL --noproxy '*' https://raw.githubusercontent.com/urban/dotfiles/refs/heads/master/bootstrap)"

# Local installation
cd ~/dev/dotfiles
bootstrap init
```

### Package Management
- `brew bundle --file="packages/Brewfile"` - Install all Homebrew packages and applications
- Package definitions are in `packages/Brewfile`

### Configuration Syncing
The bootstrap script syncs configurations using rsync:
- `config/` → `~/` (home directory configurations)
- `shell/` → `~/` (shell aliases and configurations) 
- `vscode/` → `~/Library/Application Support/Code/User/` (VSCode settings)

### System Configuration
- `macos/settings.sh` - Apply macOS system preferences and settings
- Configures Dock, Finder, menu bar, text editing, Activity Monitor, App Store

## Architecture

### Directory Structure
```
~/dev/dotfiles/
├── config/          # Files synced to home directory
├── macos/           # macOS-specific settings (settings.sh)
├── packages/        # Homebrew package definitions (Brewfile)
├── shell/           # Shell configuration (.aliases)
├── vscode/          # VSCode settings, extensions, keybindings
└── bootstrap        # Main setup CLI tool
```

### Key Features
- **Environment Isolation**: Creates `~/dev` directory, excludes from Spotlight indexing
- **Homebrew Integration**: Installs and configures Homebrew with bundle support
- **Development Tools**: Git, direnv, oh-my-posh, cloc
- **Applications**: Arc browser, Claude, VSCode, Discord, Obsidian, OrbStack
- **Fonts**: Comprehensive font collection including Nerd Fonts
- **Security**: Little Snitch network monitoring
- **Shell Environment**: Custom aliases for navigation, cleanup, IP detection

### Configuration Management
- Uses rsync with `--no-perms --no-owner --no-group` for cross-platform compatibility
- Interactive prompts before overwriting existing configurations
- Automatic backup and restoration not implemented (manual user responsibility)

### Dependencies
- macOS (primary target)
- Xcode Command Line Tools (auto-installed)
- Homebrew (auto-installed)
- Nix package manager (auto-installed)
- Git (for repository management)

## VSCode Setup
- Extensions: vim mode (vscodevim.vim), project manager (alefragnani.project-manager)
- Settings and keybindings are synced from `vscode/` directory
- Automatic installation during `bootstrap init`