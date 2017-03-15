# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Load the shell dotfiles, and then some:
function load_file() {
  [ -r "$1" ] && [ -f "$1" ] && source "$1";
}
function load_dir() {
  for file in $1/*; do
    load_file $file
  done;
  unset file;
}

load_file ~/.path # Can be used to extend `$PATH`
load_file ~/.bash_prompt
load_dir ~/.bash
load_file ~/.extra # Can be used for other settings you don't want to commit.
unset -f load_file
unset -f load_dir

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
  shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if hash brew 2> /dev/null && [ -f "$(brew --prefix)/etc/bash-completion" ]; then
  source "$(brew --prefix)/etc/bash-completion";
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

# init z https://github.com/rupa/z
# if hash brew 2> /dev/null && [ -f "$(brew --prefix)/etc/profile.d/z.sh" ]; then
#   source "$(brew --prefix)/etc/profile.d/z.sh"
# fi;

# for Node Version Management
if hash brew 2> /dev/null && [ -f "$(brew --prefix nvm)/nvm.sh" ]; then
  export NVM_DIR=~/.nvm
  # this loads nvm
  source $(brew --prefix nvm)/nvm.sh
  # for bash completion
  [[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
fi;

# for Autoenv
if hash brew 2> /dev/null && [ -f "$(brew --prefix autoenv)/activate.sh" ]; then
  source $(brew --prefix autoenv)/activate.sh
fi;

# for chruby, a program to manage Ruby versions
# if [ -f /usr/local/opt/chruby/share/chruby/chruby.sh ]; then
#   # this loads chruby
#   source /usr/local/opt/chruby/share/chruby/chruby.sh
#   # this enables auto-switching of Rubies specified by .ruby-version files
#   source /usr/local/opt/chruby/share/chruby/auto.sh
# fi;
eval $(/usr/libexec/path_helper -s)
