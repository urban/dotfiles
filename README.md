# dotfiles

This is my dotfiles repo and something I will continually be working on.

## Installation

1. For a new mac, make sure you enable "Full Disk Access" for Terminal: 
  1. Click on the Apple icon on the top left corner of your screen -> System Preferences -> Privacy & Security -> Full Disk Access.
  2. Ensure that it is turned "on" for "Terminal".

2. Open up a Terminal
3. Run the following command, and follow the prompts. If you mess up at any point for whatever reason, you can just run it again:

```sh
/bin/bash -c "$(curl -fsSL --noproxy '*' https://raw.githubusercontent.com/urban/dotfiles/refs/heads/master/bootstrap.sh)"
```

## Update

To update, and run following in a Terminal:

```sh
source ~/dev/dotfiles/bootstrap.sh
```
