call plug#begin('~/.local/share/nvim/plugged')
Plug 'mhartington/oceanic-next'
Plug 'christoomey/vim-tmux-navigator'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'jparise/vim-graphql'
call plug#end()

" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" Themes
syntax on
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext

set autoindent
set autoread
set background=light
set backspace=eol,indent,start
set backupdir=$HOME/.vim/backups
set bufhidden=hide
set colorcolumn=+1
set completeopt+=menuone,longest
set copyindent
set cursorline
set directory=$HOME/.vim/swapfiles
set display=lastline
set eadirection=both
set encoding=utf-8
set expandtab
set formatoptions+=n
set grepprg=rg\ --vimgrep
set history=1000
set hlsearch
set incsearch
set laststatus=2
set listchars+=tab:>\ ,trail:-,eol:ϟ
set list
set nowrap
set number
set relativenumber
set ruler
set shiftround
set shiftwidth=2
set shortmess+=I
set showcmd
set showmatch
set smarttab
set softtabstop=2
set spell spelllang=en_gb
set splitbelow
set splitright
set suffixes+=.git,.stack-work,-doc-http.html
set tabstop=2
set termguicolors
set textwidth=79
set ttyfast
set wildignore+=.git,.stack-work,*-doc-http.html,bower_components,node_modules
set wildmenu
set wildmode+=list,longest

map <Leader>s :grep<Space>
nnoremap <Leader>p :FZF <CR>
nnoremap <silent> <C-N> :cn<CR>zv
nnoremap <silent> <C-P> :cp<CR>zv
