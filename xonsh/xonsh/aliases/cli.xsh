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
