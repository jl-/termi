#!/bin/bash
set -e

XDG_CONFIG_HOME=${HOME}/.config
TERMI_ROOT=${XDG_CONFIG_HOME}/.termi

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
  git clone https://github.com/jl-/termi.git ${TERMI_ROOT}
}

function config_git() {
  ln -sf ${TERMI_ROOT}/git ${XDG_CONFIG_HOME}

  # current global config
  local -r curr_cfg=$(git config --global --list 2>/dev/null)

  # link .gitconfig, .gitmessage
  ln -sf ${XDG_CONFIG_HOME}/git/gitconfig ${HOME}/.gitconfig
  ln -sf ${XDG_CONFIG_HOME}/git/gitmessage ${HOME}/.gitmessage

  git config --global commit.template ${HOME}/.gitmessage
  # append previous global config
  echo "$curr_cfg" | awk -F '=' '{system("git config --global "$1" \""$2"\"")}' &>/dev/null || true
}

function config_omz() {
  local -r omz_path=${TERMI_ROOT}/zsh/omz

  ln -sf ${TERMI_ROOT}/zsh ${XDG_CONFIG_HOME}

  git clone https://github.com/robbyrussell/oh-my-zsh.git ${omz_path}
  git clone https://github.com/zsh-users/zsh-autosuggestions.git ${omz_path}/plugins/zsh-autosuggestions

  # link .zshrc
  ln -sf ${XDG_CONFIG_HOME}/zsh/.zshrc ${HOME}/.zshrc

  # set as default SHELL
  if [[ ! $SHELL =~ zsh$ ]] && command -v chsh &>/dev/null; then
    chsh -s $(which zsh)
  fi
}

function config_vim() {
  ln -sf ${TERMI_ROOT}/nvim ${XDG_CONFIG_HOME}

  # Install vim-plug as plugin manager
  curl -fLo ${XDG_CONFIG_HOME}/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \

  if ! command -v cmake &>/dev/null; then
    brew install CMake
  fi

  nvim -i NONE -c PlugInstall -c quitall > /dev/null 2>&1
}

function config_tmux() {
  ln -sf ${TERMI_ROOT}/tmux ${XDG_CONFIG_HOME}
  ln -sf ${XDG_CONFIG_HOME}/tmux/tmux.conf ${HOME}/.tmux.conf
}

function config_ctags() {
  brew unlink ctags || true
  brew install --HEAD universal-ctags/universal-ctags/universal-ctags
  ln -sf ${TERMI_ROOT}/ctags ${HOME}/.ctags.d
}

function config_fzf() {
  brew install fzf
  $(brew --prefix)/opt/fzf/install --key-bindings --completion --no-bash --no-zsh --no-fish
}

bootstrap

config_git
config_omz
config_vim
config_tmux
config_ctags
config_fzf
