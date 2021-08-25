import re
import sys

class Tiempo():
    def __init__(self, tiempo):
        prog = re.compile(r"(?P<horas>\d*):(?P<minutos>\d*):(?P<segundos>\d*)")
        procesado = prog.match(tiempo)
        self.horas = int(procesado.group("horas"))
        self.minutos = int(procesado.group("minutos"))
        self.segundos = int(procesado.group("segundos"))
    def toString(self):
        return "%s:%s:%s" % (self.horas, self.minutos, self.segundos)

class Calculadora():
    def __init__(self):
        self.inicio = Tiempo("00:00:00")

    def agregar(self, tiempo):
        notacion = lambda numero: "0%d" % numero if numero < 10 else "%d" % numero
        def sumar(numero1, numero2):
            suma = numero1 + numero2
            lleva = suma // 60 # puede ser para segundos o minutos
            return (suma, 0) if lleva == 0 else (suma % 60, lleva)
        tiempo = Tiempo(tiempo)
        (suma, lleva) = sumar(tiempo.segundos, self.inicio.segundos)
        segundos = notacion(suma)
        (suma, lleva) = sumar(tiempo.minutos + lleva, self.inicio.minutos)
        minutos = notacion(suma)
        horas = notacion(tiempo.horas + self.inicio.horas + lleva)
        self.inicio = Tiempo("%s:%s:%s" % (horas, minutos, segundos))

    def display(self):
        print(self.inicio.toString())

if __name__ == '__main__':
    tiempos = sys.argv[1]
    calc = Calculadora()
    for i in tiempos.split():
        calc.agregar(i)
    calc.display()
