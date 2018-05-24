" Mappings
"

" Set leader to ,
" Note: This line MUST come before any <leader> mappings

let mapleader=","
let maplocalleader = "\\"

" ---------------
" Regular Mappings
" ---------------

" Use ; for : in normal and visual mode, less keystrokes
nnoremap ; :
vnoremap ; :

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Buffers navigation and management
nnoremap <silent> + :bn<CR>
nnoremap <silent> _ :bp<CR>

" Quick save and close buffer
nnoremap <leader>w :w<CR>
nnoremap <silent> <leader>c :Sayonara!<CR>
nnoremap <silent> <leader>q :Sayonara<CR>

" Don't yank to default register when changing something
nnoremap c "xc
xnoremap c "xc

" After block yank and paste, move cursor to the end of operated text and don't override register
vnoremap y y`]
vnoremap p "_dP`]
nnoremap p p`]

" Yank and paste from clipboard
nnoremap ,y "+y
vnoremap ,y "+y
nnoremap ,yy "+yy
nnoremap ,p "+p

" ---------------
" NeoVim Hacks
" ---------------

" Fix NeoVim issues with <Ctr-H> on OSX
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>


" ---------------
" Insert Mode Mappings
" ---------------

" Let's make escape better, together.
inoremap kj <Esc>
inoremap KJ <Esc>
inoremap Kj <Esc>
inoremap kJ <Esc>

" Map auto complete of (, ", ', [, {
inoremap $1 ()<Esc>i
inoremap $2 []<Esc>i
inoremap $3 {}<Esc>i
inoremap $4 {<Esc>o}<Esc>O
inoremap $q ''<Esc>i
inoremap $e ""<Esc>i
inoremap $3 {}<Esc>i

" ---------------
" Visual Mode Mappings
" ---------------

" Search for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" ---------------
" Fix cursor in TMUX
" ---------------
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
