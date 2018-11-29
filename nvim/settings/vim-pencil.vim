let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'
let g:pencil#textwidth = 100


augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END
