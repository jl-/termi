#! /bin/bash
set -e

################################## utils
# . "$(dirname $0)/utils.sh"
# @param: target, item1, ..., itemn
function is_in_array() {
  local target=$1; shift
  local item
  for item; do
    [ $item == $target ] && return 0
  done
  return 1
}

# @param: question, question_warning, allowed_answer1, ...allowed_answern
function ask_question() {
  local readonly question=$1; shift
  local readonly question_warning=${1:-$question}; shift
  local readonly allowed_answers=${@}
  local answer

  printf '%b ' 1>&2 $question
  read answer
  while ! $(is_in_array $answer $allowed_answers); do
    printf '%b ' 1>&2 $question_warning
    read answer
  done

  echo $answer
}

# @param: question, question_warning
function confirm() {
  local readonly question="$1 [Y/N]"
  local readonly question_warning="${2:-$1} [Y/N]"
  local readonly answer=$(ask_question "$question" "$question_warning" Y N)
  [ $answer == 'Y' ] && return 0 || return 1
}
###################################### end: utils




# Installation path defaults to `$HOME/.termi`
# You may custom this by setting `TERMI_PATH`:
# `export TERMI_PATH="some path"; sh -c "$(curl -fsSL https://raw.github.com/jl-/termi/master/install.sh)"`
: ${TERMI_PATH:=${HOME}/.termi}

# Suffix used to back up existed files
TERMI_BAK='.pre-termi'

function main() {
  # If already installed, ask whether to reinstall
  if [ -d ${TERMI_PATH} ]; then
    echo -e "\033[33mTERMI is already installed in ${TERMI_PATH}.\033[0m"
    if confirm '\e[5;31mReinstall?\e[0m'; then
      uninstall_termi
    else
      echo 'Aborted.'
      exit
    fi
  fi

  echo -e "\033[32mInstalling TERMI Into ${TERMI_PATH} ...\033[0m"

  # git clone http://github.com/jl-/termi.git ${TERMI_PATH}
  # cd ${TERMI_PATH}

  # for dev
  # @TODO remove when released
  cp -R $HOME/termi $HOME/.termi

  with_brew
  local _with_oh_my_zsh=false _with_vim=false _with_nvim=false _with_tmux=false _with_git=false
  confirm '\e[32mwith oh-my-zsh?\e[0m' && _with_oh_my_zsh=true
  confirm '\e[32mwith vim?\e[0m' && _with_vim=true
  confirm '\e[32mwith nvim?\e[0m' && _with_nvim=true
  confirm '\e[32mwith tmux?\e[0m' && _with_tmux=true
  confirm '\e[32mwith git?\e[0m' && _with_git=true

  [ ${_with_oh_my_zsh} == true ] && with_oh_my_zsh
  [ ${_with_vim} == true ] && with_vim
  [ ${_with_nvim} == true ] && with_nvim
  [ ${_with_tmux} == true ] && with_tmux
  [ ${_with_git} == true ] && with_git

  echo -e "\033[32mTERMI installed into ${TERMI_PATH}.\033[0m"
}

function uninstall_termi() {
  [ -s ${HOME}/.zshrc${TERMI_BAK} ] && mv ${HOME}/.zshrc${TERMI_BAK} ${HOME}/.zshrc

  [ -d ${HOME}/.vim${TERMI_BAK} ] && mv ${HOME}/.vim${TERMI_BAK} ${HOME}/.vim
  [ -s ${HOME}/.vimrc${TERMI_BAK} ] && mv ${HOME}/.vimrc${TERMI_BAK} ${HOME}/.vimrc

  [ -s ${HOME}/.tmux.conf${TERMI_BAK} ] && mv ${HOME}/.tmux.conf${TERMI_BAK} ${HOME}/.tmux.conf

  [ -s ${HOME}/.gitconfig${TERMI_BAK} ] && mv ${HOME}/.gitconfig${TERMI_BAK} ${HOME}/.gitconfig
  [ -s ${HOME}/.gitignore${TERMI_BAK} ] && mv ${HOME}/.gitignore${TERMI_BAK} ${HOME}/.gitignore

  [ -d ${TERMI_PATH} ] && rm -rf ${TERMI_PATH}
}

