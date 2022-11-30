#!/usr/bin/env python3
import os
import re
import subprocess
import sys
from zenipy.zenipy import password as Password

version="0.1.0"
byWindow = "-w" in sys.argv
admin = ""

def ejecutar_comando(comando, admin = ""):
    if len(admin) > 0:
        comando = ["sudo", "-S"] + comando.split()
        password = bytes(f"{admin}\n", "UTF-8")
        resultado = subprocess.Popen(comando, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate(input=password)
        salida = [r.decode("utf-8") for r in resultado[:-1]][0].split("\n")[:-1]
        return salida
    resultado = subprocess.Popen(comando,shell=True,stdout=subprocess.PIPE)
    salida = resultado.communicate()[0],resultado.returncode
    return salida[0].decode('utf-8')[:-1]

obtener_nombre = lambda argumentos: " ".join(argumentos) if "-d" not in argumentos else ejecutar_comando("env LANG=en nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2")

es_sudo = lambda : os.geteuid() == 0

def datos(argumentos):
    byWindow = "-w" in argumentos
    if byWindow:
        argumentos.pop(argumentos.index("-w"))
    nombre_conexion = obtener_nombre(argumentos)
    return (nombre_conexion, byWindow)


def conexiones_guardadas(admin):
    archivos = ejecutar_comando("ls /etc/NetworkManager/system-connections/", admin)
    return [x for x in archivos if x[-13:] == ".nmconnection"]


def obtener_informacion(ruta, admin):
    if es_sudo():
        return ejecutar_comando("cat '%s'" % ruta)
    return ejecutar_comando("cat '%s'" % (ruta), admin)

def obtener_password(ssid, admin):
    ruta = "/etc/NetworkManager/system-connections/:ssid".replace(":ssid", ssid)
    lineas = obtener_informacion(ruta, admin)
    r = re.compile("^psk=.*")
    resultado = [linea for linea in lineas if r.match(linea)]
    return resultado[0][4:] if resultado else ""

if __name__ == "__main__":
    (ssid, byWindow) = datos(sys.argv[1:])
    nombre_conexion = ssid + ".nmconnection"
    admin = Password(text="Por favor, introduce tu contraseña")
    if nombre_conexion in conexiones_guardadas(admin):
        password = obtener_password(nombre_conexion, admin)
        nombre = f"WIFI:T:WPA;S:{ssid};P:{password};;"
        if byWindow:
            subprocess.run(["qrencode", "-s", "10", "-m", "8", "-o", "/tmp/wifi.png", nombre])
            subprocess.run(["feh", "/tmp/wifi.png", "-^", ssid])
        else:
            subprocess.run(["qrencode", "-t", "UTF8", nombre])
    else:
        print("La conexion no existe")

