from xontrib.add_variable.decorators import alias

DEV_HELP = """dev version 20.06.1 - por Erick Tucto

CLI trabaja con el entorno de desarrollo, hace busca quedas, levanta servicios,
etc.

ORDENES
  search
    Se encarga de buscar archivos o palabras tus proyectos.

ENTORNOS
  [php7.4|php7.3|mysql|nginx] <accion>
    Estos son entornos(por ahora solo trabajos con solos servicios) que la cli
    trabaja.

OPCIONES
  -v, -version, --version
    Verificar version de la cli.

{MUY PRONTO}
OPCIONES
  -a, -ayuda, --ayuda
    Nuestra la ayuda para alguna orden o entorno.
    Ejemplos:
      # dev php7.4 --ayuda
      # dev search -a
"""

PHP_HELP = """dev %s [ACCIÓN]

Este es el entorno de PHP.

[ACCIÓN]
  restart  Reiniciar el entorno PHP.
  start    Iniciar el entorno PHP.
  stop     Detener el entorno PHP.
"""

MYSQL_HELP = """dev mysql [OPCIÓN]

Este es el entorno de MYSQL.

[OPCIÓN]
  restart  Reiniciar el entorno de MYSQL.
  start    Iniciar el entorno de MYSQL.
  stop     Detener el entorno de MYSQL.
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
    if len(args) == 0:
        return DEV_HELP
    if len(args) == 1 and args[0] in ["-v", "-version", "--version"]:
        return "dev v20.06.1"
    l = lambda cmd : cmd.split("\n")[:-1] if type(cmd) is str else cmd
    def traerOpcion(opcion, espacio=1):
        index = args.index(opcion) + espacio
        return args[index] if len(args) > index else None

    env = args[0]
    if env in ['search']:
        # PARA BUSCAR POR NOMBRE DE ARCHIVO
        if args[1] == "-f":
            buscar = args[2]
            if not buscar:
                return "No ingresaste nada."
            print(f"Buscando: {buscar}")
            files = l($(find . -type f | egrep -v ".git|node_modules" | grep -i @(buscar)))
            if len(files) == 0:
                return "No hay resultados.\nBusqueda terminda."
            from colorama import Fore
            from re import search, IGNORECASE
            resultado = []
            for stringSearch in files:
                objMath = search(buscar, stringSearch, flags=IGNORECASE)
                inicio = stringSearch[:objMath.start()]
                medio = stringSearch[objMath.start():objMath.end()]
                fin = stringSearch[objMath.end():]
                resultado.append(f"{inicio}{Fore.BLUE}{medio}{Fore.RESET}{fin}")
            print("\n".join(resultado))
            return "Busqueda terminada"

        # SE AGREGÓ FLAG -o PARA ESPECIFICAR ORACIÓN A BUSCAR, PARA CONTINUAR
        # CON LA COMPATIBILIDAD DE LA VERSION ANTERIOR POR DEFECTO TOMARÁ EL
        # SEGUNDO ARGUMENTO PASADO A LA CLI.
        buscar = args[1] if "-o" not in args else traerOpcion("-o")
        # SI SE MANDA EL PARAMETRO -d SE TOMA Y CONVIERTE EN LISTA, POR EJEMPLO
        # app,resources,src => ['app', 'resources', 'src']. SI NO SE DA LA
        # OPCION, ENTONCES BUSCARÁ DESDE LA RAIZ DEL DIRECTORIO.
        directorios = ['./'] if "-d" not in args else traerOpcion("-d").split(",")
        print(buscar)
        for directorio in directorios:
            grep -Rin @(buscar) @(directorio)
            #grep -Ril @(buscar) @(directorio)
        return "Busqueda terminada"
    if env in ["php7.4", "php7.3"]:
        php(args)
    elif env in ["mysql", "nginx", "docker"]:
        globals()[env](args[1:])
    else:
        return DEV_HELP


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


def mysql(args):
    if len(args) != 1:
        print(MYSQL_HELP)
        return
    action = args[0]
    if action in ["start", "restart", "stop"]:
        sudo service mysql @(action)
    elif action in ["status"]:
        service mysql @(action)
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
