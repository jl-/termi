#! /bin/bash
set -e

# import utils
. "$(dirname $0)/utils.sh"

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

  git clone http://github.com/jl-/termi.git ${TERMI_PATH}
  cd ${TERMI_PATH}

  with_brew
  confirm '\e[32mwith oh-my-zsh?\e[0m' && with_oh_my_zsh
  confirm '\e[32mwith vim?\e[0m' && with_vim
  confirm '\e[32mwith nvim?\e[0m' && with_nvim
  confirm '\e[32mwith tmux?\e[0m' && with_tmux
  confirm '\e[32mwith git?\e[0m' && with_git

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
  git clone git://github.com/robbyrussell/oh-my-zsh.git ${TERMI_PATH}/zsh/oh-my-zsh

  # Back up existed zsh configuation files
  [ -s ${HOME}/.zshrc ] && mv ${HOME}/.zshrc ${HOME}/.zshrc${TERMI_BAK}

  # Export ZSH for oh-my-zsh
  sed -i '' -e "/^export ZSH=/ c\\
  export ZSH=${TERMI_PATH}/zsh/oh-my-zsh
  " ${TERMI_PATH}/zsh/.zshrc

  # Copy current PATH to .zshrc
  sed -i '' -e "/#EXPOSE PATH#/ a\\
  export PATH=${PATH}
  " ${TERMI_PATH}/zsh/.zshrc

  # Link zshrc
  ln -sf ${TERMI_PATH}/zsh/.zshrc ${HOME}/.zshrc

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
  if [ -d ${HOME}/.config ]; then
    mkdir -p ${HOME}/.config/nvim
    ln -sf ${TERMI_PATH}/vim/.vim ${HOME}/.config/nvim
    ln -sf ${TERMI_PATH}/vim/.vimrc ${HOME}/.config/nvim/init.vim
  fi
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
