# se necesita xdotool, sudo aptitude install xdotool

import serial, re, os, time
from threading import Timer

activo = 0
botonazos = 0
start = 0
ser = serial.Serial('/dev/ttyUSB0', 9600, timeout=1)

def timeout_handler(timeout=10):
    print time.time()
    global activo
    global botonazos
    send_command(botonazos)

def send_command(botonazos):
    global activo
    if (botonazos == 3):
        os.system("xdotool key i")
    elif (botonazos == 1):
        os.system("xdotool key Escape")
    elif (botonazos == 5):
        os.system("xdotool key F12")
    print "botonazos:", botonazos
    activo = 0
    botonazos = 0

while 1:
    prueba = ser.readline()
    if (activo == 1 and re.match("i",prueba)):
        botonazos += 1
    elif (activo == 0 and re.match("i",prueba)):
        timer = Timer(5, timeout_handler)
        activo = 1
        timer.start()
        botonazos = 1

    if(re.match("i",prueba)):
        start=time.time()
    elif(re.match("ESC",prueba)):
        start = 0

    if (start > 0):
        lapso =  time.time() - start 
        if (lapso >= 1.5 and activo == 1):
            print "lapso canceloso"
            send_command(botonazos)
            timer.cancel()

