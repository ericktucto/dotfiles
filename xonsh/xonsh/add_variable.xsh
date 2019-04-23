from xontrib.add_variable.decorators import variable, alias
from time import strftime
from os.path import isfile


def beep():
    echo -e '\a'


def s(cmd):
    return cmd.strip('\n') if type(cmd) is str else cmd


def l(cmd):
    return cmd.split("\n")[:-1] if type(cmd) is str else cmd


@variable
def timeNow():
    return strftime('%H:%M')


@alias
def art(arg):
    @(['php', 'artisan'] + arg)


@alias
def homestead(args):
    _back = ['cd', $PWD]
    commands = ['vagrant'] + args

    cd ~/Homestead
    @(commands)
    @(_back)


@alias
def t(args):
    $[./vendor/bin/phpunit @(args)]


@alias
def pp(arg):
    texto = arg[0]
    $[echo @(texto) | xclip -selection clipboard]


@alias
def pipun(args):
    package = args[0] # name package
    $[xpip uninstall -y @(package)]


@alias
def pipin(args):
    pack = args[0] # {name_package}-{x.x.x}.tar.gz
    $[xpip install dist/@(pack)]


@alias
def rgnome():
    $(gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell --method org.gnome.Shell.Eval 'Main.loadTheme();')


@alias
def dgnome():
    $(env DISPLAY=:0 gnome-shell -r &)


@alias
def setupinit():
    python = 'python3'
    $[@(python) setup.py sdist]


@alias
def csvreset():
    $[pipun csv2seed]
    $[setupinit]
    $[pipin csv2seed-0.1.0.tar.gz]


@alias
def bshellreset():
    $[pipun xontrib-base16-shell]
    $[setupinit]
    $[pipin xontrib-base16-shell-0.1.1.tar.gz]
