" Vundle

set nocompatible
filetype off      " Required

set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage itself.
Plugin 'gmarik/vundle'

" Syntax
Plugin 'scrooloose/syntastic' " Syntax, linting, etc.
Plugin 'tmux-plugins/vim-tmux' " Vim plugin for .tmux.conf
Plugin 'jtratner/vim-flavored-markdown' " Add support for github-style fenced codeblocks in markdown
Plugin 'elzr/vim-json' " JSON syntax highlighting
Plugin 'pangloss/vim-javascript' " JavaScript syntax
Plugin '1995eaton/vim-better-javascript-completion' " An expansion of Vim's current JavaScript syntax file.
Plugin 'mxw/vim-jsx' " JSX syntax
Plugin 'moll/vim-node' " Node.js
Plugin 'othree/javascript-libraries-syntax.vim' " Syntax for JavaScript libraries.
Plugin 'facebook/vim-flow' "A vim plugin for Flow.

" Theme and syntax highlighting
Plugin 'altercation/vim-colors-solarized' " Solarized theme
Plugin 'kien/rainbow_parentheses.vim' " Better Rainbow Parentheses
Plugin 'chrisbra/Colorizer' " Clor hex codes and color names
Plugin 'Yggdroot/indentLine' " A vim plugin to display the indention levels with thin vertical lines
Plugin 'jiangmiao/auto-pairs' " Insert or delete brackets, parens, quotes in pair.
Plugin 'mattn/emmet-vim' " Expand abbreviations similar to emmit.

" Git
Plugin 'tpope/vim-fugitive' " A Git wrapper so awesome, it should be illegal.
Plugin 'airblade/vim-gitgutter' " Inline git status
Plugin 'Xuyuanp/nerdtree-git-plugin' " A plugin of NERDTree showing git status

" Utils
Plugin 'bling/vim-airline' " Better status line
Plugin 'vim-airline/vim-airline-themes' " Status line theme support
Plugin 'mileszs/ack.vim' " Search
Plugin 'scrooloose/nerdtree' " A sidebar buffer for navigating and manipulating files.
Plugin 'kien/ctrlp.vim' " Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
Plugin 'tpope/vim-surround' " Surroundings for parentheses, brackets, quotes and more.
Plugin 'tomtom/tcomment_vim' " Commenting.
Plugin 'terryma/vim-multiple-cursors' " Multiple selections.
Plugin 'matze/vim-move' " Plugin to move lines and selections up and down
Plugin 'christoomey/vim-tmux-navigator' "Seamless navigation between tmux panes and vim splits
Plugin 'Chiel92/vim-autoformat' " Provide easy code formatting in Vim by integrating existing code formatters
Plugin 'tmux-plugins/vim-tmux-focus-events' " Make terminal vim and tmux work better together.
Plugin 'tpope/vim-obsession' " Continuously updated session files.

call vundle#end()
