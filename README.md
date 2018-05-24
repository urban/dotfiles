# dotfiles

This is my dotfiles repo and something I will continually be working on.

Shown with [Solarized Dark colorscheme](http://ethanschoonover.com/solarized) and Powerline-patched [Fira Code](https://github.com/tonsky/FiraCode) 14pt in [iTerm 2](http://www.iterm2.com/).

## Requirements

Set `zsh` as your login shell:

```
chsh -s $(which zsh)
```

## Installation

Clone the repository onto your laptop:

```
git clone https://github.com/urban/dotfiles.git ~/dotfiles
```

Install the dotfiles by running the bootstrap script. This will pull the latest version and copy the files to your home folder excluding the `README.md`, `bootstrap.sh` and `LICENSE` files.

```
source bootstrap.sh
```

## Update

To update, `cd` into your local `dotfiles` repository, and run:

```
source bootstrap.sh
```

### Installing Homebrew formulae

When setting up a new Mac, you will want to install [Homebrew](https://brew.sh/) and some formulae.

After installing Homebrew, run the following from within your local `dotfiles` repository:

```
brew bundle
```

