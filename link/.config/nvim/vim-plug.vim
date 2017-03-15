" vim-plug

call plug#begin('~/.config/nvim/plugged')

" ========================================================================
" Colorscheme
" ========================================================================

" Theme and syntax highlighting
Plug 'altercation/vim-colors-solarized' " Solarized theme

" ========================================================================
" Input, syntax, spacing
" ========================================================================

" highlight matching html tag
Plug 'gregsexton/MatchTag'

" add gS to smart split lines like comma lists and html tags
Plug 'AndrewRadev/splitjoin.vim'

" Async make and linting framework
Plug 'neomake/neomake'

" Javascript
Plug 'pangloss/vim-javascript'
" Plug 'othree/yajs.vim'

" JSX support for React
Plug 'mxw/vim-jsx'

" JSON
Plug 'elzr/vim-json'

" ========================================================================
" Utils
" ========================================================================

" Inline git status
Plug 'airblade/vim-gitgutter'

" A plugin of NERDTree showing git status
Plug 'Xuyuanp/nerdtree-git-plugin'


" Better status line
Plug 'bling/vim-airline'

" Status line theme support
Plug 'vim-airline/vim-airline-themes'

" A sidebar buffer for navigating and manipulating files.
Plug 'scrooloose/nerdtree'

"Commenting.
Plug 'scrooloose/nerdcommenter'

"Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'

" Make terminal vim and tmux work better together.
Plug 'tmux-plugins/vim-tmux-focus-events'

" Creates dir if new file in new dir
Plug 'dockyard/vim-easydir'

call plug#end()
