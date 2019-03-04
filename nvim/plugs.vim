let g:plug_timeout = 6000
let s:vim_path = "~/.config/nvim"
call plug#begin(s:vim_path.'/plugged')

" ======================================
" System
" =======================================
" Plug 'embear/vim-localvimrc'
Plug 'matze/vim-move'
Plug 'godlygeek/tabular'
Plug 'easymotion/vim-easymotion'
Plug 'Shougo/vimproc.vim'
Plug 'yggdroot/indentline'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'w0rp/ale'

" ======================================
" Interface
" =======================================
Plug 'scrooloose/nerdtree'
Plug 'troydm/zoomwintab.vim'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'reedes/vim-pencil'
Plug 'junegunn/goyo.vim'

" ======================================
" PL
" =======================================
Plug 'scrooloose/syntastic'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'
Plug 'fatih/vim-go'
Plug 'tpope/vim-markdown'
Plug 'posva/vim-vue'
" Plug 'gorodinskiy/vim-coloresque'
Plug 'ap/vim-css-color'
Plug 'pangloss/vim-javascript'
Plug 'digitaltoad/vim-pug'
" Plug 'kylef/apiblueprint.vim'
Plug 'vim-scripts/taglist.vim'
Plug 'leafgarland/typescript-vim'
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" ======================================

call plug#end()

" Source plugin settings
" ===========================
" Pup all plugin settings
let plugsettings = s:vim_path.'/settings'
for fpath in split(globpath(plugsettings, '*.vim'), '\n')
  exe 'source' fpath
endfor
