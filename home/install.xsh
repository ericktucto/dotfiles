#!/usr/bin/env xonsh
from os.path import realpath, dirname

me = dirname(realpath(__file__))

# MOVE FILES
ln -s @(me)/scripts {$HOME}/.scripts

