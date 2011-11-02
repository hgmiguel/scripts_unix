#!/bin/bash - 
#===============================================================================
#
#          FILE:  meta4crones.sh
# 
#         USAGE:  ./meta4crones.sh 
# 
#   DESCRIPTION: Transfiere archivos de una ruta origen a un servidor destino,
#                hace un respaldo del archivo a transferir y lo borra
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Miguel Angel Huerta (MXI1003992), 
#       COMPANY: 
#       CREATED: 04/01/2011 03:50:47 p.m. Hora estándar central (México)
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


RUTA_ORIGEN="/home/I1003992/archivos"
RUTA_RESPALDO="/home/I1003992/backup"
#soporta n servidores 
# primer server
SERVER_DESTINO[0]="10.212.8.2"
RUTA_DESTINO[0]="/home/I1003992/archivos"
USUARIO_DESTINO[0]="I1003992"
# segundo server
SERVER_DESTINO[1]="10.212.141.3"
RUTA_DESTINO[1]="/home/I1003992/archivos"
USUARIO_DESTINO[1]="I1003992"


    i=0
    while [[ $i -lt ${#SERVER_DESTINO[*]} ]]; do
        for IN_FILE in $(ls $RUTA_ORIGEN); do
            scp $RUTA_ORIGEN/$IN_FILE ${USUARIO_DESTINO[$i]}@${SERVER_DESTINO[$i]}:${RUTA_DESTINO[$i]}
            RC=$?
            if [ $RC -ne 0 ]
            then
                echo "ERROR en la conexion: scp $RUTA_ORIGEN/$IN_FILE ${USUARIO_DESTINO[$i]}@${SERVER_DESTINO[$i]}:${RUTA_DESTINO[$i]}"
                break
            fi
        done
        i=$(expr $i + 1)
    done            

        for IN_FILE in $(ls $RUTA_ORIGEN); do
            if [ $RC -eq 0 ]
            then
                cp $RUTA_ORIGEN/$IN_FILE  $RUTA_RESPALDO/$(date +%d%b%y%H%M%S)$IN_FILE
                ls -l $RUTA_RESPALDO/$(date +%d%b%y%H%M%S)$IN_FILE # Para estar seguros
                RC=$?
                if [ $RC -eq 0 ]
                then
                    #solo deberiamos de borrar cuando estemos seguros de que el 
                    #archivo este respaldado
                    rm $RUTA_ORIGEN/$IN_FILE
                else
                    echo "ERROR al respaldar: cp $RUTA_ORIGEN/$IN_FILE  $RUTA_RESPALDO/$(date +%d%b%y%H%M%S)$IN_FILE"
                fi
            else
                echo "ERROR en la conexion: scp $RUTA_ORIGEN/$IN_FILE ${USUARIO_DESTINO[$i]}@${SERVER_DESTINO[$i]}:${RUTA_DESTINO[$i]}"
            fi
            echo "INFO procesando: $IN_FILE"
        done

