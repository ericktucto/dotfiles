from xontrib.add_variable.decorators import alias

isModLoaded = lambda mod : True if $(lsmod | grep @(mod)) else False

TOUCHPAD_HELP = """touchpad [OPCIÓN]

Alias para trabajar con el touchpad

[OPCIÓN]
  restart  Reiniciar el touchpad.
  start    Iniciar el touchpad.
  stop     Detener el touchpad.
"""

WIFI_HELP = """wifi [ADAPTER] [OPCIÓN]

Alias para trabajar con el wifi.

[OPCIÓN]
  restart    Reiniciar el WIFI.
  scan       Busca señal WIFI cercana.
  connect    Conectar a señal WIFI.
  up         Iniciar el WIFI.
  down       Detener el WIFI.
"""

CHPROMPT_HELP = """chprompt [OPCIÓN]
Alias para trabajar con el wifi.

[OPCIÓN]
  default    Cambia el prompt al por defecto
  project    Cambia el prompt al estilo por projecto
"""


@alias
def alarm(args):
    from playsound import playsound
    def _alarm():
        for _ in range(2):
            playsound("/home/erick/Música/beep1.mp3", True)
    sleep @(args); _alarm()


@alias
def chprompt(args):
    if len(args) == 0:
        return CHPROMPT_HELP
    opcion = args[0]
    if opcion in ["profile"]:

        profiles = ["default", "tmux"]
        if len(args) != 2 or args[1] not in profiles:
            return "Elegir entre los siguiente perfiles %s" % (", ".join(profiles))

        $PTK_STYLE_OVERRIDES['bottom-toolbar'] = 'noreverse'
        profile = args[1]
        if profile in ["default"]:
            $PROMPT = '{env_name:{} }{YELLOW}{cwd_base}{branch_color}{curr_branch: [{}]} {NO_COLOR}🔥 '
            $RIGHT_PROMPT = ''
            $BOTTOM_TOOLBAR = ' '
            $MULTILINE_PROMPT = '`*·.·*`'
        elif profile in ["tmux"]:
            $PROMPT = '{env_name:{} }{BOLD_YELLOW}{cwd_base}{branch_color}{curr_branch: [{}]} {NO_COLOR}🔥 '
            $RIGHT_PROMPT = ''
            $MULTILINE_PROMPT = '`*·.·*`'
            $BOTTOM_TOOLBAR = ' '


@alias
def pp(arg):
    texto = arg[0]
    $[echo @(texto) | xclip -selection clipboard]


@alias
def touchpad(args):
    if len(args) != 1:
        return TOUCHPAD_HELP
    mod = args[0]
    if mod in ["start", "restart", "stop"]:
        if mod == "restart":
            $(touchpad stop)
            $(touchpad start)
        elif mod == "start":
            $(sudo modprobe psmouse)
        else:
            $(sudo modprobe -r psmouse)
    else:
        print("Opción invalida")


@alias
def wifi(args):
    if len(args) < 2:
        return WIFI_HELP
    adap = args[0]
    option = args[1]
    if option == "scan":
        sudo iw @(adap) scan | grep SSID # TODO Ponerlo mas bonito
    elif option == "connect":
        import getpass
        ssid = args[2]
        password = getpass.getpass()
        nmcli dev wifi connect @(ssid) password @(password)
        return
    elif option in ["down", "up"]:
        sudo ip link set @(adap) @(option)
    elif option == "restart":
        wifi @(adap) down
        wifi @(adap) up
    else:
        print(f"La opción {option} no es válida")

