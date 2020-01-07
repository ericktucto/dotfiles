from xontrib.add_variable.decorators import alias

@alias
def pipin(args):
    pack = args[0] # {name_package}-{x.x.x}.tar.gz
    $[xpip install dist/@(pack)]


@alias
def pipun(args):
    package = args[0] # name package
    $[xpip uninstall -y @(package)]


@alias
def setupinit():
    python = 'python3'
    $[@(python) setup.py sdist]
