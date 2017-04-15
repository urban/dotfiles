" Solarized Dark theme
let g:solarized_underline=0       " default value is 1
let g:solarized_termtrans=1       " default value is 0
let g:solarized_termcolors=256    " default value is 16
" let g:solarized_contrast="high"   " default value is normal
" let g:solarized_visibility="high" " default value is normal
colorscheme solarized
set background=dark

set shell=/bin/bash
" Behaviors
set nocompatible        " Disable vi compatibility.
set noswapfile          " Disable swaps.
set nowritebackup       " Even if you did make a backup, don't keep it around.
set nobackup            " Disable backups.
set autoread            " Automatically reload changes if detected.
set wildmenu            " Turn on Wild menu.
set hidden              " Change buffer - without saving.
set history=256         " Number of things to remember in history.
set clipboard=unnamed  " Use the OS clipboard by default.
set autowrite           " Writes on make/shell commands
set timeoutlen=250      " Time to wait after ESC
" set scrolloff=3         " Keep three lines below the last line when
set gdefault            " Makes search/replace global by default.
set virtualedit=block   " Enable rectangular selections.
set nospell             " Disable spell checking.
set visualbell          " Don't beep.
set noerrorbells        " Don't beep.
" leave insert mode quickly
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

" Folding
" set nofoldenable        " Disable folding entirely.
set foldmethod=marker     " Markers are used to specify folds.
set foldlevel=2           " Start folding automatically from level 2
set fillchars="fold: "    " Characters to fill the statuslines and vertical separators
" Stay down after creating fold
vnoremap zf mzzf`zzz
" Easier fold toggling
nnoremap ,z za

" Text Format
set tabstop=2           " Set the default tabstop.
set softtabstop=2
set backspace=indent,eol,start " Delete everything with backspace
set shiftwidth=2        " Set the default shift width for indents.
set expandtab           " Make tabs into spaces (set by tabstop).
set smarttab            " Smarter tab levels.
set autoindent          " Always autoindent.
set copyindent          " Copy the previous indentation on autoindenting.
set cindent
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do,for,switch,case

" Match and search
set ignorecase          " Ignore case of searches.
set smartcase           " Be sensitive when there's a capital letter.
set hlsearch            " Highlight search.
set incsearch           " Highlight dynamically as pattern is typed.
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,
  \.sass-cache,*.class,*.scssc,*.cssc,sprockets%*,*.lessc,*/node_modules/*,
  \rake-pipeline-*

" Visual
" set guifont=Source:h14  " Set the font and font size
set guifont=Sauce\ Code\ Powerline\ Plus\ Nerd\ File\ Types\ Mono:h11
set number              " Enable line numbers.
set ruler               " Ruler on.
set nowrap              " Line wrapping off.
set laststatus=2        " Always show statusline.
set cmdheight=2         " Make the command area two lines high.
set encoding=utf-8
set noshowmode          " Don't show the mode since Powerline shows it.
set title               " Set the title of the window in Terminal to the file.
if exists('+colorcolumn')
  set colorcolumn=80    " Color the 80th column differently as a wrapping guide.
endif
set showmatch           " Show matching brackets.
set nolist              " Display unprintable characters f12 - switches
set listchars=""        " Reset the listchars.
set listchars=tab:▸\    " Make tabs visible.
set listchars+=trail:·  " Show trailing spaces.
set listchars+=eol:¬    " Show end of line.
set listchars+=nbsp:_   " Show non-breaking spaces.
set list                " Show invisible characters
set splitbelow          " Open new split panes to the bottom
set splitright          " Open new split panes to the right

" Mouse
set mousehide           " Hide mouse after chars typed.
set mouse=a             " Enable mouse in all modes.

" Mac support bootstrap
set wildignore+=*.DS_Store
set wildignore+=*/_build**
