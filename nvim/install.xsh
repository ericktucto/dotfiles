#!/usr/bin/env xonsh
from os.path import realpath, dirname, exists

me = dirname(realpath(__file__))

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
    --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Make file and directories
ln -s @(me) $HOME/.config/nvim

