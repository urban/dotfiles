augroup filetypes
  autocmd!

  autocmd BufReadPost,BufNewFile *.mkd set filetype=markdown
  autocmd BufReadPost,BufNewFile *.md set filetype=markdown
  autocmd BufReadPost,BufNewFile *.csx set filetype=cs
  autocmd BufReadPost,BufNewFile *.txt set filetype=text

augroup END