function with_brew() {
  if ! hash brew &>/dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

function with_oh_my_zsh() {
  local readonly OH_MY_ZSH_PATH=${TERMI_PATH}/zsh/oh-my-zsh
  local readonly ZSHRC_PATH=${TERMI_PATH}/zsh/.zshrc
  local readonly PRE_ZSHRC_HOOK='#PRE_ZSHRC_HOOK#'

  git clone git://github.com/robbyrussell/oh-my-zsh.git ${OH_MY_ZSH_PATH}

  # Back up existed zsh configuation files
  if [ -s ${HOME}/.zshrc ]; then
    mv ${HOME}/.zshrc ${HOME}/.zshrc${TERMI_BAK}

    # source previous .zshrc
    sed -i '' -e "/${PRE_ZSHRC_HOOK}/ a\\
    . ${HOME}/.zshrc${TERMI_BAK}
    " ${ZSHRC_PATH}
  fi

  # Export ZSH for oh-my-zsh
  sed -i '' -e "/^export ZSH=/ c\\
  export ZSH=${OH_MY_ZSH_PATH}
  " ${ZSHRC_PATH}

  # Copy current PATH to .zshrc
  #sed -i '' -e "/#EXPOSE PATH#/ a\\
  #export PATH=${PATH}
  #" ${ZSHRC_PATH}

  # Link zshrc
  ln -sf ${ZSHRC_PATH} ${HOME}/.zshrc

  # If not using zsh, then set
  if [[ ! $SHELL =~ zsh$ ]]; then
    if hash chsh &>/dev/null; then
      chsh -s $(grep /zsh$ /etc/shells | tail -1)
    fi
  fi
}

function with_vim() {
  local UNCOMMENT_HOOK='" #UNCOMMENT_HOOK#'
  local INJECTION_HOOK='#INJECTION_HOOK#'

  # Back up .vim and .vimrc if existed
  [ -d ${HOME}/.vim ] && mv ${HOME}/.vim ${HOME}/.vim${TERMI_BAK}
  [ -s ${HOME}/.vimrc ] && mv ${HOME}/.vimrc ${HOME}/.vimrc${TERMI_BAK}

  # Install vim-plug as plugin manager
  curl -fLo ${TERMI_PATH}/vim/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  sed -i '' -e "s#\$VIM_PATH#${TERMI_PATH}/vim#" ${TERMI_PATH}/vim/plugs.vim
  sed -i '' -e "s#\$VIM_PATH#${TERMI_PATH}/vim#" ${TERMI_PATH}/vim/.vimrc
  sed -i '' -e "s#\$DOT_VIM_PATH#${TERMI_PATH}/vim/.vim#" ${TERMI_PATH}/vim/plugs.vim


  # Inject plugs defination list
  sed -i '' -e "/${INJECTION_HOOK} vim-plug/ a\\
  so ${TERMI_PATH}/vim/plugs.vim
  " ${TERMI_PATH}/vim/.vimrc

  ln -sf ${TERMI_PATH}/vim/.vim ${HOME}/.vim
  ln -sf ${TERMI_PATH}/vim/.vimrc ${HOME}/.vimrc

  if ! hash cmake &>/dev/null; then
    brew install CMake
  fi

  vim +PlugInstall +qall!

  # load plugin settings
  sed -i '' -e "s/${UNCOMMENT_HOOK}//g" ${TERMI_PATH}/vim/plugs.vim
}

function with_nvim() {
  mkdir -p ${HOME}/.config/nvim
  ln -sf ${TERMI_PATH}/vim/.vim/* ${HOME}/.config/nvim
  sed -i '' -e "s#\$VIM_PATH#${TERMI_PATH}/vim#" ${TERMI_PATH}/vim/nvim_init.vim
  sed -i '' -e "s#\$DOT_VIM_PATH#${TERMI_PATH}/vim/.vim#" ${TERMI_PATH}/vim/nvim_init.vim
  ln -sf ${TERMI_PATH}/vim/nvim_init.vim ${HOME}/.config/nvim/init.vim
}

function with_tmux() {
  # Back up existed `~/.tmux.conf`
  [ -s ${HOME}/.tmux.conf ] && mv ${HOME}/.tmux.conf ${HOME}/.tmux.conf${TERMI_BAK}

  ln -sf ${TERMI_PATH}/tmux/tmux.conf ${HOME}/.tmux.conf
}


function with_git() {
  local pre_global_git_config=$(git config --global --list 2>/dev/null)
  local config_str config_pair

  # $HOME/.gitconfig => $TERMI_PATH/git/gitconfig
  [ -s ${HOME}/.gitconfig ] && mv ${HOME}/.gitconfig ${HOME}/.gitconfig${TERMI_BAK}
  ln -sf ${TERMI_PATH}/git/gitconfig ${HOME}/.gitconfig

  # $HOME/.gitignore => $TERMI_PATH/git/gitignore
  [ -s ${HOME}/.gitignore ] && mv ${HOME}/.gitignore ${HOME}/.gitignore${TERMI_BAK}
  ln -sf ${TERMI_PATH}/git/gitignore ${HOME}/.gitignore

  # Recover previous global git config
  for config_str in ${pre_global_git_config}; do
    config_pair=(${config_str//=/ })
    git config --global ${config_pair[0]} ${config_pair[1]}
  done
}

main
