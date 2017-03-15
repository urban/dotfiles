syntax enable           " Enable syntax highlighting.
filetype plugin on      " Enable filetype specific plugin rules
filetype indent on      " Enable filetype specific indenting rules

augroup filetypes
  autocmd!

  autocmd BufReadPost,BufNewFile *.mkd set filetype=markdown
  autocmd BufReadPost,BufNewFile *.md set filetype=markdown
  autocmd BufReadPost,BufNewFile *.txt set filetype=text
  autocmd BufReadPost,BufNewFile *.flow set filetype=javascript

  autocmd BufNewFile,BufRead,BufWrite *.md syntax match Comment /\%^---\_.\{-}---$/

augroup END
