#!/usr/bin/env xonsh
# -*- coding: utf-8 -*-
import os
import io
import re
import subprocess
import qrcode
import sys
import getpass
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

version="0.1.0"
byWindow = "-w" in sys.argv
admin = ""


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
        comando = ["sudo", "-S"] + comando.split()
        password = bytes(f"{admin}\n", "UTF-8")
        resultado = subprocess.Popen(comando, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate(input=password)
        salida = [r.decode("utf-8") for r in resultado[:-1]][0].split("\n")[:-1]
        return salida
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
    [file, servicio] = sys.argv
    password = "admin" # Password(text="Por favor, introduce tu contraseña")
    ejecutar_comando(f"systemctl start {servicio}")

