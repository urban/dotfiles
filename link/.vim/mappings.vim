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

" ---------------
" Insert Mode Mappings
" ---------------

" Let's make escape better, together.
inoremap kj <Esc>
inoremap KJ <Esc>
inoremap Kj <Esc>
inoremap kJ <Esc>

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Map auto complete of (, ", ', [, {
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i
