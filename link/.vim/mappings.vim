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
