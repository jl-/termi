#!/usr/bin/env bash
set -e

# Installation path defaults to `$HOME/.termi`
# For customization, set `TERMI_PATH` environment variable
: ${TERMI_PATH:=${HOME}/.termi}
BAK_PATH=${TERMI_PATH}/.backup

# main
function bootstrap() {
  if ! command -v brew &>/dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  if ! command -v git &>/dev/null; then
    brew update && brew install git
  fi

  if ! command -v rbenv &>/dev/null; then
    brew update && brew install rbenv
    rbenv install $(rbenv install -l | grep -v - | tail -1)
    rbenv global $(rbenv install -l | grep -v - | tail -1)
  fi

  if ! command -v pyenv &>/dev/null; then
    brew update && brew install pyenv
    PYTHON_CONFIGURE_OPTS="--enable-framework" pyenv install $(pyenv install -l | grep -v - | tail -1)
    pyenv global $(pyenv install -l | grep -v - | tail -1)
  fi

  if ! command -v nvim &>/dev/null; then
    brew update && brew install neovim
    gem install neovim
    pip3 install --user --upgrade neovim
  fi

  # clone source
  git clone https://github.com/jl-/termi.git ${TERMI_PATH}
  [ ! -d ${BAK_PATH} ] && mkdir ${BAK_PATH}

  config_git
  config_omz
  config_vim
  config_tmux
  config_ctags
  config_fzf
}

function config_git() {
  # .gitconfig, .gitmessage file paths
  local -r cfg_dpath=${HOME}/.gitconfig
  local -r cfg_spath=${TERMI_PATH}/git/gitconfig
  local -r msg_dpath=${HOME}/.gitmessage
  local -r msg_spath=${TERMI_PATH}/git/gitmessage

  # Current global config
  local -r curr_cfg=$(git config --global --list 2>/dev/null)

  # Backup .gitconfig, .gitmessage
  if [ -f ${cfg_dpath} ] && [ ! -h ${cfg_dpath} ]; then
    mv ${cfg_dpath} ${BAK_PATH}/.gitconfig
  fi
  if [ -f ${msg_dpath} ] && [ ! -h ${msg_dpath} ]; then
    mv ${msg_dpath} ${BAK_PATH}/.gitmessage
  fi

  # Link .gitconfig, .gitmessage
  ln -sf ${cfg_spath} ${cfg_dpath}
  ln -sf ${msg_spath} ${msg_dpath}

  git config --global commit.template ${msg_dpath}
  # Append previous global config
  echo "$curr_cfg" | awk -F '=' '{system("git config --global "$1" \""$2"\"")}' &>/dev/null || true
}

function config_omz() {
  local -r omz_path=${TERMI_PATH}/zsh/omz
  local -r rc_dpath=${HOME}/.zshrc
  local -r rc_spath=${TERMI_PATH}/zsh/.zshrc

  git clone git://github.com/robbyrussell/oh-my-zsh.git ${omz_path}
  git clone git://github.com/zsh-users/zsh-autosuggestions ${omz_path}/plugins/zsh-autosuggestions

  # Back up existing zsh configuation files
  if [ -f ${rc_dpath} ] && [ ! -h ${rc_dpath} ]; then
    mv ${rc_dpath} ${BAK_PATH}/.zshrc
  fi

  # Export ZSH for oh-my-zsh
  sed -i '' -e "/^export ZSH=/ c\\
  export ZSH=${omz_path}
  " ${rc_spath}

  # Link .zshrc
  ln -sf ${rc_spath} ${rc_dpath}

  # Set as default SHELL
  if [[ ! $SHELL =~ zsh$ ]] && command -v chsh &>/dev/null; then
    chsh -s $(which zsh)
  fi
}

function config_vim() {
  # .vim, .vimrc paths
  local -r vim_dpath=${HOME}/.vim
  local -r vim_spath=${TERMI_PATH}/vim/.vim
  local -r rc_dpath=${HOME}/.vimrc
  local -r rc_spath=${TERMI_PATH}/vim/.vimrc

  # Backup .vim and .vimrc
  if [ -d ${vim_dpath} ] && [ ! -h ${vim_dpath} ]; then
    mv ${vim_dpath} ${BAK_PATH}/.vim
  fi
  if [ -f ${rc_dpath} ] && [ ! -h ${rc_dpath} ]; then
    mv ${rc_dpath} ${BAK_PATH}/.vimrc
  fi

  # Install vim-plug as plugin manager
  curl -fLo ${vim_spath}/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  sed -i '' -e "s#\$VIM_PATH#${TERMI_PATH}/vim#" ${TERMI_PATH}/vim/plugs.vim

  ln -sf ${rc_spath} ${rc_dpath}
  ln -sf ${vim_spath} ${vim_dpath}

  if ! command -v cmake &>/dev/null; then
    brew install CMake
  fi

  nvim +PlugInstall +qall!
  local -r nvim_dpath=${XDG_CONFIG_HOME:-$HOME/.config}/nvim
  mkdir -p ${nvim_dpath}
  ln -sf ${TERMI_PATH}/vim/nvim_init.vim ${nvim_dpath}/init.vim

  # Load plugin settings
  sed -i '' -e "s/\" #UNCOMMENT_HOOK#//g" ${TERMI_PATH}/vim/plugs.vim
}

function config_tmux() {
  local -r cfg_dpath=${HOME}/.tmux.conf

  if ! command -v tmux &>/dev/null; then
    brew install tmux
  fi

  # Backup `~/.tmux.conf`
  if [ -f ${cfg_dpath} ] && [ ! -h ${cfg_dpath} ]; then
    mv ${cfg_dpath} ${BAK_PATH}/.tmux.conf
  fi

  ln -sf ${TERMI_PATH}/tmux/tmux.conf ${cfg_dpath}
}

function config_ctags() {
  brew unlink ctags || true
  brew install --HEAD universal-ctags/universal-ctags/universal-ctags
  ln -sf ${TERMI_PATH}/ctags ${HOME}/.ctags.d
}

function config_fzf() {
  brew install fzf
  $(brew --prefix)/opt/fzf/install --key-bindings --completion --no-bash --no-zsh --no-fish
}

bootstrap
