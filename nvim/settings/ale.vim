let g:ale_linter_aliases = {
\  'vue': ['vue', 'javascript']
\}

let g:ale_linters = {
\  'vue': ['prettier'],
\  'javascript': ['prettier']
\}

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\}

let g:ale_fix_on_save = 0
let g:ale_lint_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_completion_enabled = 1
