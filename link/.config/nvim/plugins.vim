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
Plug 'neomake/neomake', { 'on': ['Neomake'] }
" Autocomplete
Plug 'Shougo/deoplete.nvim'
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

" ========================================================================
" JS (ES6, React)
" ========================================================================

" Moder JS support (indent, syntax, etc)
Plug 'pangloss/vim-javascript'
" JSX syntax
Plug 'mxw/vim-jsx'
" Typescript syntax
Plug 'leafgarland/typescript-vim'
" JSON syntax
Plug 'sheerun/vim-json'
" Autocomplete (npm install -g tern)
Plug 'carlitux/deoplete-ternjs'
" Autocomplete using flow (npm install -g flow-bin)
Plug 'steelsojka/deoplete-flow'
" JS Documentation comments
Plug 'heavenshell/vim-jsdoc', { 'on': ['JsDoc'] }

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
" Unite fuzzy searcher
" ========================================================================

" History/yank source
Plug 'Shougo/neoyank.vim'

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

call plug#end()

" Source all the plugin files again, this time loading their configuration.
for file in split(glob('~/.config/nvim/plugins/*.vim'), '\n')
  exe 'source' file
endfor
