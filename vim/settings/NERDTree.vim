" Make nerdtree look nice
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30
let NERDTreeShowHidden = 1

" open NERDTree on VimEnter
function! s:OpenNERDTree()
  if 0 == argc() && exists(':NERDTree')
    NERDTree
  end
endfunction

autocmd VimEnter * call s:OpenNERDTree()
