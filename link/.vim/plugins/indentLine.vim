let g:indentLine_enabled = 0
let g:indent_guides_auto_colors = 0
let g:indentLine_color_term = 236
let g:indentLine_char = '|'
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
