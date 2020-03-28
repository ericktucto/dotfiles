from xontrib.add_variable.decorators import alias

PHP_HELP = """dev %s [ACCIÓN]

Este es el entorno de PHP.

[ACCIÓN]
  restart  Reiniciar el entorno PHP.
  start    Iniciar el entorno PHP.
  stop     Detener el entorno PHP.
"""

NGINX_HELP = """dev nginx [OPCIÓN]

Este es el entorno de NGINX.

[OPCIÓN]
  restart  Reiniciar el entorno de NGINX.
  start    Iniciar el entorno de NGINX.
  stop     Detener el entorno de NGINX.
"""

DOCKER_HELP = """dev docker [OPCIÓN]

Este es el entorno de DOCKER.

[OPCIÓN]
  restart  Reiniciar el entorno de DOCKER.
  start    Iniciar el entorno de DOCKER.
  stop     Detener el entorno de DOCKER.
"""

ANBOX_APP_HELP = """anboxApp <app-name>

Esta es un lanzador de las aplicaciones de anbox.

<app-name>    Nombre de la aplicacion que deseas lanzar.
"""

VIDEO_HELP = """video -i video [OPCIONES]

Divisor de videos.

[OPCIONES]
-i    input        Especificar video
-s    segundos     Para dividir por cada segundo
-p    parte        En parte iguales
-h    help         Mostrar ayuda
"""

@alias
def dev(args):
    env = args[0]
    if env in ["php7.4", "php7.3"]:
        php(args)
    elif env in ["nginx", "docker"]:
        globals()[env](args[1:])
    else:
        print("No existe el entorno.")


def php(args):
    version = args[0]
    if len(args) != 2:
        print(PHP_HELP% (version))
        return
    action = args[1]
    if action in ["start", "restart", "stop"]:
        sudo service @(version)-fpm @(action)
    elif action in ["status"]:
        service @(version)-fpm @(action)
    else:
        print(f"La opción {action} no existe en el entorno PHP.")


def nginx(args):
    if len(args) != 1:
        print(NGINX_HELP)
        return
    action = args[0]
    if action in ["start", "restart", "stop"]:
        sudo service nginx @(action)
    elif action in ["status"]:
        service nginx @(action)
    else:
        print(f"La opción {action} no existe en el entorno NGINX.")


def docker(args):
    if len(args) != 1:
        print(DOCKER_HELP)
        return
    action = args[0]
    if action in ["start", "restart", "stop"]:
        sudo service docker @(action)
    elif action in ["status"]:
        service docker @(action)
    else:
        print(f"La opción {action} no existe en el entorno DOCKER.")


@alias
def anboxApp(args):
    def getPackageComponent(app):
        package = $(adb shell pm list packages | grep @(app)).replace("package:", "")[:-1]
        component = $(adb shell cmd package resolve-activity --brief @(package) | tail -n 1).replace("/", "")[:-1]
        return (package, component)
    if len(args) <= 1:
        print(ANBOX_APP_HELP)
        return
    action = args[0]
    app = args[1]
    (package, component) = getPackageComponent(app)
    if action in ["list"]:
        return f"El paquete es {package} | el componente es {component}"
    elif action in ["run"]:
        return anbox launch --package=@(package) --component=@(component)
    else:
        return f"La opción {action} no existe."


@alias
def video(args):
    from datetime import timedelta
    from datetime import datetime
    from os.path import split, splitext

    getOpcion = lambda opcion, espacio=1: args[args.index(opcion) + espacio]

    if len(args) == 0 or "-h" in args:
        return VIDEO_HELP

    if "-show" in args:
        archivo = getOpcion("-show")
        patron = getOpcion("-show", 2)
        mediainfo @(archivo) --Output=JSON | jq @(patron) -r
        return
    if "-i" not in args:
        return "No especificaste el video."

    archivo = split(getOpcion("-i"))[1]
    (nombre, extension) = splitext(archivo)

    if ("-s" and "-p") in args:
        return "No puedes usar esas opciones juntas."

    def getDuracion(name):
        ruta = '.media.track[0].Duration'
        result = $(mediainfo @(name) --Output=JSON | jq @(ruta) -r )[:-1]
        return int(float(result))

    def barra(cantidad, completos, largo=40):
        if cantidad == completos:
            return "[%s] (%d/%d)" % ("#" * largo, completos, cantidad)
        michi = int(largo / cantidad) * completos
        punto = (largo - michi)
        return "[%s%s] (%d/%d)" % ("#" * michi, "." * punto, completos, cantidad)

    # POR SEGUNDOS
    if "-s" in args:
        segundos = int(args[args.index("-s") + 1])
        duracion = getDuracion(archivo)
        tiempo = range(int(duracion / segundos))
        if len(tiempo) == 0:
            return "No es puede dividir en %d" % segundos
        pasos = [str(timedelta(seconds= s * segundos)) for s in tiempo]
        # BARRA DE PROGRESO EN CERO
        echo -ne @("%s\r" % barra(len(pasos), 0))
        for index in range(len(pasos)):
            inicio = pasos[index]
            fin = str(timedelta(seconds=duracion)) if inicio == pasos[-1] else pasos[index + 1]
            fragmento = "%s_%d%s" % (nombre, index, ".mp4")
            # DIVIDIR VIDEO
            $(ffmpeg -i @(archivo) -ss @(inicio) -to @(fin) -f mp4 -c:a aac -c:v libx264 -preset ultrafast -profile:v main -strict -2 @(fragmento))
            # LLENAR BARRA DE PROGRESO
            echo -ne @("%s\r" % barra(len(pasos), index + 1))
        return "%s\nTerminado" % (barra(len(pasos), len(pasos)))
    # POR PARTES
    elif "-p" in args:
        return "En desarrollo."
    else:
        print("TE FALTAN OPCIONES")
        return video.__doc__
    return duracion(args[0])
