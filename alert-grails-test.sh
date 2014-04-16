#!/bin/bash

while true
do
    # your code here

    #  end of your code
    if [[ "$(ps -ef | grep test-app| grep -v grep)" != "" ]] ; then
        while [ "$(ps -ef | grep test-app| grep -v grep)" != "" ];do
            sleep 10
        done
        notify-send -u critical "Ya sali de las pruebas"
    fi
    sleep 10
done
