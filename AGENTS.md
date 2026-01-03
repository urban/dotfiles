# AGENTS.md

This file provides guidance to AI coding agents working in this repository.

## Repository Overview

Personal dotfiles repository for macOS development environment setup. This is a **configuration-only repository** with no build system, testing framework, or compiled code.

## Commands

### Bootstrap CLI

```bash
bootstrap init     # Complete new machine setup
bootstrap help     # Show available commands
```

### Package Management

```bash
brew bundle --file="packages/Brewfile"    # Install all Homebrew packages
```

### macOS Configuration

```bash
./macos/settings.sh    # Apply macOS system preferences (requires sudo)
```

### Manual Testing

There is no automated test suite. To verify changes:

1. Run `bash -n <script>` to syntax-check shell scripts
2. Run `shellcheck <script>` if available (not installed by default)
3. Test bootstrap on a fresh macOS VM or by manually running individual functions

## Directory Structure

```
dotfiles/
├── config/              # Synced to $HOME (dotfiles, .config/)
├── macos/               # macOS-specific scripts (settings.sh)
├── packages/            # Package manifests (Brewfile)
├── shell/               # Shell configs (.zshrc, .aliases)
├── vscode/              # VSCode settings, keybindings, extensions
└── bootstrap            # Main CLI tool (executable)
```

## Code Style Guidelines

### Shell Scripts

#### Shebang and Safety
```bash
#!/usr/bin/env bash
set -euo pipefail    # Strict mode: exit on error, undefined vars, pipe failures
```

Use `set -euo pipefail` for main scripts. Use `set -e` alone for scripts that need to handle undefined variables gracefully.

#### Variable Naming

- **SCREAMING_SNAKE_CASE** for constants and configuration variables
  - `CODE_DIR`, `DOTFILES_DIR`, `HEADER_COLOR`
- **snake_case** for local/temporary variables
  - `colorflag`, `command`

#### Function Naming

- **snake_case** for all functions
- Prefix CLI command handlers with `cmd_`
  - `cmd_init()`, `cmd_help()`
- Use descriptive verb-noun names
  - `install_homebrew()`, `does_command_exist()`, `print_header()`

#### Script Structure

Organize in order: shebang → constants → utility functions → feature functions → `cmd_` functions → cleanup → main

#### Error Handling

```bash
does_command_exist() {
    command -v "$1" >/dev/null 2>&1
}

# Interactive confirmation for destructive operations
read -p "This may overwrite existing files. Are you sure? (y/n) " REPLY
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    # proceed
fi
unset REPLY
```

#### String Quoting
- Double quotes for variables: `"$HOME"`, `"$DOTFILES_DIR"`
- Single quotes for literal strings without variables
- Always quote paths that may contain spaces

#### Comments

Use `# ===== Section headers` with equals signs for major sections. Reference sources when borrowing configurations.

### Brewfile Style

```ruby
cask_args appdir: "/Applications"    # Global settings first
brew "package"                       # Inline comment describing purpose
cask "app-name"                      # Apps section
cask "font-name"                     # Fonts last
```

### JSON Configuration Files

- 2-space indentation
- No trailing commas
- Comments using `//` where supported (VSCode, Zed)
- Logical grouping with blank lines between sections

### File Naming Conventions

| Type | Convention | Examples |
|------|------------|----------|
| Shell scripts | No extension or `.sh` | `bootstrap`, `settings.sh` |
| Dotfiles | Leading dot | `.aliases`, `.zshrc` |
| Config directories | lowercase | `config/`, `shell/` |
| Package manifests | PascalCase | `Brewfile` |
| Documentation | UPPERCASE.md | `README.md`, `AGENTS.md` |
| JSON configs | lowercase.json | `settings.json` |

## Key Patterns

### Rsync for Syncing

```bash
rsync -avh --no-perms --no-owner --no-group "$SOURCE/" "$DEST/"
```

Flags: archive mode, verbose, human-readable, no permission/owner sync for cross-platform compatibility.

### Environment Detection

```bash
if [[ -f "/opt/homebrew/bin/brew" ]] then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
```

### Cleanup Pattern

Always unset script-scoped variables and functions at the end:

```bash
cleanup() {
    unset VARIABLE1
    unset function_name
}
```

## Important Notes

1. **No Build System**: This repository has no Makefile, package.json, or build scripts
2. **No Tests**: Manual verification only; use `bash -n` for syntax checking
3. **macOS Only**: All scripts assume macOS; do not add Linux/Windows support
4. **Interactive Prompts**: Always confirm before overwriting existing files
5. **Idempotent Operations**: All install functions should be safe to run multiple times
