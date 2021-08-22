#!/usr/bin/env python3
import os
import re
import subprocess
import sys
from getpass import getpass

version="0.1.0"
byWindow = "-w" in sys.argv

def datos(argumentos):
    byWindow = "-w" in argumentos
    if byWindow:
        argumentos.pop(argumentos.index("-w"))
    return (" ".join(argumentos), byWindow)


def conexiones_guardadas():
    archivos = os.listdir("/etc/NetworkManager/system-connections")
    return [x for x in archivos if x[-13:] == ".nmconnection"]


def obtener_password(ssid):
    """password = getpass("Contraseña: ")
    p1 = subprocess.Popen(["echo", password], stdout=subprocess.PIPE)
    p2 = subprocess.Popen(["sudo", "-S", "cat", ruta], stdin=p1.stdout, stdout=subprocess.PIPE)
    """
    ruta = "/etc/NetworkManager/system-connections/:ssid".replace(":ssid", ssid)
    with open(ruta, "+r") as f:
        r = re.compile("^psk=.*")
        resultado = [line for line in f if r.match(line)]
        return resultado[0][4:-1] if resultado else ""

if __name__ == "__main__":
    (temp_nombre, byWindow) = datos(sys.argv[1:])
    ssid = temp_nombre + ".nmconnection"
    if ssid in conexiones_guardadas():
        password = obtener_password(ssid)
        nombre = "WIFI:T:WPA;S:%s;P:%s;;" % (ssid, password)
        if byWindow:
            subprocess.run(["qrencode", "-s", "10", "-m", "8", "-o", "/tmp/wifi.png", nombre])
            subprocess.run(["feh", "/tmp/wifi.png", "-^", temp_nombre])
        else:
            subprocess.run(["qrencode", "-t", "UTF8", nombre])
    else:
        print("La conexion no existe")

