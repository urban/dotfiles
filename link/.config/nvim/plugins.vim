" vim-plug

call plug#begin('~/.config/nvim/plugged')

" ========================================================================
" Colorscheme
" ========================================================================

" Theme and syntax highlighting
Plug 'altercation/vim-colors-solarized' " Solarized theme

" ========================================================================
" Languages agnostic
" ========================================================================

" Asynchronous maker and linter (needs linters to work)
Plug 'w0rp/ale'
" Plug 'neomake/neomake', { 'on': ['Neomake'] }
" Automatically closing pair stuff
Plug 'cohama/lexima.vim'
" Snippet support (C-j)
Plug 'SirVer/ultisnips'
" Commenting support (gc)
Plug 'tpope/vim-commentary'
" CamelCase and snake_case motions
Plug 'bkad/CamelCaseMotion'
" Heuristically set indent settings
Plug 'tpope/vim-sleuth'
" highlight matching tag
Plug 'gregsexton/MatchTag'
" add gS to smart split lines like comma lists and html tags
Plug 'AndrewRadev/splitjoin.vim'
" multiple selections
Plug 'terryma/vim-multiple-cursors'
" indenting
Plug 'nathanaelkane/vim-indent-guides'

" ========================================================================
" JS (ES6, React)
" ========================================================================

" Moder JS support (indent, syntax, etc)
Plug 'sheerun/vim-polyglot'
" Template string highlighting
Plug 'Quramy/vim-js-pretty-template'
" Plug 'pangloss/vim-javascript'
" JSX syntax
" Plug 'mxw/vim-jsx'
" " JS Documentation comments
" Plug 'heavenshell/vim-jsdoc', { 'on': ['JsDoc'] }
" JSON syntax
" Plug 'sheerun/vim-json'
" Plug 'elzr/vim-json'

" Plug 'othree/yajs.vim', { 'for': 'javascript' }
" ES Next
" Plug 'othree/es.next.syntax.vim'
" Syntax highlighting for common JS libraries
" Plug 'othree/javascript-libraries-syntax.vim'

" Typescript syntax
Plug 'leafgarland/typescript-vim'
" Styled JSX
Plug 'alampros/vim-styled-jsx'
" Autocomplete (npm install -g tern)
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install' }
" Autocomplete using flow (npm install -g flow-bin)
Plug 'steelsojka/deoplete-flow'
" Node.js tools
Plug 'moll/vim-node'

" ========================================================================
" HTML, CSS
" ========================================================================

" HTML5 syntax
Plug 'othree/html5.vim'
" SCSS syntax
Plug 'cakebaker/scss-syntax.vim'
" Color highlighter
Plug 'lilydjwg/colorizer', { 'for': ['css', 'sass', 'scss', 'less', 'html', 'xdefaults', 'javascript', 'javascript.jsx'] }

" ========================================================================
" Autocomplete
" ========================================================================

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' }
" Flow
Plug 'wokalski/autocomplete-flow'
" For func argument completion
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" ========================================================================
" Unite fuzzy searcher
" ========================================================================

" Unite files, buffers, etc. sources
Plug 'Shougo/denite.nvim'
" History/yank source
Plug 'Shougo/neoyank.vim'
" Ag wrapper (Unite grep alternative) search and edit
Plug 'dyng/ctrlsf.vim', { 'on': ['CtrlSF', 'CtrlSFToggle'] }
" Fuzzy file, buffer, mru, tag, etc finder
" Pulg 'ctrlpvim/ctrlp.vim'

" ========================================================================
" Interface improving
" ========================================================================

" Lightline (simple status line)
Plug 'itchyny/lightline.vim'
" Buffers tabline
Plug 'ap/vim-buftabline'
" A sidebar buffer for navigating and manipulating files.
Plug 'scrooloose/nerdtree'
" A plugin of NERDTree showing git status
Plug 'Xuyuanp/nerdtree-git-plugin'

" ========================================================================
" External tools integration plugins
" ========================================================================
" Fugitive
Plug 'tpope/vim-fugitive'
" Git log viewer (Gitv! for file mode)
Plug 'gregsexton/gitv', { 'on': 'Gitv' }
" Git changes showed on line numbers
Plug 'airblade/vim-gitgutter'
" REST Console
Plug 'diepm/vim-rest-console', { 'for': 'rest' }
" Color picker
Plug 'KabbAmine/vCoolor.vim', { 'on': ['VCoolor', 'VCase'] }
" Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'
" Make terminal vim and tmux work better together.
Plug 'tmux-plugins/vim-tmux-focus-events'
" Code Formatter
" Plug 'sbdchd/neoformat'

" ========================================================================
" Text insertion/manipulation
" ========================================================================
"
" Surround (cs"')
Plug 'tpope/vim-surround'
" Easy alignment
Plug 'godlygeek/tabular', { 'on':  'Tabularize' }
" Safely editing in isolation
Plug 'ferranpm/vim-isolate', { 'on':  ['Isolate', 'UnIsolate'] }
" Cycling related words via C-a C-x (i.e. true/false)
Plug 'zef/vim-cycle'
" Titlecase motion (gt)
Plug 'christoomey/vim-titlecase'

" ========================================================================
" Utils
" ========================================================================

" Creates dir if new file in new dir
Plug 'dockyard/vim-easydir'

" ========================================================================
" Other
" ========================================================================

" Intelligent buffer closing
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
" Delete all but current buffer
Plug 'vim-scripts/BufOnly.vim', { 'on': 'Bonly' }

call plug#end()
