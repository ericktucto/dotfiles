from xontrib.add_variable.decorators import alias

@alias
def gshell(args):
    print_message = lambda lines: print("\n".join(lines))
    commands = {
        "version": ["-v", "-version", "--version"],
        "terminal": ["term", "terminal"]
    }

    if (len(args) == 0):
        print_message([
            "gshell - por Erick Tucto",
            "",
            "Cli para trabajar con el entorno de Gnome Shell"
        ])
        return ""
    elif(args[0] in commands["version"]):
        return "v1.0"

    def getCommand(command, space=1):
        index = args.index(command) + space
        return args[index] if len(args) > index else None

    if set(commands["terminal"]).intersection(args):
        command_terminal = args[0]
        profile_terminal = "/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9"
        action = getCommand(command_terminal)
        if action == "set-transparency":
            level = getCommand("set-transparency")
            # Cambiar nivel de transparencia
            if (level):
                try:
                    level = int(level)
                    path_transparency = "%s/background-transparency-percent" % profile_terminal
                    dconf write @(path_transparency) @(level)
                    return ""
                except ValueError:
                    return "Tienes que setea con número"
            # On/Off Transparencia
            path_transparency = "%s/use-transparent-background" % profile_terminal
            change = 'true' if $(dconf read @(path_transparency))[:-1] == "false" else 'false'
            dconf write @(path_transparency) @(change)
            return ""
        else:
            return "No se puede procesar la orden."


@alias
def dgnome():
    env DISPLAY=:0 gnome-shell -r &


@alias
def rgnome():
    gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell --method org.gnome.Shell.Eval 'Main.loadTheme();'
