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
./dotfiles.sh init
./dotfiles.sh help
```

**What it does:**

1. Creates `/Volumes/Code` partition if missing and excludes it from Spotlight indexing
2. Syncs `home/` into `$HOME`
3. Installs Xcode command line tools
4. Installs Homebrew
6. Installs Nix
7. Syncs VSCode settings, keybindings, and extension list

## Other Commands

### macOS Settings

Requires sudo.

```sh
./macos/settings.sh
```

### Homebrew Packages

```sh
brew bundle
```

### Sandbox

Run a command inside the Docker-based sandbox (requires Docker):

```sh
./sandbox.sh bash
./sandbox.sh node -v
```
