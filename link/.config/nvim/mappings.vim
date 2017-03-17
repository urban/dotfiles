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

" Close current buffer
nnoremap <leader>bd :Bclose<cr>
" Close all buffers
nnoremap <leader>ba :1,1000 bd!<cr>

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
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $3 {}<esc>i

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
