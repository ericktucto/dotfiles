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


@alias
def pycheck(args):
    if len(args) == 0:
        return "Pasa nombre de paquete"
    import sys
    template = "Paquete {paquete} {estado}instalado"
    estado = lambda x: "" if x in sys.modules else "no "
    paquetes = [{'paquete': p, 'estado': estado(p)} for p in args]
    return "\n".join([template.format(**paquete) for paquete in paquetes])

