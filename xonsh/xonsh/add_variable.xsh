from aliases.cli import *
from aliases.generators import *
from aliases.gnome import *
from aliases.php import *
from aliases.python import *
from aliases.system import *
from os.path import isfile
from time import strftime
from xontrib.add_variable.decorators import variable, alias

def beep():
    echo -e '\a'


def s(cmd):
    return cmd.strip('\n') if type(cmd) is str else cmd


def l(cmd):
    return cmd.split("\n")[:-1] if type(cmd) is str else cmd


@alias
def rrm(args):
    @(['trash'] + args)


@variable
def timeNow():
    return strftime('%H:%M')


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
