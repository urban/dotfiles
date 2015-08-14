augroup filetypes
  au!

  au BufRead,BufNewFile *.mkd setlocal filetype=markdown
  au BufRead,BufNewFile *.md setlocal filetype=markdown
  au BufRead,BufNewFile *.csx setlocal filetype=cs
  au BufRead,BufNewFile *.txt setlocal filetype=text

augroup END
