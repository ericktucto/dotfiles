from io import StringIO
import os
from subprocess import run
from dotenv import load_dotenv
from .ordenes import start, stop, status, env, verify
from .servicios import artisan, composer, node, npm, ptest


"""
Author: Erick Tucto
Email: erick@ericktucto.com
Github: https://github.com/ericktucto
Website: https://ericktucto.com
"""

VERSION="dev v2023.07.27"

HELP=f"""{VERSION} - por Erick Tucto
Helper que facilita el uso de los contenedores.

Uso:
  $ dev [ORDEN|SERVICIO] [PARAMETROS]

ORDEN:
    start        Iniciar los contenedores para el entorno de desarrollo.
    stop         Detener los contenedores para el entorno de desarrollo.
    build        Construir los contenedores para el entorno de desarrollo.

SERVICIO:
    composer     Atajo para usar el composer del proyecto.
    npm          Atajo para usar el npm del proyecto.
    node          Atajo para usar el node del proyecto.

PARAMETROS:
    --help       Ayudas.
    --version    Obtener la version del script
"""

def docker(args):
    run(["docker-compose"] + args)
    return 1


def load_environments(workingdir):
    original_env = dict(os.environ)

    path_env = "%s/.env" % workingdir
    if os.path.isfile(path_env):
        with open(path_env) as file_env:
            content = file_env.read()
            load_dotenv(stream=StringIO(content), override=True)
    # retornar las variables de entorno cargadas
    return set(os.environ.keys()) - set(original_env.keys())

def main(workingdir, args):
    keys_to_remove = load_environments(workingdir)
    if len(args) == 0 or args[0] in ["-h", "--help", "-help"]:
        print(HELP)
        return 1
    if args[0] in ["-v", "--version", "-version"]:
        print(VERSION)
        return 1
    ORDEN=args[0]
    switcher={
        "start": start,
        "stop": stop,
        "status": status,
        "composer": composer,
        "artisan": artisan,
        "verify": verify,
        "ptest": ptest,
        "env": env,
        "npm": npm,
        "node": node,
    }
    RUN_STOP = ORDEN == "start"
    info = 1
    try:
        funcion = switcher.get(ORDEN, docker)
        info = funcion(args)
    except KeyboardInterrupt:
        if RUN_STOP:
            stop([])
        info = 1
    finally:
        for key in keys_to_remove:
            os.environ.pop(key)
        if isinstance(info, Exception):
            raise info
        return info


__all__ = ["main"]
