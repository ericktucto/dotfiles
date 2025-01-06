#!/usr/bin/env bash


function notify_error() {
    rofi -e "$1" -theme /home/erick/.config/rofi/colors/purple.rasi
}

language=$(echo -e "en:es\nes:en" | rofi -dmenu -theme /home/erick/.config/rofi/colors/purple.rasi -p "")
if [ -z "$language" ]; then
    notify_error "No seleccionaste un idioma"
    exit 0
fi
query=$(rofi -dmenu -p "" -theme /home/erick/.config/rofi/colors/purple.rasi)

if [ -z "$query" ]; then
    notify_error "No hay nada que traducir"
    exit 0
fi

traduction=$(trans -b $language "$query")

opcion=$(zenity \
    --question \
    --title="Traducción" \
    --text="$traduction" \
    --switch \
    --extra-button "Copiar" \
    --extra-button "Cerrar")

if [ "$opcion" = "Copiar" ]; then
    echo -n "$traduction" | xclip -selection clipboard
elif [ "$opcion" = "Cerrar" ]; then
    echo -n "$traduction"
fi
