#!/usr/bin/env xonsh

if len($ARGS) == 1:
    echo "Script para Alacritty"

else:
    orden = $ARGS[1]

    if orden == 'toggle-fullscreen':
        ID_WINDOW = $(xdotool getwindowfocus)[:-1]
        wmctrl -ir @(ID_WINDOW) -b toggle,fullscreen
    elif orden == 'toggle-transparency':
        from yaml import dump as yDump, Dumper, load as yLoad, Loader

        isTransparency = lambda config: config['background_opacity'] < 1
        getData = lambda config: (config['background_opacity'], config['temp']['background_opacity'])

        file_name = f"{$HOME}/.alacritty.yml"
        config_alacritty = yLoad(open(file_name, "r"), Loader=Loader)
        [actual, temp] = getData(config_alacritty)
        if isTransparency(config_alacritty):
            config_alacritty['temp']['background_opacity'] = actual
            config_alacritty['background_opacity'] = 1
        else:
            config_alacritty['background_opacity'] = temp
        open(file_name, "w+").write(yDump(config_alacritty, Dumper=Dumper))
