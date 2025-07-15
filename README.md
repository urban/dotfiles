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

Once setup, follow the instructions on [Generating a new SSH key and adding it to the ssh-agent](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) and [Adding a new SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) to gain access to your private Github repositories.

Then change the `dotfile` repo remote from HTTPS to SSH.

```bash
cd ~/dev/dotfiles
git remote set-url origin git@github.com:urban/dotfiles.git
```

## Update

To update, and run following in a Terminal:

```sh
sh ~/dev/dotfiles/bootstrap.sh
```
