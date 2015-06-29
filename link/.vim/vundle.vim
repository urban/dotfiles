" Vundle

set nocompatible
filetype off      " Required

set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage itself.
Plugin 'gmarik/vundle'

" Monokai theme
Plugin 'crusoexia/vim-monokai'

" Better status line
Plugin 'bling/vim-airline'

" A sidebar buffer for navigating and manipulating files.
Plugin 'scrooloose/nerdtree'

" Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
Plugin 'kien/ctrlp.vim'

" Surroundings for parentheses, brackets, quotes and more.
Plugin 'tpope/vim-surround'

" Multiple selections.
Plugin 'terryma/vim-multiple-cursors'

" Text filtering and alignment.
Plugin 'godlygeek/tabular'

" Markdown syntax
Plugin 'tpope/vim-markdown'

" Add support for github-style fenced codeblocks in markdown
Plugin 'jtratner/vim-flavored-markdown'

" Syntax, linting, etc.
Plugin 'scrooloose/syntastic'

" JavaScript syntax
Plugin 'pangloss/vim-javascript'

" Expand abbreviations similar to emmit.
Plugin 'mattn/emmet-vim'

" JSON syntax highlighting
Plugin 'leshill/vim-json'

" Inline git status
Plugin 'airblade/vim-gitgutter'

call vundle#end()
