from xontrib.add_variable.decorators import alias

isModLoaded = lambda mod : True if $(lsmod | grep @(mod)) else False

@alias
def pp(arg):
    texto = arg[0]
    $[echo @(texto) | xclip -selection clipboard]


@alias
def touchpad(args):
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
