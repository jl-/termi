let s:vim_path = '$VIM_PATH'
let s:dot_vim_path = '$DOT_VIM_PATH'

let &runtimepath=join([s:dot_vim_path, &runtimepath, s:dot_vim_path . "/after"], ",")
let &packpath = &runtimepath

exec "source " . s:vim_path . "/.vimrc"
