#!/usr/bin/env xonsh

RUTA_DASH = 'org.gnome.shell.extensions.dash-to-dock'

def dashEstaActivo() -> bool:
    return "true" in $(gsettings get @(RUTA_DASH) dock-fixed)


def dashCambiarEstado(estado: str) -> None:
    $(gsettings set @(RUTA_DASH) dock-fixed @(estado))


if (dashEstaActivo()):
    dashCambiarEstado("false")
else:
    dashCambiarEstado("true")
