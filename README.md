# Termi💥
Personal terminal integration, with git, oh-my-zsh, neovim, emacs, tmux etc.

![Vim-Tmux Screenshot](https://cloud.githubusercontent.com/assets/6291986/15317479/4228ac68-1c54-11e6-951b-1c2123bc3d27.png)

## Installation

[rbenv](https://github.com/rbenv/rbenv#homebrew-on-macos) | [pyenv](https://github.com/pyenv/pyenv#homebrew-on-macos), [opt](https://github.com/pyenv/pyenv/wiki#how-to-build-cpython-with-framework-support-on-os-x) | [nvm](https://github.com/creationix/nvm#installation)

Installed into `$HOME/.termi` by default
```bash
sh -c "`curl -fsSL https://raw.githubusercontent.com/jl-/termi/master/install.sh`"
```

You may change the install location with:
```bash
export TERMI_PATH="other path"; sh -c "$(curl -fsSL https://raw.github.com/jl-/termi/master/install.sh)"
```

## Features

- vim plugins management:
    - Open `$TERMI_PATH/vim/plugs.vim` and add your plugin `Plug 'pluginrepo'`. see [vim-plug](https://github.com/junegunn/vim-plug)
    - If you need configuration for the plugin, add a config file `some-name.vim` to `$TERMI_PATH/vim/settings/`
    - Then open vim, `:PlugInstall`
- opinionated git commit template

## WARNING😈

- It works for me, and that's the whole point. Might probably fail you.
- If you tried and it failed, restore your backup files from `${TERMI_PATH}/.backup/*`

