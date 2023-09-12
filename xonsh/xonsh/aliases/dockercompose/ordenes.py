from subprocess import Popen, PIPE, run

def start(args):
    detach = len(args) == 2 and args[1] in ["-d", "--detach", "-detach"]
    args[0] = 'up'
    if detach:
        Popen(" ".join(["docker-compose"] + args), shell=True, stdout=PIPE)
    else:
        run(["docker-compose", "up"])
    return 1

def stop(_):
    run(["docker-compose", "down"])
    return 1

def status(_):
    run(["docker-compose", "ps"])
    return 1

def env(args):
    args = args[1:]
    if len(args) == 0:
        return 0
    environment = args[0].upper()

    if len(args) == 1:
        if environment in os.environ:
            print(os.environ.get(environment))
        else:
            return KeyError("Unknown environment variable: $%s" % environment)
    else:
        value = " ".join(args[1:])
        os.environ.setdefault(environment, value)
    return 1

def verify(_):
    full_path = os.getcwd()
    path_env = os.path.join(full_path, ".env")
    if os.path.exists(path_env) == False:
        print("No agregaste tus variables de entorno. Tiene .env.example como ejemplo.")
        return 0
    print("Todo esta correcto.")
    return 1
