let s:vim_path = '$VIM_PATH'
let s:dot_vim_path = '$DOT_VIM_PATH'

let &runtimepath=join([s:dot_vim_path, &runtimepath, s:dot_vim_path . "/after"], ",")
let &packpath = &runtimepath

let s:py_path = system('pyenv which python 2>/dev/null')
if s:py_path
  let g:python3_host_prog = s:py_path
endif

exec "source " . s:vim_path . "/.vimrc"

