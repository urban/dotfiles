" vim-plug

call plug#begin('~/.config/nvim/plugged')

" Vim Defaults
Plug 'tpope/vim-sensible'
" Mappings
Plug 'tpope/vim-unimpaired'

" ========================================================================
" Colorscheme
" ========================================================================

" Theme and syntax highlighting
Plug 'altercation/vim-colors-solarized' " Solarized theme

" ========================================================================
" Languages
" ========================================================================

" Asynchronous maker and linter (needs linters to work)
Plug 'w0rp/ale'
" Language support (indent, syntax, etc)
Plug 'sheerun/vim-polyglot'
" Template string highlighting
Plug 'Quramy/vim-js-pretty-template'
" Markdown
Plug 'plasticboy/vim-markdown'

" ========================================================================
" Autocomplete
" ========================================================================

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" ========================================================================
" Unite fuzzy searcher
" ========================================================================

" Fuzzy Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" ========================================================================
" Interface improving
" ========================================================================

" Lightline (simple status line)
Plug 'itchyny/lightline.vim'
" A sidebar buffer for navigating and manipulating files.
Plug 'scrooloose/nerdtree'
" A plugin of NERDTree showing git status
Plug 'Xuyuanp/nerdtree-git-plugin'
" indenting
Plug 'nathanaelkane/vim-indent-guides'

" ========================================================================
" External tools integration plugins
" ========================================================================
" Git
Plug 'tpope/vim-fugitive'
" Git changes showed on line numbers
Plug 'airblade/vim-gitgutter'
" Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'
" Make terminal vim and tmux work better together.
Plug 'tmux-plugins/vim-tmux-focus-events'
"
" ========================================================================
" Utils
" ========================================================================

" Surround (cs"')
Plug 'tpope/vim-surround'
" Commenting support (gc)
Plug 'tpope/vim-commentary'
" Easy alignment
Plug 'godlygeek/tabular', { 'on':  'Tabularize' }
" Creates dir if new file in new dir
Plug 'dockyard/vim-easydir'

" ========================================================================
" Other
" ========================================================================

" Intelligent buffer closing
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }

call plug#end()
