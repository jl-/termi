call plug#begin('~/.vim/plugged')

" ======================================
" System
" =======================================
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf'
" Plug 'yggdroot/indentline'

" =======================================
" Interface
" ======================================
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'altercation/vim-colors-solarized'

" ======================================
" PL
" =======================================
Plug 'scrooloose/syntastic'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

for fpath in split(globpath('~/.config/nvim/settings', '*.vim'), '\n')
  exe 'source' fpath
endfor

