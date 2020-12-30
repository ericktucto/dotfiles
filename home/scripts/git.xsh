#!/usr/bin/env xonsh

def main(args):
    if len(args) == 0:
        return "git script v1 por Erick Tucto"
    opcion = args[0]

    if opcion == "update":
        git pull origin @($(git branch --show-current).strip())
        return ""

    elif opcion == "ecommit":
        mensaje = $(trans "es:en" @(args[1]) -b).strip()
        opciones = [mensaje] + args[2:]
        @(['git', 'commit', '-m'] + opciones)
        return ""
    else:
        return "No existe la opcion"

if __name__ == "__main__":
    salida = main($ARGS[1:])
    print(salida)