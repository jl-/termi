                 --
                |  |
                |  |
           ____ |  |_____
          (_____    _____)
                |  |
                |  |
                |  |  ________     _____   __________   ()
                |  |/   ____   \ /  ____)/  __    __  \(  )
                |  |  /______\  |  |    |  |  |  |  |  |  |
                |  |  |________/|  |    |  |  |  |  |  |  |
                |  |  \_______  |  |    |  |  |  |  |  |  |
                |  |\__________)|__|    |__|  |__|  |__|__|
                 \/

|          **Terminal with oh-my-zsh, vim, tmux, tmuxinator... All in one repo for easy mantainance**

---

## Installation

Installed into `$HOME/.termi` by default
```bash
sh -c "`curl -fsSL https://raw.githubusercontent.com/jl-/termi/master/install.sh`"
```

You may change the location with:
```bash
export TERMI_PATH="other path"; sh -c "$(curl -fsSL https://raw.github.com/jl-/termi/master/install.sh)"
```

Termi does nothing but:
- `ln $TERMI_PATH/zsh/.zshrc $HOME/.zshrc`
- `ln $TERMI_PATH/vim/.vimrc $HOME/.vimrc`
- `ln $TERMI_PATH/vim/.vim $HOME/.vim`
- TO install and config vim plugins:
  - Open `$TERMI_PATH/vim/plugs.vim` and add your plugin `Plug 'pluginrepo'`. see [vim-plug](https://github.com/junegunn/vim-plug)
  - If you need configuration for the plugin, add a config file `some-name.vim` to `$TERMI_PATH/vim/settings/`


###### existed `.vimrc`, `.zshrc`, '.vim' will be backup with suffix `.pre-termi`

## Features

- oh-my-zsh
- vim
- vim-plug

## Screenshot

```
├── install.sh
├── tmux
│   └── tmux.conf
├── vim
│   ├── .vim
│   │   ├── autoload
│   │   │   └── plug.vim
│   │   └── plugged
│   │       ├── YouCompleteMe
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
