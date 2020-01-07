#!/usr/bin/env xonsh
from os.path import realpath, dirname

me = dirname(realpath(__file__))

# Make file and directories
ln -s @(me)/xonsh $HOME/.xonsh
ln -s @(me)/xonshrc $HOME/.xonshrc
touch @(me)/xonsh/errors.log

# Install plugins xontrib
xpip install xontrib-add-variable
xpip install xontrib-base16-shell

# Themes
git clone https://github.com/chriskempson/base16-shell.git $HOME/.config/base16-shell

