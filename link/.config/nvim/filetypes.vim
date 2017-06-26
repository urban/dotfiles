" Enable syntax highlighting
syntax on
" Enable filetype specific plugin rules
filetype plugin on
" Enable filetype specific indenting rules
filetype indent on

autocmd FileType javascript JsPreTmpl html
"Set 2 indent for html
autocmd FileType html,javascript setlocal sw=2 sts=2 ts=2

augroup filetypes
  autocmd!

  autocmd BufReadPost,BufNewFile *.mkd set filetype=markdown
  autocmd BufReadPost,BufNewFile *.md set filetype=markdown
  autocmd BufReadPost,BufNewFile *.txt set filetype=text
  autocmd BufReadPost,BufNewFile *.flow set filetype=javascript

  autocmd BufNewFile,BufRead,BufWrite *.md syntax match Comment /\%^---\_.\{-}---$/

  " autocmd! BufWritePost *.js silent! Neomake
  " " yarn global add jsonlint
  " autocmd BufWritePost *.json Neomake jsonlint
  " " yarn global add typescript
  " autocmd BufWritePost *.ts Neomake tsc
  " " brew install tidy-html5
  " autocmd BufWritePost *.html Neomake tidy
  " " yarn global add scss-lint
  " autocmd BufWritePost *.scss Neomake sasslint
  " " brew install shellcheck
  " autocmd BufWritePost *.sh Neomake shellcheck

augroup END
