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
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

source ~/.vim/vim-plug.vim  " Install plugins
" source ~/.vim/vundle.vim    " Install Vundle plugins.
source ~/.vim/config.vim    " Regular Vim configuration (no plugins needed).
source ~/.vim/mappings.vim  " All hotkeys, not dependant on plugins.
source ~/.vim/filetypes.vim " Load filetypes.
source ~/.vim/plugins.vim   " Load plugin specific configurations.
source ~/.vim/vimrcex.vim   " Load auto commands.
