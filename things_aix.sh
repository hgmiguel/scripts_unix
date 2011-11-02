#!/bin/ksh

#Parte del monitoreo
netstat -an
lsof -i
ps ax | grep apache | wc -l #(Procesos que origina Apache)
netstat -n -p | grep SYN_REC | awk '{print $5}' | awk -F: '{print $1}' | sort | uniq -c | sort -n #(Tráfico SYN).

# get stdout to variable and stdout at sametime
# Terminal - get stdout to variable and stdout at sametime
{ var="$( ls /home/user | tee >(cat - >&2) )"; } 2>&1; echo -e "*** var=$var"

#The lrud stands for "least recently used daemon" and is run by the 
#kernel to clean up memory fragmentation. 

lsps -a 
vmo -a | egrep "maxclient|maxperm|minperm" 


# preparando para hacer mksysb
#the bos.sysmgt.sysbr fileset in the BOS System Management Tools and Applications software package must be installed. The bos.sysmgt.sysbr fileset is automatically installed. To determine if the bos.sysmgt.sysbr fileset is installed on your system, type:
lslpp -l bos.sysmgt.sysbr

#muestra que grupos pueden hacer root
lsuser -a sugroups root
chuser sugroups="system,admins" root

more /etc/sudoers

#sending a message
write username[tty]
write user@host 
