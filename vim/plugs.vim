let s:vim_path = '$VIM_PATH'
let s:dot_vim_path = s:vim_path.'/.vim'
let g:plug_timeout = 6000
call plug#begin(s:dot_vim_path.'/plugged')

" ======================================
" System
" =======================================
Plug 'embear/vim-localvimrc'
Plug 'matze/vim-move'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'easymotion/vim-easymotion'
Plug 'Shougo/vimproc.vim'

" ======================================
" Interface
" =======================================
Plug 'scrooloose/nerdtree'
Plug 'troydm/zoomwintab.vim'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'reedes/vim-pencil'
Plug 'junegunn/goyo.vim'
Plug 'flazz/vim-colorschemes'

" ======================================
" PL
" =======================================
Plug 'scrooloose/syntastic'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'
Plug 'fatih/vim-go'
Plug 'tpope/vim-markdown'
Plug 'darthmall/vim-vue'
Plug 'gorodinskiy/vim-coloresque'
Plug 'pangloss/vim-javascript'
Plug 'digitaltoad/vim-pug'
Plug 'kylef/apiblueprint.vim'
Plug 'vim-scripts/taglist.vim'
Plug 'quramy/tsuquyomi'
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }

" ======================================

call plug#end()

" Source plugin settings
" ===========================
" Pup all your plugin settings in `$TERMI_PATH/vim/settings`
" Recommend per plugin per file
let plugsettings = s:vim_path.'/settings'
for fpath in split(globpath(plugsettings, '*.vim'), '\n')
" #UNCOMMENT_HOOK#  exe 'source' fpath
endfor
