# se necesita xdotool, sudo aptitude install xdotool

import serial, re, os
ser = serial.Serial('/dev/ttyUSB0', 9600)
while 1:
    prueba = ser.readline()
    print prueba
    if(re.match("ESC",prueba)):
         os.system("xdotool key Escape")
    elif(re.match("i",prueba)):
        os.system("xdotool key i")
