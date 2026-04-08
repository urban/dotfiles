# dotfiles

Personal macOS dotfiles and bootstrap scripts.

## Repository layout

```text
dotfiles/
├── home/                   # stowed into $HOME
│   ├── .aliases
│   ├── .zshenv
│   ├── Brewfile
│   └── .config/
│       ├── direnv/
│       ├── ghostty/
│       ├── git/
│       ├── nix/
│       ├── zed/
│       └── zsh/
├── macos/
│   └── settings.sh         # optional macOS defaults script
├── sandbox/
│   ├── Dockerfile
│   └── entrypoint.sh
├── vscode/                 # stowed into VS Code's user config dir
│   ├── extensions.json
│   ├── keybindings.json
│   ├── mcp.json
│   └── settings.json
├── dotfiles.sh             # bootstrap and update script
└── sandbox.sh              # Docker-based project sandbox
```

## Before you start

- macOS only
- Admin access is helpful; some steps use `sudo`
- Give your terminal app Full Disk Access in System Settings -> Privacy & Security -> Full Disk Access
- If `git` is not available yet, run `xcode-select --install` first or let `git` trigger Apple's Command Line Tools prompt

## New machine setup

Clone the repo wherever you want. Both scripts resolve their own location, so they do not require a fixed path.

```sh
mkdir -p ~/Code/personal
git clone https://github.com/urban/dotfiles.git ~/Code/personal/dotfiles
cd ~/Code/personal/dotfiles
./dotfiles.sh init
```

`init` installs the bootstrap tools first, then stows the dotfiles. On a clean machine it will:

1. install Xcode Command Line Tools if needed
2. install Homebrew if needed
3. install packages from `home/Brewfile`
4. symlink `home/` into `$HOME` with GNU Stow
5. symlink `vscode/` into `~/Library/Application Support/Code/User`
6. install Nix if needed
7. optionally run `macos/settings.sh`

The script may prompt you to:

- back up files that would be replaced
- confirm system changes
- enter your password for `sudo`

When it finishes, start a new shell so the stowed zsh config is loaded:

```sh
exec zsh
```

After that, `dotfiles` and `sandbox` are available as shell functions.

## Post-install

If you cloned over HTTPS, create an SSH key, add it to GitHub, then switch the repo remote to SSH.

- [Generating a new SSH key and adding it to the ssh-agent](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [Adding a new SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

From the repo root:

```sh
git remote set-url origin git@github.com:urban/dotfiles.git
```

If you use services that need personal credentials, add them after setup. For example, `vscode/mcp.json` ships with blank values and needs your own API key.

## dotfiles.sh

```sh
./dotfiles.sh --help
./dotfiles.sh init
./dotfiles.sh update
```

`update` is interactive. It can:

- pull the latest changes
- re-stow `home/`
- re-stow `vscode/`
- update Homebrew packages

## sandbox.sh

`sandbox.sh` runs a command in a Docker-based sandbox. Start Docker or OrbStack first.

```sh
./sandbox.sh
./sandbox.sh bash
./sandbox.sh node -v
```

What it does:

1. creates a per-project `.sandbox/` state directory
2. adds `/.sandbox/` to the current project's `.gitignore`
3. creates persistent state dirs for bun, pnpm, GitHub CLI, and Codex
4. creates a `sandbox-nix-store` Docker volume
5. builds the image from `sandbox/Dockerfile`
6. runs the container with the current project mounted at `/app`

On first run, the container entrypoint installs Nix and a few CLI tools, installs the latest `npm` and `@openai/codex`, prompts for Codex and GitHub auth if needed, configures Git author info, runs `direnv allow` when `.envrc` exists, then executes your command. With no command, it starts `bash`.
