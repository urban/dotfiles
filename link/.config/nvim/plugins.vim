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

" highlight matching html tag
Plug 'gregsexton/MatchTag'
" add gS to smart split lines like comma lists and html tags
Plug 'AndrewRadev/splitjoin.vim'
" Async make and linting framework
Plug 'neomake/neomake'

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
" Utils
" ========================================================================

" Better status line
Plug 'bling/vim-airline'

" Status line theme support
Plug 'vim-airline/vim-airline-themes'

" A sidebar buffer for navigating and manipulating files.
Plug 'scrooloose/nerdtree'

" Inline git status
Plug 'airblade/vim-gitgutter'

" A plugin of NERDTree showing git status
Plug 'Xuyuanp/nerdtree-git-plugin'

"Commenting.
Plug 'scrooloose/nerdcommenter'

" Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'

" Make terminal vim and tmux work better together.
Plug 'tmux-plugins/vim-tmux-focus-events'

" Creates dir if new file in new dir
Plug 'dockyard/vim-easydir'

call plug#end()

" Source all the plugin files again, this time loading their configuration.
for file in split(glob('~/.config/nvim/plugins/*.vim'), '\n')
  exe 'source' file
endfor
