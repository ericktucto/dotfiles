#!/usr/bin/env python3
import os
import re
import subprocess
import sys

version="0.1.0"
byWindow = "-w" in sys.argv

def ejecutar_comando(comando):
    resultado = subprocess.Popen(comando,shell=True,stdout=subprocess.PIPE)
    salida = resultado.communicate()[0],resultado.returncode
    return salida[0].decode('utf-8')[:-1]

obtener_nombre = lambda argumentos: " ".join(argumentos) if "-d" not in argumentos else ejecutar_comando("iwgetid -r")

es_sudo = lambda : os.geteuid() == 0

def datos(argumentos):
    byWindow = "-w" in argumentos
    if byWindow:
        argumentos.pop(argumentos.index("-w"))
    nombre_conexion = obtener_nombre(argumentos)
    return (nombre_conexion, byWindow)


def conexiones_guardadas():
    archivos = os.listdir("/etc/NetworkManager/system-connections")
    return [x for x in archivos if x[-13:] == ".nmconnection"]


def obtener_informacion(ruta):
    if es_sudo():
        return ejecutar_comando("cat '%s'" % ruta)
    admin = ejecutar_comando("zenity --password")
    return ejecutar_comando("echo %s | sudo -S cat '%s'" % (admin, ruta))

def obtener_password(ssid):
    ruta = "/etc/NetworkManager/system-connections/:ssid".replace(":ssid", ssid)
    lineas = obtener_informacion(ruta).split()
    r = re.compile("^psk=.*")
    resultado = [linea for linea in lineas if r.match(linea)]
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

