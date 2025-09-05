# dotfiles

My dotfiles repo.

## Repository Structure

```
~/dev/dotfiles/
├── config/                 # Files that will be synced in your home directory
├── macos/                  
│   └── settings.sh         # MacOS specific settings script
├── packages/                  
│   └── Brewfile            # Homebrew packages and apps
├── shell/                  
│   └── .aliases            # Shell aliases
├── vscode/                 # VSCode settings, keybindings and extensions
└── bootstrap               # Main CLI tool
└── README.md               # Essential information about this project
```

## Installation

1. For a new mac, make sure you enable "Full Disk Access" for Terminal:
  - Click on the Apple icon on the top left corner of your screen -> System Preferences -> Privacy & Security -> Full Disk Access.
  - Ensure that it is turned "on" for "Terminal".
2. Open up a Terminal
3. Run the following command, and follow the prompts. If you mess up at any point for whatever reason, you can just run it again:

```sh
/bin/bash -c "$(curl -fsSL --noproxy '*' https://raw.githubusercontent.com/urban/dotfiles/refs/heads/master/bootstrap)"
```

Once setup, follow the instructions on [Generating a new SSH key and adding it to the ssh-agent](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) and [Adding a new SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) to gain access to your private Github repositories.

Then change the `dotfile` repo remote from HTTPS to SSH.

```bash
cd ~/dev/dotfiles
git remote set-url origin git@github.com:urban/dotfiles.git
```

## The `bootstrap` CLI Tool

The `bootstrap` CLI tool handles everything you need to initialize a new machine.

### Initialization Command

`bootstrap init` - Initial Setup

Complete new setup with all configurations and tools.

```sh
cd ~/dev/dotfiles
bootstrap init
```

**What it does:**

1. Creates the `~/dev` directory (if not present)
2. Installs configuration files
3. Installs XCode command line tools
3. Installs Homebrew
4. Installs packages from Brewfile
5. Installs Nix
6. Installs VSCode extensions and settings

