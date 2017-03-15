" .vimrc
"
" More info:
"  - https://github.com/urban/dotfiles
"
" Author:
"  - Urban Faubion (urban.faubion@gmail.com)
"
" Licensed under MIT
" Copyright (c) 2015 Urban Faubion (urban.faubion@gmail.com)
"
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

source ~/.config/nvim/vim-plug.vim  " Install plugins
source ~/.config/nvim/config.vim    " Regular Vim configuration (no plugins needed).
source ~/.vim/mappings.vim  " All hotkeys, not dependant on plugins.
source ~/.config/nvim/filetypes.vim " Load filetypes.
source ~/.config/nvim/plugins.vim   " Load plugin specific configurations.
source ~/.vim/vimrcex.vim   " Load auto commands.
