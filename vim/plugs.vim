let s:vim_path = '$VIM_PATH'
let s:dot_vim_path = s:vim_path.'/.vim'
let g:plug_timeout = 6000
call plug#begin(s:dot_vim_path.'/plugged')

" Make sure you use single quotes

" ======================================
" Project
" =======================================
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'embear/vim-localvimrc'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'gorodinskiy/vim-coloresque'
Plug 'altercation/vim-colors-solarized'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }

Plug 'itchyny/lightline.vim'
Plug 'pangloss/vim-javascript'
Plug 'kylef/apiblueprint.vim'
Plug 'fatih/vim-go'
Plug 'vim-scripts/taglist.vim'
Plug 'mattn/emmet-vim'
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-markdown'
Plug 'reedes/vim-pencil'
Plug 'junegunn/goyo.vim'
Plug 'darthmall/vim-vue'
Plug 'quramy/tsuquyomi'
Plug 'Shougo/vimproc.vim'
Plug 'easymotion/vim-easymotion'
Plug 'digitaltoad/vim-pug'


" ======================================
" Appearance
" =======================================
Plug 'troydm/zoomwintab.vim'

call plug#end()

" Source plugin settings
" ===========================
" Pup all your plugin settings in `$TERMI_PATH/vim/settings`
" Recommend per plugin per file
let plugsettings = s:vim_path.'/settings'
for fpath in split(globpath(plugsettings, '*.vim'), '\n')
" #UNCOMMENT_HOOK#  exe 'source' fpath
endfor
