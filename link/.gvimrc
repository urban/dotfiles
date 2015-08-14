" Use the Solarized Dark theme
" Better line-height
set background=dark
colorscheme solarized

set guifont=Monaco:h14  " Use 14pt Monaco
set linespace=8         " Better line-height

set guioptions-=r       " Remove right-hand scrollbar
set guioptions-=R       " Remove right-hand scrollbar on split
set guioptions-=l       " Remove left-hand scrollbar
set guioptions-=L       " Remove left-hand scrollbar on split

" esc in normal mode clears search highlighting
nnoremap <silent> <esc> :nohl<cr><esc>
