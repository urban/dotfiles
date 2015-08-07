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

source ~/.vim/vundle.vim    " Install Vundle plugins.
filetype plugin indent on   " Automatically detect file types.

source ~/.vim/config.vim    " Regular Vim configuration (no plugins needed).
source ~/.vim/mappings.vim  " All hotkeys, not dependant on plugins.
source ~/.vim/plugins.vim   " Load plugin specific configurations.
