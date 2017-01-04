" vim-plug

call plug#begin('~/.vim/plugged')

" Let Vundle manage itself.
Plug 'gmarik/vundle'

" Syntax
Plug 'scrooloose/syntastic' " Syntax, linting, etc.
Plug 'tmux-plugins/vim-tmux' " Vim plugin for .tmux.conf
Plug 'jtratner/vim-flavored-markdown' " Add support for github-style fenced codeblocks in markdown
Plug 'elzr/vim-json' " JSON syntax highlighting
Plug 'pangloss/vim-javascript' " JavaScript syntax
Plug '1995eaton/vim-better-javascript-completion' " An expansion of Vim's current JavaScript syntax file.
Plug 'mxw/vim-jsx' " JSX syntax
Plug 'moll/vim-node' " Node.js
Plug 'othree/javascript-libraries-syntax.vim' " Syntax for JavaScript libraries.
Plug 'facebook/vim-flow' "A vim plugin for Flow.

" Theme and syntax highlighting
Plug 'altercation/vim-colors-solarized' " Solarized theme
Plug 'kien/rainbow_parentheses.vim' " Better Rainbow Parentheses
Plug 'chrisbra/Colorizer' " Clor hex codes and color names
Plug 'Yggdroot/indentLine' " A vim plugin to display the indention levels with thin vertical lines
Plug 'jiangmiao/auto-pairs' " Insert or delete brackets, parens, quotes in pair.
Plug 'mattn/emmet-vim' " Expand abbreviations similar to emmit.

" Git
Plug 'tpope/vim-fugitive' " A Git wrapper so awesome, it should be illegal.
Plug 'airblade/vim-gitgutter' " Inline git status
Plug 'Xuyuanp/nerdtree-git-plugin' " A plugin of NERDTree showing git status

" Utils
Plug 'bling/vim-airline' " Better status line
Plug 'vim-airline/vim-airline-themes' " Status line theme support
Plug 'mileszs/ack.vim' " Search
Plug 'scrooloose/nerdtree' " A sidebar buffer for navigating and manipulating files.
Plug 'kien/ctrlp.vim' " Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
Plug 'tpope/vim-surround' " Surroundings for parentheses, brackets, quotes and more.
Plug 'tomtom/tcomment_vim' " Commenting.
Plug 'terryma/vim-multiple-cursors' " Multiple selections.
Plug 'matze/vim-move' " Plugin to move lines and selections up and down
Plug 'christoomey/vim-tmux-navigator' "Seamless navigation between tmux panes and vim splits
Plug 'Chiel92/vim-autoformat' " Provide easy code formatting in Vim by integrating existing code formatters
Plug 'tmux-plugins/vim-tmux-focus-events' " Make terminal vim and tmux work better together.
Plug 'tpope/vim-obsession' " Continuously updated session files.

call plug#end()
