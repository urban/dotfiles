" Vundle

set nocompatible
filetype off      " Required

set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage itself.
Plugin 'gmarik/vundle'

" Solarized theme
Plugin 'altercation/vim-colors-solarized'

" Better status line
Plugin 'bling/vim-airline'

" A sidebar buffer for navigating and manipulating files.
Plugin 'scrooloose/nerdtree'

" Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
Plugin 'kien/ctrlp.vim'

" Surroundings for parentheses, brackets, quotes and more.
Plugin 'tpope/vim-surround'

" Insert or delete brackets, parens, quotes in pair.
Plugin 'jiangmiao/auto-pairs'

" Commenting.
Plugin 'scrooloose/nerdcommenter'

" Multiple selections.
Plugin 'terryma/vim-multiple-cursors'

" A Git wrapper so awesome, it should be illegal.
Plugin 'tpope/vim-fugitive'

" Text filtering and alignment.
Plugin 'godlygeek/tabular'

" Add support for github-style fenced codeblocks in markdown
Plugin 'jtratner/vim-flavored-markdown'

" Syntax, linting, etc.
Plugin 'scrooloose/syntastic'

" JavaScript syntax
Plugin 'pangloss/vim-javascript'

" Enchanced JavaScript Syntax
Plugin 'jelera/vim-javascript-syntax'

" Node.js
Plugin 'moll/vim-node'

" Expand abbreviations similar to emmit.
Plugin 'mattn/emmet-vim'

" JSON syntax highlighting
Plugin 'leshill/vim-json'

" Inline git status
Plugin 'airblade/vim-gitgutter'

" JSX syntax
Plugin 'mxw/vim-jsx'

call vundle#end()
