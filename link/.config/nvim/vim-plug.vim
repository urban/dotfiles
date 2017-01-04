" vim-plug

call plug#begin('~/.config/nvim/plugged')

" Theme and syntax highlighting
Plug 'altercation/vim-colors-solarized' " Solarized theme

" Git
Plug 'airblade/vim-gitgutter' " Inline git status
Plug 'Xuyuanp/nerdtree-git-plugin' " A plugin of NERDTree showing git status

" Utils
Plug 'bling/vim-airline' " Better status line
Plug 'vim-airline/vim-airline-themes' " Status line theme support
Plug 'scrooloose/nerdtree' " A sidebar buffer for navigating and manipulating files.
Plug 'christoomey/vim-tmux-navigator' "Seamless navigation between tmux panes and vim splits
Plug 'tmux-plugins/vim-tmux-focus-events' " Make terminal vim and tmux work better together.

call plug#end()
