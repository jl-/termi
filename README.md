# Termi💥
My personal terminal integration with oh-my-zsh, vim/nvim, tmux, tmuxinator, git etc. All in one repo for easy mantainance

---

## Installation

Installed into `$HOME/.termi` by default
```bash
sh -c "`curl -fsSL https://raw.githubusercontent.com/jl-/termi/master/install.sh`"
```

You may change the install location with:
```bash
export TERMI_PATH="other path"; sh -c "$(curl -fsSL https://raw.github.com/jl-/termi/master/install.sh)"
```

existed `.vimrc`, `.zshrc`, '.vim' will be backup with suffix `.pre-termi`

## Features

- oh-my-zsh
  - `ln $TERMI_PATH/zsh/.zshrc $HOME/.zshrc`
- vim
  - `ln $TERMI_PATH/vim/.vimrc $HOME/.vimrc`
  - `ln $TERMI_PATH/vim/.vim $HOME/.vim`
  - vim-plug. To install and config vim plugins:
      - Open `$TERMI_PATH/vim/plugs.vim` and add your plugin `Plug 'pluginrepo'`. see [vim-plug](https://github.com/junegunn/vim-plug)
      - If you need configuration for the plugin, add a config file `some-name.vim` to `$TERMI_PATH/vim/settings/`
      - Then open vim, `:PlugInstall`
- git config: merge to existed configs
  - `ln $TERMI_PATH/git/gitconfig $HOME/.gitconfig`
  - `ln -sf ${TERMI_PATH}/git/gitignore ${HOME}/.gitignore`

---

### WARNINGS😈

- It works for me, and that's the whole point.  Will probably fail you. Your choice
- If you tried and it failed, just rename those `~/*.pre-termi`s without `.pre-termi`

---

```
├── install.sh
├── tmux
│   └── tmux.conf
├── vim
│   ├── .vim
│   │   ├── autoload
│   │   │   └── plug.vim
│   │   └── plugged
│   │       ├── YouCompleteMe(**this takes a long time to install.. be patient**)
│   │       ├── ctrlp.vim
│   │       ├── editorconfig-vim
│   │       ├── lightline.vim
│   │       ├── nerdtree
│   │       ├── syntastic
│   │       ├── vim-coloresque
│   │       ├── vim-colors-solarized
│   │       ├── vim-gitgutter
│   │       ├── vim-localvimrc
│   │       ├── vim-nerdtree-tabs
│   │       ├── vim-surround
│   │       └── vim-tmux-navigator
│   ├── .vimrc
│   ├── plugs.vim
│   └── settings
│       ├── NERDTree.vim
│       ├── lightline.vim
│       ├── neocomplete.vim
│       └── vim-colors-solarized.vim
└── zsh
    ├── .zshrc
    └── oh-my-zsh
```
