# dotfiles

Personal dotfiles for macOS development setup.

## Repository Structure

```
~/Code/personal/dotfiles/
├── config/                 # Synced to $HOME (dotfiles, .config/)
├── macos/
│   └── settings.sh         # macOS system preferences (requires sudo)
├── sandbox/
│   ├── Dockerfile          # Sandbox image
│   └── entrypoint.sh       # Sandbox entry point
├── shell/
│   ├── .aliases            # Shell aliases
│   ├── .zshenv             # Zsh environment
│   ├── .zprofile           # Zsh profile
│   └── .zshrc              # Zsh config
├── vscode/
│   ├── settings.json       # VSCode settings
│   ├── keybindings.json    # VSCode keybindings
│   └── extensions.json     # VSCode extensions list
├── dotfiles.sh            # Main setup script
└── sandbox.sh              # Run commands in sandbox container
```

## Installation

1. Enable "Full Disk Access" for Terminal (System Settings -> Privacy & Security -> Full Disk Access).
2. Clone this repo to the expected location (or update `CODE_DIR` and `DOTFILES_DIR` in `dotfiles.sh` and `sandbox.sh`).

```sh
mkdir -p ~/Code/personal
git clone https://github.com/urban/dotfiles.git ~/Code/personal/dotfiles
```

3. Run the dotfiles script:

```sh
cd /Volumes/Code/personal/dotfiles
./dotfiles.sh init
```

Once setup, follow the instructions on [Generating a new SSH key and adding it to the ssh-agent](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) and [Adding a new SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) to gain access to your private GitHub repositories.

Then change the dotfiles repo remote from HTTPS to SSH.

```bash
cd /Volumes/Code/personal/dotfiles
git remote set-url origin git@github.com:urban/dotfiles.git
```

## `dotfiles.sh`

`dotfiles.sh` handles initialization for a new machine.

```sh
./dotfiles.sh --help
./dotfiles.sh init
./dotfiles.sh update
```

**What it does:**

1. If `/Volumes/Code` is missing, adds it to Spotlight exclusions and restarts `mds`
2. Symlinks `home/` into `$HOME` via GNU Stow (with optional backups of conflicting files)
3. Symlinks VSCode settings, keybindings, and extensions list into `~/Library/Application Support/Code/User` via GNU Stow (with optional backups)
4. Installs Xcode Command Line Tools if missing
5. Installs Homebrew if missing and ensures `brew shellenv` is in `~/.zprofile`
6. Installs packages from the Brewfile via `brew bundle install`
7. Installs Nix if missing via the `nixos.org` install script

## `sandbox.sh`

`sandbox.sh` handles running a command inside a Docker-based sandbox (requires Docker):

```sh
./sandbox.sh bash
./sandbox.sh node -v
```

**What it does:**

1. Validates paths, creates a per-project `.sandbox` state directory, and ensures it is in `.gitignore`
2. Captures Git author info and creates state dirs for bun, pnpm, gh, and codex
3. Creates a persistent `sandbox-nix-store` Docker volume for the Nix store
4. Builds the sandbox image from `sandbox/Dockerfile`
5. Runs an interactive container mounting the project, state dirs, and Nix store, and passes Git author env vars
6. Entry point installs Nix/tools, installs latest npm and `@openai/codex`, prompts for Codex/GitHub auth if missing, configures git, runs `direnv allow`, then runs the provided command (or starts `/bin/bash` if none was given)
