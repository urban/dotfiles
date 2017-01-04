function! HasConfig(file, dir)
  return findfile(glob(a:file), escape(a:dir, ' ') . ';') !=# ''
endfunction

function! HasConfigJs()
  let checkers = []
  " eslintrc files could have json or yml suffix
  if HasConfig('.eslintrc', expand('<amatch>:h'))
    call add(checkers, 'eslint')
  endif
  if HasConfig('.jshintrc', expand('<amatch>:h'))
    call add(checkers, 'jshint')
  endif
  if HasConfig('.jscsrc', expand('<amatch>:h'))
    call add(checkers, 'jscs')
  endif
  " default to standard
  if !len(checkers)
    call add(checkers, 'standard')
  endif
  return checkers
endfunction

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Use ESLint as JavaScript syntax checker.
let g:syntastic_javascript_checkers = ['eslint', 'standard']

let g:syntastic_aggregate_errors = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '!'

noremap <leader>t :SyntasticToggleMode<CR>

" Point syntastic checker at locally installed `eslint` if it exists.
if executable('node_modules/.bin/eslint')
  let b:syntastic_javascript_eslint_exec = 'node_modules/.bin/eslint'
endif

augroup syntasticjs
  autocmd!
  autocmd BufNewFile,BufReadPre *.js let b:syntastic_checkers = HasConfigJs()
augroup END
