# My Dotfiles

This is my dotfiles repo and something I will continually be working on.

## Installation

You need to have [XCode][0] or the [XCode Command Line Tools][1] installed for this script to run. The easiest way to install the XCode Command Line Tools is to open Terminal and type `xcode-select --install` and follow the prompts.

Once installed, type the following into Terminal.

```shell
bash -c "$(curl -fsSL http://bit.ly/urban-dotfiles)" && source ~/.bashrc
```

To install all applications, run the following in Terminal.

```shell
brew-install
```
To install all vim plugins, type the following into Terminal.

```shell
vim +PluginInstall +qall
```

In order to get vim airline to look correct, you need to install the [powerline font](https://github.com/powerline/fonts). Once installed, set you font in terminal to one that was just installed. I use "Droid Sans Mono Dotted for Powerline" at 12 pt.

Install the latest version of `node`.

```shell
nvm install node
```

## What did that do?

...

## How to update

You should only need to update when:

- You want to make changes to `~/.dotfiles/copy/.gitconfig` (the only file that is copied rather than symlinked)
- You want to update Homebrew or Cask
- You want to update Vagrant plugins

## Private, custom commands

If `~/.extra` exists, it will be sourced along with the other shell environment files. This is where custom commands and additional private info can be stored and it will not be committed to this repo.

## Paths

The `~/.path` file is where your `PATH` can be set up:

```shell
# ...
PATH=/opt/local/bin
PATH=$PATH:/opt/local/sbin
PATH=$PATH:/bin
PATH=$PATH:~/.rvm/bin
# ...

export PATH
```

## Insperation

- [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
- [cowboy/dotfiles](https://github.com/cowboy/dotfiles)
- [holman/dotfiles](https://github.com/holman/dotfiles)
- [mattbrictson/dotfiles](https://github.com/mattbrictson/dotfiles)
- [Writing Shell Scripts](http://linuxcommand.org/lc3_writing_shell_scripts.php)

[0]: https://developer.apple.com/downloads/index.action?=xcode
[1]: https://developer.apple.com/downloads/index.action?=command%20line%20tools
[2]: http://net.tutsplus.com/tutorials/tools-and-tips/setting-up-a-mac-dev-machine-from-zero-to-hero-with-dotfiles/
[3]: http://brew.sh/
[4]: http://caskroom.io/
[5]: https://github.com/xdissent/ievms
