" Asynchronous Lint Engine (ALE)
" Limit linters used for JavaScript.
let g:ale_linters = {
\  'javascript': ['flow', 'prettier', 'eslint']
\}
let g:ale_fixers = {
\  'css': ['prettier'],
\  'markdown': ['prettier'],
\  'javascript': ['prettier', 'eslint'],
\  'typescript': ['prettier', 'tslint']
\}
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_prettier_use_local_config = 1
" let g:ale_javascript_prettier_eslint_executable = 'prettier_eslint'
" let g:ale_javascript_prettier_options = '--no-semi --single-quote --trailing-comma es5 --no-bracket-spacing --jsx-bracket-same-line'
" let g:ale_javascript_prettier_options = 'es5'
" let g:ale_javascript_prettier_eslint_use_global = 1
let g:ale_fix_on_save = 1
highlight clear ALEErrorSign " otherwise uses error bg color (typically red)
" let g:ale_sign_error = 'X' " could use emoji
" let g:ale_sign_warning = '?' " could use emoji
" let g:ale_statusline_format = ['X %d', '? %d', '']

" %linter% is the name of the linter that provided the message
" %s is the error or warning message
let g:ale_echo_msg_format = '%linter% says %s'

nnoremap <leader>ap :ALEPreviousWrap<cr>
