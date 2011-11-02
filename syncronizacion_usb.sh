#!/usr/bin/ksh

if [ -d '/media/Expansion Drive__/Documentos' ] 
then
    #importante el / al final del directorio
    rsync -avz --stats /home/miguel/Trabajo/ /media/Expansion\ Drive__/Trabajo/
    rsync -avz --stats /home/miguel/Documentos/ /media/Expansion\ Drive__/Documentos/
    rsync -avz --stats /home/miguel/.vimrc /media/Expansion\ Drive__/miguel/
    rsync -avz --stats /home/miguel/.vim/ /media/Expansion\ Drive__/miguel/.vim/
    #rsync -avz --stats /home/miguel/peliculas/ /media/Expansion\ Drive__/peliculas/
    #rsync -avz --stats /home/miguel/musica/  /media/Expansion\ Drive__/musica/
fi



#Comparisons:
#-eq equal to
#-ne not equal to
#-lt less than
#-le less than or equal to
#-gt greater than
#-ge greater than or equal to

#File Operations:
#-s  file exists and is not empty
#-f  file exists and is not a directory
#-d  directory exists
#-x  file is executable
#-w  file is writable
#-r  file is readable

