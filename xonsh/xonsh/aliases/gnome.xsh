from xontrib.add_variable.decorators import alias

@alias
def dgnome():
    $(env DISPLAY=:0 gnome-shell -r &)


@alias
def rgnome():
    $(gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell --method org.gnome.Shell.Eval 'Main.loadTheme();')
