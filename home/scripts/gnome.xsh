#!/usr/bin/env xonsh

if len($ARGS) == 1:
    echo "Script para Gnome"

else:
    orden = $ARGS[1]

    if orden == 'toggle-transparency':
        profile_terminal = "/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9"
        path_transparency = f"{profile_terminal}/use-transparent-background"
        change = 'true' if $(dconf read @(path_transparency))[:-1] == "false" else "false"
        dconf write @(path_transparency) @(change)
