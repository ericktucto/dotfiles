#!/usr/bin/env xonsh

if (len($ARGS) > 1):
    mensaje = $(trans "es:en" @($ARGS[1]) -b).strip()
    opciones = [mensaje] + $ARGS[2:]
    @(['git', 'commit', '-m'] + opciones)
else:
    print("No escribiste el mensaje")

