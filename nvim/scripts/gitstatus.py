#!/usr/bin/env python3
import sys
import os
import re
import subprocess

directorio_actual = os.getcwd()

def comando(cmd, precmd = None) -> tuple:
    cmd = cmd.split() if type(cmd) == str else cmd
    comando = subprocess.Popen(
        cmd,
        stdin=precmd if precmd is None else precmd.stdout,
        stdout=subprocess.PIPE
    )
    (result, _) = comando.communicate()
    return (result.decode("UTF-8"), comando)



(res, _) = comando('git status -s')
a = [x for index, x in enumerate(res.split()) if index % 2]

def obtener_archivos(paths: list, reduce = [], prefijo = ""):
    for p in paths:
        x = prefijo + p
        if os.path.isfile(x):
            reduce.append(x)
        elif os.path.isdir(x):
            obtener_archivos(
                comando(["ls", x])[0].split(),
                reduce,
                x if x[-1:] == "/" else x + "/"
            )
    return reduce

print("\n".join(obtener_archivos(a)))

"""
archivo = sys.argv[1]
resultado = "%s/%s" % (directorio_actual, archivo[2:])
(ruta, linea, busqueda) = obtener(resultado)
subprocess.run(["/home/erick/.dotfiles/nvim/pack/widget/start/fzf.vim/bin/preview.sh", f"{ruta}:{linea}"])
"""
