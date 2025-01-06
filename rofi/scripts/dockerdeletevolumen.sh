#!/usr/bin/env bash
docker volume list -q | rofi -show -dmenu -theme /home/erick/.config/rofi/colors/purple.rasi -p "Eliminar" -mesg "Volumes docker" | xargs -I_ docker volume rm _
