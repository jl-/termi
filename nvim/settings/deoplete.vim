let g:deoplete#enable_at_startup = 1

" C-n: next option
" C-p: previous option
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
