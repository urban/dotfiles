
" Colors
colorscheme molokai
let g:monokai_italic = 1

" File Locations
set backupdir=~/.vim/backups// " Double // causes backups to use full file path
set directory=~/.vim/swaps//
if exists("&undodir")
  set undodir=~/.vim/undo
endif
set backupskip=/tmp/*,/private/tmp/* " Don’t create backups when editing files in certain directories.

" UI
set ruler               " Ruler on.
set number              " Line numbers on.
set nowrap              " Line wrapping off.
set laststatus=2        " Always show statusline.
set cmdheight=2         " Make the command area two lines high.
set encoding=utf-8
set noshowmode          " Don't show the mode since Powerline shows it.
set title               " Set the title of the window in Terminal to the file.
if exists('+colorcolumn')
  set colorcolumn=80    " Color the 80th column differently as a wrapping guide.
endif

" Behaviors
syntax enable           " Enable syntax highlighting.
set nocompatible        " Disable vi compatibility.
set backup              " Turn on backups.
set autoread            " Automatically reload changes if detected.
set wildmenu            " Turn on Wild menu.
set hidden              " Change buffer - without saving.
set history=256         " Number of things to remember in history.
set clipboard+=unnamed  " Use the OS clipboard by default.
set autowrite           " Writes on make/shell commands
set timeoutlen=250      " Time to wait after ESC
set nofoldenable        " Disable folding entirely.
set scrolloff=3         " Keep three lines below the last line when
set gdefault            " Makes search/replace global by default.

" Text Format
set tabstop=2           " Set the default tabstop.
set softtabstop=2
set backspace=indent,eol,start " Delete everything with backspace
set shiftwidth=2        " Set the default shift width for indents.
set expandtab           " Make tabs into spaces (set by tabstop).
set smarttab            " Smarter tab levels.
set autoindent
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
set guifont=Monaco:h15  " Set the font and font size
set number              " Enable line numbers.
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
