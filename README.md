# Termi💥
Personal terminal integration, with oh-my-zsh, vim/nvim, git etc.

![Vim-Tmux Screenshot](https://cloud.githubusercontent.com/assets/6291986/15317479/4228ac68-1c54-11e6-951b-1c2123bc3d27.png)

## Installation

Installed into `$HOME/.termi` by default
```bash
sh -c "`curl -fsSL https://raw.githubusercontent.com/jl-/termi/master/install.sh`"
```

You may change the install location with:
```bash
export TERMI_PATH="other path"; sh -c "$(curl -fsSL https://raw.github.com/jl-/termi/master/install.sh)"
```

existed `.vimrc`, `.zshrc`, '.vim' will be backup in `${TERMI_PATH}/.backup`

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
- git config: merge with existed configs
  - `ln $TERMI_PATH/git/gitconfig $HOME/.gitconfig`
  - better commit.template

---

### WARNINGS😈

- It works for me, and that's the whole point.  Might probably fail you. Your choice
- If you tried and it failed, restore your backup files from `${TERMI_PATH}/.backup/*`

---

```
├── install.sh
├── vim
│   ├── .vim
│   │   ├── autoload
│   │   │   └── plug.vim
│   │   └── plugged
│   │       ├── YouCompleteMe(**this takes a long time to install.. be patient**)
│   │       ├── ctrlp.vim
│   │       ├── editorconfig-vim
│   │       ├── lightline.vim
│   │       ├── nerdtree
│   │       ├── syntastic
│   │       ├── vim-coloresque
│   │       ├── vim-colors-solarized
│   │       ├── vim-gitgutter
│   │       ├── vim-localvimrc
│   │       ├── vim-nerdtree-tabs
│   │       ├── vim-surround
│   │       └── vim-tmux-navigator
│   ├── .vimrc
│   ├── plugs.vim
│   └── settings
│       ├── NERDTree.vim
│       ├── lightline.vim
│       ├── neocomplete.vim
│       └── vim-colors-solarized.vim
└── zsh
    ├── omz
    └── .zshrc
```
