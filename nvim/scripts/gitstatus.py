#!/usr/bin/env python3
import os
import subprocess

def comando(cmd) -> str:
    cmd = cmd.split() if type(cmd) == str else cmd
    comando = subprocess.Popen(cmd, stdout=subprocess.PIPE)
    (result, _) = comando.communicate()
    return result.decode("UTF-8")

def obtener_archivos(paths: list, reduce = [], prefijo = ""):
    for p in paths:
        x = prefijo + p
        if os.path.isfile(x):
            reduce.append(x)
        elif os.path.isdir(x):
            obtener_archivos(
                comando(["ls", x]).split(),
                reduce,
                x if x[-1:] == "/" else x + "/"
            )
        else:
            continue
    return reduce

res = comando('git status -s')
print(
    "\n".join(
        obtener_archivos(
            [x for index, x in enumerate(res.split()) if index % 2] # index % 2 get name file o name dir
        )
    )
)

