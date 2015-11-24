#!/bin/bash

# Installation path defaults to `$HOME/.termi`
# You may custom this by setting `TERMI_PATH`:
# `export TERMI_PATH="some path"; sh -c "$(curl -fsSL https://raw.github.com/jl-/termi/master/install.sh)"`
: ${TERMI_PATH:=$HOME/.termi}

# Suffix used to back up existed files
TERMI_BAK='.pre-termi'

main() {
  # If already installed, alert and exit
  if [ -d $TERMI_PATH ]; then
    echo "TERMI already installed in $TERMI_PATH .abort"
    exit
  fi

  echo "Installing TERMI ..."

  # for dev
  #cp -r $HOME/termi $TERMI_PATH

  git clone http://github.com/jl-/termi.git $TERMI_PATH
  cd $TERMI_PATH

  with_oh_my_zsh
  with_vim
  with_tmux

  printf "TERMI installed."
}




with_oh_my_zsh() {
  git clone git://github.com/robbyrussell/oh-my-zsh.git $TERMI_PATH/zsh/oh-my-zsh

  # Back up existed zsh configuation files
  [ -s $HOME/.zshrc ] && mv $HOME/.zshrc $HOME/.zshrc$TERMI_BAK

  # Export ZSH for oh-my-zsh
  sed -i '' -e "/^export ZSH=/ c\\
  export ZSH=$TERMI_PATH/zsh/oh-my-zsh
  " $TERMI_PATH/zsh/.zshrc

  # Copy current PATH to .zshrc
  sed -i '' -e "/#EXPOSE PATH#/ a\\
  export PATH=$PATH
  " $TERMI_PATH/zsh/.zshrc

  # Link zshrc
  ln -sf $TERMI_PATH/zsh/.zshrc $HOME/.zshrc

  # If not using zsh, then set
  if [[ ! $SHELL =~ zsh$ ]]; then
    if hash chsh &>/dev/null; then
      chsh -s $(grep /zsh$ /etc/shells | tail -1)
    fi
  fi
}



with_vim() {
  local UNCOMMENT_HOOK='" #UNCOMMENT_HOOK#'
  local INJECTION_HOOK='#INJECTION_HOOK#'

  # Back up .vim and .vimrc if existed
  [ -d $HOME/.vim ] && mv $HOME/.vim $HOME/.vim$TERMI_BAK
  [ -s $HOME/.vimrc ] && mv $HOME/.vimrc $HOME/.vimrc$TERMI_BAK

  # Install vim-plug as plugin manager
  curl -fLo $TERMI_PATH/vim/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  sed -i '' -e "s#\$VIM_PATH#$TERMI_PATH/vim#" $TERMI_PATH/vim/plugs.vim
  sed -i '' -e "s#\$DOT_VIM_PATH#$TERMI_PATH/vim/.vim#" $TERMI_PATH/vim/plugs.vim

  # Inject plugs defination list
  sed -i '' -e "/$INJECTION_HOOK vim-plug/ a\\
  so $TERMI_PATH/vim/plugs.vim
  " $TERMI_PATH/vim/.vimrc

  ln -sf $TERMI_PATH/vim/.vim $HOME/.vim
  ln -sf $TERMI_PATH/vim/.vimrc $HOME/.vimrc

  vim +PlugInstall +qall!

  # load plugin settings
  sed -i '' -e "s/$UNCOMMENT_HOOK//g" $TERMI_PATH/vim/plugs.vim

}

with_tmux() {
  # Back up existed `~/.tmux.conf`
  [ -s $HOME/.tmux.conf ] && mv $HOME/.tmux.conf $HOME/.tmux.conf$TERMI_BAK

  ln -sf $TERMI_PATH/tmux/tmux.conf $HOME/.tmux.conf

}

main


