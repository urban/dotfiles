# zsh startup files live under $ZDOTDIR. Edit ~/.config/zsh/.zshrc.
# Keep this shim so `source ~/.zshrc` still works.
source "${ZDOTDIR:-$HOME/.config/zsh}/.zshrc"
