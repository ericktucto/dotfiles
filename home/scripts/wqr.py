#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import io
import re
import subprocess
import qrcode
import sys
from getpass import getpass
import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, GLib, Gio, GdkPixbuf
from zenipy.zenipy import password as Password

"""
Dependencias:
    - wireless_tools
    - python-gobject (or install module PyObject)
    - zenipy (module python)
    - qrcode (module python)
    - qrencode (to console application)
"""

version="0.2.0"
argumentos = sys.argv[1:]
RUTA_CONEXIONES = "/etc/NetworkManager/system-connections/"
booleans = ["-w", "-d"]


class Seccion:
    def __init__(self, nombre, valores):
        self.nombre = nombre
        self.valores = self.__parsear_atributo(valores)
    def __parsear_atributo(self, atributos: str) -> dict:
        pattern = "(?P<nombre>.*)=(?P<valor>.*)\n"
        valores = dict()
        for resultado in re.finditer(pattern, atributos):
            res = resultado.groupdict()
            valores[res["nombre"]] = res["valor"]
        return valores


def showWindow(title, wifistring):
    window = Gtk.Window(title=title)
    pixbuf = pillow2pixbuf(string2pillow(wifistring))
    image = Gtk.Image(pixbuf=pixbuf)
    window.add(image)
    window.set_resizable(False)
    window.show_all()
    window.connect("destroy", Gtk.main_quit)
    Gtk.main()


def pillow2pixbuf(imagePillow):
    buf = io.BytesIO()
    imagePillow.save(buf, "PNG")
    glib = GLib.Bytes.new(buf.getvalue())
    stream = Gio.MemoryInputStream.new_from_bytes(glib)
    return GdkPixbuf.Pixbuf.new_from_stream(stream, None)


def string2pillow(wifistring):
    qr = qrcode.QRCode(version=1,box_size=10,border=5)
    qr.add_data(wifistring)
    return qr.make_image()


def ejecutar_comando(comando, admin = ""):
    if len(admin) > 0:
        comando = comando.split() if type(comando) == str else comando
        password = subprocess.Popen(["echo", admin], stdout=subprocess.PIPE)
        (resultado, _) = subprocess.Popen(
            ["sudo", "-S"] + comando,
            stdin=password.stdout,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        ).communicate()
        return resultado.decode("UTF-8")
    resultado = subprocess.Popen(comando,shell=True,stdout=subprocess.PIPE)
    salida = resultado.communicate()[0],resultado.returncode
    return salida[0].decode('utf-8')[:-1]

def obtener_nombre():
    if opcion("-d"):
        return ejecutar_comando("iwgetid -r")
    else:
        return " ".join([x for x in argumentos.copy() if x not in booleans])

def conexiones_guardadas(admin) -> list:
    archivos = ejecutar_comando(
        "ls %s" % RUTA_CONEXIONES,
        admin
    ).split('\n')
    return [x for x in archivos if x[-13:] == ".nmconnection"]


def obtener_password(ssid, admin) -> str:
    contenido = ejecutar_comando(
        ["cat", RUTA_CONEXIONES + nombre_conexion],
        admin
    )
    pattern = "\[(?P<nombre>.*)\]\n(?P<valores>(.*=.*\n)*)"
    for res in re.finditer(pattern, contenido):
        s = Seccion(**res.groupdict())
        if s.nombre == "wifi-security":
            return s.valores["psk"]
    return ""

def opcion(nombre):
    if nombre in argumentos:
        index = argumentos.index(nombre)
        return True if nombre in booleans else argumentos[index + 1]
    return None

if __name__ == "__main__":
    byWindow = opcion("-w")
    ssid = obtener_nombre()
    nombre_conexion = ssid + ".nmconnection"
    admin = ""
    if byWindow:
        admin = Password(text="Por favor, introduce tu contraseña")
    else:
        admin = getpass()
    if nombre_conexion in conexiones_guardadas(admin):
        password = obtener_password(nombre_conexion, admin)
        wifistring = f"WIFI:T:WPA;S:{ssid};P:{password};;"
        if byWindow:
            showWindow(ssid, wifistring)
        else:
            subprocess.run(["qrencode", "-t", "UTF8", wifistring])
    else:
        print("La conexion no existe")

