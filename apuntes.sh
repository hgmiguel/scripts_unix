
#-------------------------------------------------------------------------------
#  VIM tips
#-------------------------------------------------------------------------------
# mayusculas 
 g~3w 
 g~$


 ctl+q | ctr+v marcado por columnas
http://vim.wikia.com/wiki/Search_and_replace_in_a_visual_selection



#-------------------------------------------------------------------------------
# UNIX 
#-------------------------------------------------------------------------------
umask de usuarios 077 más restrictivos que el root 022

find / -user miguel -fstype 4.2 ! -name /dev/\* -ls | \
    awk '{sum+=$7}; END {print "User miguel total disk use = " sum}'

echo "command" > $(date | awk '{print $3 $2 $6}').$(hostname).sysdoc

date +junk_%d%b%y%H%M%S.junk

#Encontrar archivos que no tengan ese permiso
find . -name '*.tif' ! -perm -004  -print

#-------------------------------------------------------------------------------
#  AIX
#-------------------------------------------------------------------------------

# Informacion del sistema
#List which AIX BOS maintenance levels are partly or full installed:
instfix -i | grep -i AIX_ML
prtconf
lsconf
ps -k # kernel proc 


#Distribucion de discos
lspv -l hdisk0

#architecture type:
#   rs6k MCA nodel
#   rspc PCI model (POWER Reference Platform)
#   chrp PCI model (Common Hardware Reference)
bootinfo -p
#Bit addressing
bootinfo -y 

#To view the boot log:
alog -o -t boot
#--------------------------------------
# System Resource Controller System
#--------------------------------------
#List SRC status:
lssrc -g spooler
#start a subsystem
startsrc -s lpd
#refresh a subsystem
refresh -s lpd
#stop a subsystem
stopsrc -s lpd

#For process started by srcmstr
ps -ef | grep srcmstr
ps -ef | grep PID srcmstr

# volumenes
chfs -a size=+1G /meta4folder

chdev -l hdisk11 -a pv=yes
 

#TREE
ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/' 


#USUARIOS AIX
lsuser -a account_locked unsuccessful_login_count I053702B

grep -i mercedes /etc/passwd
grep I053702 /etc/passwd

chsec -f /etc/security/lastlog -a "unsuccessful_login_count=0" -s I053702B
chuser account_locked=false I053702A

passwd I053702B
abcd1234



1,$ s:/home/user1:/home1/user2:g

root@mxu40l7c:/# /usr/lib/errdemon -l
Error Log Attributes



find:
    join condition with OR
        \( -atime +7 -o -mtime +30 \)
    NOT, For example, the matching criteria below specify all .dat files except gold.dat
        ! -name gold.dat -name \*.dat

    PERM
        -perm 755
            permission = rwxr-xr-x
        -perm -002
            world-writable files
        -perm -4000
            setuid access is set
        -perm -2000
            segid access is set

    -prune "Don't descend into directories encountered."
    -print 
    -ls
    -exec cmd
    -ok cmd Prompt before executinf command on file
    -xdev restrict the search to the filesystem of the starting directory


            find / \( -name a.out -o -name core -o -name '*~' -o name '.*~' -o name 'Â·*Â·' \) \
                -o type f -atime +14 \
                -exec rm -f {} \; -o -fstype nfs -prune

        find \ -type f \( -perm -2000 -o -perm -4000 \) -print | diff - files.secure
            The output from this command could be compared to a saved list of setuid and segid files, in order
            to locate any newly created files requiring investigation

#xargs

ps -ef | grep miguel | awk '{print $1}' | /usr/bin/xargs -n3 ./test_arguments.sh
ps -ef | grep miguel | awk '{print $1}' | /usr/bin/xargs -i ./test_arguments.sh {} 2000

xargs -i chargefee {} 100000

echo a b c d e f | xargs -n3 -i echo before {} after
before a b c d e f after

echo a b c d e f | xargs -i -n3 echo before {} after
before {} after a b c
before {} after d e f


#see multiple tails 
ls -l| xargs -i /bin/sh -c 'echo "**** {}:"; tail -15 {}; echo ""' |more

mkdir -m 755 ./newdir
mkdir -m u=rwx,go=rx ./newdir
mkdir -p ./a/b/c


crfs -v jfs2 -g intranetvg -m /opt/SUNWwbsvr -p rw -a size=10G -A yes

crfs -v jfs2 -g intranetvg -m /opt/sunone -p rw -a size=5G -A yes


crfs -v jfs2 -g intranetvg -m /ImagenesRetiros -p rw -a size=4G -A yes


crfs -v jfs2 -g intranetvg -m /temporal -p rw -a size=10G -A yes

root@mxu40l0m:/opt# crfs -v jfs2 -g intranetvg -m /opt/SUNWwbsvr -p rw -a size=10G -A yes
File system created successfully.
10485236 kilobytes total disk space.
New File System size is 20971520
root@mxu40l0m:/opt# crfs -v jfs2 -g intranetvg -m /opt/sunone -p rw -a size=5G -A yes
File system created successfully.
5242516 kilobytes total disk space.
New File System size is 10485760
root@mxu40l0m:/opt# mount /opt/SUNWwbsvr
root@mxu40l0m:/opt# mount /opt/sunone



df -k | awk 'function ceil(valor)    {  return (valor == int(valor)) ? valor : int(valor)+1  } {printf "%s\t%s\n",$6,ceil($2/1024/1024)}'




tar -p option, which restores ownership and access modes along with the files from an archive(it must be run as root to set file ownership).

#copy /chem/olddir to /chem1/newdir
cd /chem1
tar -cf - -C /chem olddir | tar -xvpf -
mv olddir newdir


cp -pr /chem/olddir /chem1

#tar works differently than cp does in the case of symbolic links. tar recreate
#symbolic links in the new location, while cp converts symbolic links to regular files


#Para empaquetar y comprimir al vuelo:
tar -cvf - * | gzip -c > nombre_archivo.tar.gz

#Para descomprimir y desempaquetar al vuelo:
gunzip < nombre_archivo.tar.gz | tar -xvf -

#Para listar el contenido sin descomprimir ni desempaquetar al disco:
gunzip -c nombre_archivo.tar.gz | tar -tf -




#comparar directorios
diff -r
dircmp


#CRON
# if no output redirection is performed, the output is sent via mail to the usesr who ran the command.
#fields
    minutes 0-59
    hours 0-23 (0=midnight)
    day-of-month 1-31
    month 1-12
    weekday (0-6. 0=Sunday)


#SYSLOG
    #the logger utility can  be used to send messages to the syslog facility from a shell sscript. For
    #example, the following command sends an alert-level message via the auth facility:
    logger -p auth.alert -t DOT_FILE_CHK \
        "$user's $file is world-writeable"

#!/bin/sh
# Esto ya lo hace AIX
cd /var/adm
if [ -r su.log.1 ]; then
    mv -f su.log.1 su.log.2
fi
if [ -r su.log.0 ]; then
    mv -f su.log.0 su.log.1
fi
if [ -r su.log ]; then
    cp su.log su.log0
fi
cat /dev/null > su.log

#swatch
#http://swatch.sourceforge.net/
swatch -c /etc/swatch.config -t /var/adm/messages
#logcheck
#http://www.psionic.com/abacus/logcheck/

#Error
/usr/lib/errdeamon -l


#packages
# 1 AIX
# 2 Solaris
    lslpp -l all #list installed packages
    pkginfo
    lslpp -f     #list package contents
    pkginfo -l
    lslpp -p     #list prerequisites
    lslpp -w     #show file's original package
    pkgchk -l -p
    installp -l -d device   #list available packages on media
    installp -acX #install package
    pkgadd
    installp -p   #preview installation                                                               hhhhhhh
    install -a -v #verify package
    pkgchk
    install -u    #remove package
    pkgrm

     installp

     klasdfjkljasdfkl
#reset de servicio
refresh -s inetd

ls | tee [-a] junk2 | wc -w

PS1

echo There are $(set | wc -l) variables set


#TEST
man pg

banner '*'
banner "*"
banner \*

bg %jobno
fg %jobno


#Solaris
#newfs command is a front-end to the mkfs program, which created UFS filesystems on disk partitions. 
#You can increase the size of a filesystem by using the growfs command, among other commands.


#AIX
uname -M
uname -m

mxu40p0a/#uname -m
000249AAD200
mxu40p0a/#uname -M
IBM,7047-185
mxu40p0a/#


WSM


df -g | sort -rk4


mxu40p0a/#ps -ef  | egrep "(rsct|STIME)"
     UID    PID   PPID   C    STIME    TTY  TIME CMD
    root 217214 196722   0   Nov 21      -  0:00 /usr/sbin/rsct/bin/IBM.ServiceRMd
    root 262342 196722   0   Nov 21      -  0:10 /usr/sbin/rsct/bin/vac8/IBM.CSMAgentRMd
    root 266370 196722   0   Nov 21      -  0:03 /usr/sbin/rsct/bin/rmcd -a IBM.LPCommands -r
    root 442374 196722   0   Dec 08      -  0:00 /usr/sbin/rsct/bin/IBM.ERrmd
    root 512180 196722   0   Dec 08      -  0:07 /usr/sbin/rsct/bin/IBM.HostRMd
    root 770292 196722   0   Dec 09      -  0:00 /usr/sbin/rsct/bin/IBM.FSrmd


Clases 

ps -e -o pid,tag,user,group,comm,args | grep java

was
    /usr/IBM/WebSphere/AppServer/java/bin/

    mkclass  -a inheritance=yes -a localshm=yes was
    vi /etc/wlm/current/rules

* IBM_PROLOG_END_TAG
* class resvd user group application type tag
was      -    -      -    /usr/IBM/WebSphere/AppServer/java/bin/*  -  -
System   -    root   -    -           -   -
Default  -    -      -    -           -   -
   


<WEBAPP uri="/RetirosAforeWeb" path="/opt/SUNWwbsvr/https-afore-captura-retiros-2712/webapps/https-afore-captura-retiros-2712/RetirosAforeWeb" enabled="true"/>

m4user

wlmcntrl -p



    mkclass  -a inheritance=yes -a localshm=yes meta4
    /meta4folder/meta4/java/jre/bin/*
    meta4

wlmcntrl -u

ps -e -o class,pid,tag,user,group,comm,args | sort | egrep "(was|meta4|oracle)"


mkclass  -a inheritance=yes -a localshm=yes oracle
S100185A


mkclass  -a inheritance=yes -a localshm=yes monitoreo
/home/E208225B/chazz/nmon/



rsct
Resource Monitoring and Control (RMC)



condition 1:
        Name                   = "cpu 90%"
        MonitorStatus          = "Monitored and event monitored"
        ResourceClass          = "IBM.Processor"
        EventExpression        = "(PctTimeUser >= 90) && (PctTimeUser@P >= 90)"
        EventDescription       = "The example event expression causes the generation of an event when \nthe average time the processor is in user mode is at least 80% for two \nconsecutive observations.                              "
        RearmExpression        = "(PctTimeUser < 30) && (PctTimeUser@P < 30)"
        RearmDescription       = "The example rearm expression reenables events after an event has \nbeen generated and the time in user mode decreases below 50% for two \nconsecutive observations."
        SelectionString        = ""
        Severity               = "w"
        NodeNames              = {}
        MgtScope               = "l"
        Toggle                 = "Yes"
        EventBatchingInterval  = 0
        EventBatchingMaxEvents = 0



mkcondition -r IBM.Processor \ 
-e "(PctTimeUser >= 90) && (PctTimeUser@P >= 90)" \ 
-E "(PctTimeUser < 75) && (PctTimeUser@P < 75)" \ 
-d "Generate event when PctTimeUser > 90% "  \ 
-D "Restart monitoring tmp again after back down < 75% "\ 
-S c \ 
"CRITICAL CPU > 90%"
        
chcondition -r IBM.Processor \ 
-e "(PctTimeUser >= 80) && (PctTimeUser@P >= 80)" \ 
-S i \ 
"CRITICAL CPU > 90%"


lsresponse "correo cpu 80%"
Displaying response information:

        ResponseName    = "correo cpu 80%"
        Action          = "correo"
        DaysOfWeek      = 1-7
        TimeOfDay       = 0000-2400
        ActionScript    = "/usr/sbin/rsct/bin/notifyevent miguelangel.huerta@mx.                                   ing.com
        ReturnCode      = 0
        CheckReturnCode = "y"
        EventType       = "?"
        StandardOut     = "y"
        EnvironmentVars = ""
        UndefRes        = "y"
        EventBatching   = "n"


lscondition "Processors user time"
Displaying condition information:

condition 1:
        Name                   = "Processors user time"
        MonitorStatus          = "Not monitored"
        ResourceClass          = "IBM.Host"
        EventExpression        = "PctTotalTimeUser >= 70"
        EventDescription       = "An event is generated when the average time all processors are executing in user mode is at least 70 percent of the time."
        RearmExpression        = "PctTotalTimeUser < 10"
        RearmDescription       = "The event is rearmed when the user time decreases below 10 percent."
        SelectionString        = ""
        Severity               = "i"
        NodeNames              = {}
        MgtScope               = "l"
        Toggle                 = "Yes"
        EventBatchingInterval  = 0
        EventBatchingMaxEvents = 0





Elimina esta accion
chresponse -p -n "test" \
"test prueba"

Añade una accion
chresponse -a -n "test" \
-s "\"/usr/sbin/rsct/bin/notifyevent miguelangel.huerta@mx.ing.com,raulosvaldo.marquez@mx.ing.com\"" \
-e b \
"test prueba"

"
################################
### SCRIPT para activar RCM
################################
ls -l /etc/mail/aliases
cp -p /etc/mail/aliases /etc/mail/aliases.orig
vi /etc/mail/aliases

# Alias para el equipo de infra unix
infraestructura: miguelangel.huerta@mx.ing.com, raulosvaldo.marquez@mx.ing.com

# Alias para el equipo de desarrollo
desarrollo: ricardo.rodriguez@mx.ing.com

sendmail -bi

#echo $(uname -a) | mailx -s"prueba" "infraestructura,desarrollo"

lscondition "Processors user time"

chcondition -r IBM.Host \
-e "(PctTotalTimeUser >= 90) && (PctTotalTimeUser@P >= 90)" \
-d "An event is generated when the average time all processors are executing in user mode is at least 90 percent of the time." \
-E "(PctTotalTimeUser <= 10) && (PctTotalTimeUser@P <= 10)" \
"Processors user time"

lscondition "Processors user time"
lscondition "Processors idle time"

chcondition -r IBM.Host \
-e "(PctTotalTimeIdle <= 10) && (PctTotalTimeIdle@P <= 10)" \
-d "An event is generated when the average time all processors are idle at least 70 percent of the time." \
-E "(PctTotalTimeIdle >= 70) && (PctTotalTimeIdle@P >= 70)" \
"Processors idle time"
lscondition "Processors idle time"

lsresponse "E-mail Unix Team"

mkresponse -n "E-mail UNIX Team" \
-s "\"/usr/sbin/rsct/bin/notifyevent infraestructura\"" \
-e b \
"E-mail Unix Team"

lsresponse "E-mail Unix Team"

mkcondresp "Processors user time" "E-mail Unix Team"
mkcondresp "Processors idle time" "E-mail Unix Team"

startcondresp "Processors user time"
startcondresp "Processors idle time"


"/usr/sbin/rsct/bin/notifyevent miguelangel.huerta@mx.ing.com raulosvaldo.marquez@mx.ing.com"
"/usr/sbin/rsct/bin/notifyevent miguelangel.huerta@mx.ing.com raulosvaldo.marquez@mx.ing.com"


#eliminar 
chresponse -p -n "E-mail Unix Team" \
"E-mail Unix Team"


chresponse -a -n "E-mail Unix Team" \
-s "\"/usr/sbin/rsct/bin/notifyevent infraestructura\"" \
-e b \
"E-mail Unix Team"







lsresponse "E-mail Unix Team"
Displaying response information:

        ResponseName    = "E-mail Unix Team"
        Action          = "E-mail UNIX Team"
        DaysOfWeek      = 1-7
        TimeOfDay       = 0000-2400
        ActionScript    = "/usr/sbin/rsct/bin/notifyevent miguelangel.huerta@mx.ing.com;raulosvaldo.marquez@mx.ing.com"
        ReturnCode      = -1
        CheckReturnCode = "n"
        EventType       = "b"
        StandardOut     = "n"
        EnvironmentVars = ""
        UndefRes        = "n"
        EventBatching   = "n"
root@mxu40p0a:/#


$ Confirm() { read -sn 1 -p "$1 [Y/N]? "; [[ $REPLY = [Yy] ]]; } 


mxu40p0a/usr/IBM/WebSphere/AppServer/profiles/AppSrv01/bin#./iniciaServidor.sh




Elimina esta accion
chresponse -p -n "E-mail UNIX Team" \
"E-mail Unix Team"

chresponse -a -n "E-mail Unix Team" \
-s "\"/usr/sbin/rsct/bin/notifyevent miguelangel.huerta@mx.ing.com,raulosvaldo.marquez@mx.ing.com\"" \
-e b \
"E-mail Unix Team"

E208064B



#-------------------------------------------------------------------------------
#  RMC
#-------------------------------------------------------------------------------
"


#eliminar 
chresponse -p -n "E-mail Unix Team" \
"E-mail Unix Team"


chresponse -a -n "E-mail Unix Team" \
-s "\"/usr/sbin/rsct/bin/notifyevent infraestructura\"" \
-e b \
"E-mail Unix Team"


#modify a response
#Elimina esta accion
chresponse -p -n "Email Logs WAS" \
"E-mail Unix Team"

chresponse -a -n "Email Logs WAS" \
-s "\"/opt/scripts/mail_logs_was.sh infraestructura,desarrollo\"" \
-e a \
"E-mail Unix Team"

"
#make a sensor
/usr/sbin/rsct/bin/mksensor -i 60 was_servers_check '/opt/scripts/check_was_servers.sh server1'
lssensor

mkcondition -r IBM.Sensor \
-e 'Int32 <=0' \
-E 'Int32 > 0' \
-d 'An event will be generated whenever the was does not run.' \
-D 'The event will be rearmed when the was runs.' \
-s 'Name == "was_servers_check"' \
-S c \
'was server state'


lscondition


mkcondresp "was server state" "test prueba"

startcondresp "was server state" "test prueba"


#----------------------
/usr/sbin/rsct/bin/mksensor -i 90 was_servers_check '/opt/scripts/check_was_servers.sh "(nodeagent|dmgr|server1)"'

mkcondition -r IBM.Sensor \
-e 'Int32 < 3' \
-E 'Int32 = 3' \
-d 'An event will be generated whenever the was does not run.' \
-D 'The event will be rearmed when the was runs.' \
-s 'Name == "was_servers_check"' \
-S c \
'was server status'

mkcondresp "was server status" "E-mail Unix Team"

startcondresp "was server status" "E-mail Unix Team"

#---------------------------------------------
/usr/sbin/rsct/bin/mksensor -i 90 \
was_servers_check '/opt/scripts/check_was_servers.sh "(dmgr|nodeagent|server1|server2|server3)"'


mkcondition -r IBM.Sensor \
-e 'Int32 < 5' \
-E 'Int32 = 5' \
-d 'An event will be generated whenever the was does not run.' \
-D 'The event will be rearmed when the was runs.' \
-s 'Name == "was_servers_check"' \
-S c \
'was server status'

mkcondresp "was server status" "E-mail Unix Team"

startcondresp "was server status" "E-mail Unix Team"



#-------------------------------------------------------------------------------
#  NASH
#-------------------------------------------------------------------------------
#log
/var/opt/SUNWappserver7/domains/domain1/server1/config



#-------------------------------------------------------------------------------
#  PORTAL
#-------------------------------------------------------------------------------
#log
/usr/IBM/WebSphere/wp_profile/logs/server1
/usr/IBM/WebSphere/wp_profile/shells


D1E21BA3   0124032911 I S errdemon       LOG FILE EXPANDED TO REQUESTED SIZE


http://www.ibm.com/developerworks/forums/thread.jspa?messageID=14574254&tstart=0#14574254


:1,$ s:\\/home/user1\\/home1/user2/g



"
A database process is running under user 'dbuser'. an operator logs in as dbuser and wants to stop all the 
operator needs to remove all leading comments

$AdminControl queryNames *,type=DataSource,name=SIIF

$AdminControl queryNames *,type=DataSource


Generador de passwords
tr -dc A-Za-z0-9_$ < /dev/urandom | head -c 10



cat <<EOF | mailx -s"Archivos transferidos bdcomercial" "miguelangel.huerta@mx.ing.com"
Archivos transferidos bdcomercial meta4 a ingmexico:

$(ls .)
EOF



201102251.MOD ctas_no_enviadas.txt ctas_no_intgrdas.txt ctas_no_sustitu.txt

/safre/int/shells/NotificacionesEmail.jar /safre/int/shells/TipoCambio.jar /safre/int/shells/copiaEmpleados.jar /sap/vta_cruzada/comision/4gl/CargaVentas.jar /safre/taa/shells/legacyCallCenter/legacyCallCenter.jar

ingmexico safre# find . -name 'NotificacionesEmail.jar'
ingmexico safre# find . -name '*.jar'
./int/shells/PagoDeComisiones/pagoDeComisiones.jar
./int/shells/CargaImagenesRetiros.jar
ingmexico safre# cd


$ /usr/local/bin/sudo su -
>>> sudoers file: syntax error, line 29 <<<
/usr/local/bin/sudo: parse error in /usr/local/etc/sudoers near line 29
$ cd /usr/local/etc
$ ksh
$ ls -lt
total 216
-r--r-----   1 root     root        5034 Mar  3 12:43 sudoers
-r--r-----   1 root     root        4701 Aug 27  2010 sudoers_21Oct2010
-rw-r--r--   1 bin      bin         2475 May  5  2010 sshd_config
-r--r--r--   1 bin      bin          858 Jul 31  2007 banner
-rw-------   1 root     other        883 Mar 26  2003 ssh_host_rsa_key
-rw-r--r--   1 root     other        225 Mar 26  2003 ssh_host_rsa_key.pub
-rw-------   1 root     other        668 Mar 26  2003 ssh_host_dsa_key
-rw-r--r--   1 root     other        605 Mar 26  2003 ssh_host_dsa_key.pub
-rw-------   1 root     other        530 Mar 26  2003 ssh_host_key
-rw-r--r--   1 root     other        334 Mar 26  2003 ssh_host_key.pub
-rw-r--r--   1 bin      bin        88039 Nov 21  2002 moduli
-rw-r--r--   1 bin      bin         1144 Nov 21  2002 ssh_config
$
$ cat


/usr/informix 6GB
vgprestadora

migrar vg -> 

virtuales -->>> 250 / 2 virtuales cadaquien 1



scp pruebasinformix - > /informix11/productos
                        /usr/informix


/opt/SUNWwbsvr 



mxu40p0a/#cd /controlm/agente/ctm/scripts
mxu40p0a/controlm/agente/ctm/scripts#ls -l
total 136
-rwxrwxrwx    1 S100011A controlm        938 Dec 27 2004  VERSION
-rwxr-xr-x    1 S100011A controlm       7575 Jul  2 2006  ag_diag_comm
-rwxrwxrwx    1 S100011A controlm        543 Jan 10 12:39 rc.agent_user
-rwxr-xr-x    1 S100011A controlm      10055 Mar 14 2007  shagent
-rwxr-xr-x    1 S100011A controlm       3274 Mar  8 2005  sharch
-rwxr-xr-x    1 S100011A controlm      15507 Jul  6 2008  shut-ag
-rwxr-xr-x    1 S100011A controlm      17328 Jul  2 2008  start-ag
mxu40p0a/controlm/agente/ctm/scripts#pwd
/controlm/agente/ctm/scripts
mxu40p0a/controlm/agente/ctm/scripts#




./stopServer.sh WebSphere_Portal -username WSSRVMXA02313 -password \{\"PCOd7\(7uc\*
ls -ltr
./startServer.sh WebSphere_Portal -username WSSRVMXA02313 -password \{\"PCOd7\(7uc\*




-rwxr-xr-x    1 root     system    270366720 Mar 04 15:25 CZT85ML_Informix_Ultimate_115_FC8.tar
-rwxr-xr-x    1 root     system    206520320 Mar 04 15:37 CZV0QEN_4GL_Compiler_Development_750_FC5.tar
-rwxr-xr-x    1 root     system    144066560 Mar 04 15:46 CZV10EN_4GL_Compiler_Runtime_750_FC5.tar
-rwxr-xr-x    1 root     system    170557440 Mar 04 15:57 CZV1AEN.tar
-rwxr-xr-x    1 root     system    152586240 Mar 04 16:05 CZV1VEN_4GL_Interactive_Debugger_750_FC5.tar


GCC

root@mxu40l0n:/gcc4.2.4.2# ls -l
total 30448
-rw-------    1 I1003992 staff       1764055 Mar 08 11:02 bash-4.2-2.aix5.1.ppc.rpm
-rw-------    1 I1003992 staff        122731 Mar 08 11:35 bzip2-1.0.6-1.aix5.1.ppc.rpm
-rw-------    1 I1003992 staff        388451 Mar 08 10:38 expat-2.0.1-3.aix5.1.ppc.rpm
-rw-------    1 I1003992 staff       1596520 Mar 08 10:38 gcc-4.2.4-2.aix6.1.ppc.rpm
-rw-------    1 I1003992 staff       2919373 Mar 08 10:38 gcc-cpp-4.2.4-2.aix6.1.ppc.rpm
-rw-------    1 I1003992 staff       2223925 Mar 08 10:40 gettext-0.17-1.aix5.1.ppc.rpm
-rw-------    1 I1003992 staff       4829869 Mar 08 11:18 glib2-2.22.5-2.aix5.1.ppc.rpm
-rw-------    1 I1003992 staff        188225 Mar 08 11:02 info-4.13a-2.aix5.1.ppc.rpm
-rw-------    1 I1003992 staff        202716 Mar 08 10:37 libgcc-4.2.4-2.aix6.1.ppc.rpm
-rw-------    1 I1003992 staff        319771 Mar 08 11:18 pcre-8.12-1.aix5.1.ppc.rpm
-rw-------    1 I1003992 staff        818345 Mar 08 11:33 readline-6.2-1.aix5.1.ppc.rpm
-rw-------    1 I1003992 staff        199104 Mar 08 11:35 zlib-1.2.5-1.aix5.1.ppc.rpm
root@mxu40l0n:/gcc4.2.4.2# rpm -ivh expat-2.0.1-3.aix5.1.ppc.rpm
expat                       ##################################################
root@mxu40l0n:/gcc4.2.4.2# rpm -ivh gettext-0.17-1.aix5.1.ppc.rpm
error: failed dependencies:
        libglib-2.0.a(libglib-2.0.so.0) is needed by gettext-0.17-1
        libxlsmp.a(smprt.o) is needed by gettext-0.17-1
root@mxu40l0n:/gcc4.2.4.2# rpm -Uvh gettext-0.17-1.aix5.1.ppc.rpm --nodeps
gettext                     ##################################################
root@mxu40l0n:/gcc4.2.4.2# rpm -Uvh bash-4.2-2.aix5.1.ppc.rpm
bash                        ##################################################
root@mxu40l0n:/gcc4.2.4.2# rpm -Uvh info-4.13a-2.aix5.1.ppc.rpm
warning: /opt/freeware/info/dir created as /opt/freeware/info/dir.rpmnew
info                        ##################################################
Please check that /etc/info-dir does exist.
You might have to rename it from /etc/info-dir.rpmsave to /etc/info-dir.
root@mxu40l0n:/gcc4.2.4.2# rpm -Uvh readline-6.2-1.aix5.1.ppc.rpm
readline                    ##################################################
root@mxu40l0n:/gcc4.2.4.2# rpm -Uvh zlib-1.2.5-1.aix5.1.ppc.rpm
zlib                        ##################################################
root@mxu40l0n:/gcc4.2.4.2# rpm -Uvh bzip2-1.0.6-1.aix5.1.ppc.rpm
bzip2                       ##################################################
root@mxu40l0n:/gcc4.2.4.2# rpm -Uvh pcre-8.12-1.aix5.1.ppc.rpm
pcre                        ##################################################
root@mxu40l0n:/gcc4.2.4.2# rpm -Uvh glib2-2.22.5-2.aix5.1.ppc.rpm
glib2                       ##################################################
root@mxu40l0n:/gcc4.2.4.2# 4-2.aix6.1.ppc.rpm gcc-cpp-4.2.4-2.aix6.1.ppc.rpm                                            <
libgcc                      ##################################################
gcc                         ##################################################
gcc-cpp                     ##################################################
root@mxu40l0n:/gcc4.2.4.2# gcc --version
gcc (GCC) 4.2.4
Copyright (C) 2007 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.







-rwxr-xr-x   1 oprsafre safre        304112 Mar 09 11:19 i01755359625544022110127.tif
-rwxr-xr-x   1 oprsafre safre        141460 Mar 09 11:19 i01755359625544083110127.tif
-rwxr-xr-x   1 oprsafre safre        266212 Mar 09 11:19 i01755359625544094110127.tif
-rwxr-xr-x   1 oprsafre safre        230504 Mar 09 11:19 i01755359625544185110127.tif
-rw-r--r--   1 oprsafre safre        155244 Mar 09 11:19 i01755467626544011110127.tif
-rw-r--r--   1 oprsafre safre        303624 Mar 09 11:19 i01755467626544022110127.tif
-rw-r--r--   1 oprsafre safre        168332 Mar 09 11:19 i01755467626544083110127.tif
-rw-r--r--   1 oprsafre safre        192860 Mar 09 11:19 i01755467626544154110127.tif
-rw-r--r--   1 oprsafre safre        200472 Mar 09 11:19 i01755467626544175110127.tif
-rw-r--r--   1 oprsafre safre        174720 Mar 09 11:19 i01755529193544011110127.tif
-rw-r--r--   1 oprsafre safre        206816 Mar 09 11:19 i01755529193544022110127.tif
-rw-r--r--   1 oprsafre safre        158064 Mar 09 11:19 i01755529193544083110127.tif
-rw-r--r--   1 oprsafre safre        118700 Mar 09 11:19 i01755529193544154110127.tif
-rw-r--r--   1 oprsafre safre        239776 Mar 09 11:19 i01755529193544175110127.tif
-rw-r--r--   1 oprsafre safre        112444 Mar 09 11:19 i01755545637544011110127.tif
-rw-r--r--   1 oprsafre safre        196976 Mar 09 11:19 i01755545637544022110127.tif
-rw-r--r--   1 oprsafre safre        105996 Mar 09 11:19 i01755545637544083110127.tif
-rw-r--r--   1 oprsafre safre        151092 Mar 09 11:19 i01755545637544154110127.tif
-rw-r--r--   1 oprsafre safre        184772 Mar 09 11:19 i01755545637544175110127.tif
-rwxr-xr-x   1 oprsafre safre        129388 Mar 09 11:19 i01755584636544011110127.tif
-rwxr-xr-x   1 oprsafre safre        275148 Mar 09 11:19 i01755584636544022110127.tif
-rwxr-xr-x   1 oprsafre safre        100800 Mar 09 11:19 i01755584636544083110127.tif
-rwxr-xr-x   1 oprsafre safre        177108 Mar 09 11:19 i01755584636544174110127.tif
-rw-r--r--   1 oprsafre safre        112276 Mar 09 11:19 i01755584636544185110127.tif
-rw-r--r--   1 oprsafre safre        163992 Mar 09 11:19 i01755662341544011110127.tif
-rw-r--r--   1 oprsafre safre        225720 Mar 09 11:19 i01755662341544022110127.tif
-rw-r--r--   1 oprsafre safre        137656 Mar 09 11:19 i01755662341544083110127.tif
-rw-r--r--   1 oprsafre safre        100456 Mar 09 11:19 i01755662341544154110127.tif
-rw-r--r--   1 oprsafre safre        252360 Mar 09 11:19 i01755662341544175110127.tif
-rwxr-xr-x   1 oprsafre safre        140884 Mar 09 11:19 i01755670294544011110127.tif
-rwxr-xr-x   1 oprsafre safre        261920 Mar 09 11:19 i01755670294544022110127.tif
-rwxr-xr-x   1 oprsafre safre        164444 Mar 09 11:19 i01755670294544083110127.tif
-rwxr-xr-x   1 oprsafre safre         62716 Mar 09 11:19 i01755670294544154110127.tif
-rwxr-xr-x   1 oprsafre safre        213496 Mar 09 11:19 i01755670294544175110127.tif
-rwxr-xr-x   1 oprsafre safre         64780 Mar 09 11:19 i01755672274544011110127.tif
-rwxr-xr-x   1 oprsafre safre        254400 Mar 09 11:19 i01755672274544022110127.tif
-rwxr-xr-x   1 oprsafre safre         22412 Mar 09 11:19 i01755672274544083110127.tif
-rwxr-xr-x   1 oprsafre safre        278748 Mar 09 11:19 i01755672274544094110127.tif
-rw-r--r--   1 oprsafre safre        167216 Mar 09 11:19 i01755676465544011110127.tif
-rw-r--r--   1 oprsafre safre        109088 Mar 09 11:19 i01755676465544022110127.tif
-rw-r--r--   1 oprsafre safre         43104 Mar 09 11:19 i01755676465544083110127.tif
-rw-r--r--   1 oprsafre safre         82268 Mar 09 11:19 i01755676465544154110127.tif
-rw-r--r--   1 oprsafre safre        158144 Mar 09 11:19 i01755676465544175110127.tif
-rw-r--r--   1 oprsafre safre        187008 Mar 09 11:19 i01755688429544011110127.tif
-rw-r--r--   1 oprsafre safre         86116 Mar 09 11:19 i01755688429544022110127.tif
-rw-r--r--   1 oprsafre safre        176660 Mar 09 11:19 i01755688429544083110127.tif
-rw-r--r--   1 oprsafre safre        145300 Mar 09 11:19 i01755688429544154110127.tif
-rw-r--r--   1 oprsafre safre        192812 Mar 09 11:19 i01755688429544175110127.tif
-rw-r--r--   1 oprsafre safre        165676 Mar 09 11:19 i01755822184544011110127.tif
-rw-r--r--   1 oprsafre safre         95624 Mar 09 11:19 i01755822184544022110127.tif
-rw-r--r--   1 oprsafre safre         70416 Mar 09 11:19 i01755822184544083110127.tif
-rw-r--r--   1 oprsafre safre         70560 Mar 09 11:19 i01755822184544154110127.tif
-rw-r--r--   1 oprsafre safre        161476 Mar 09 11:19 i01755822184544175110127.tif
-rw-r--r--   1 oprsafre safre        176736 Mar 09 11:19 i01755931118544011110127.tif
-rw-r--r--   1 oprsafre safre        161484 Mar 09 11:19 i01755931118544022110127.tif
-rw-r--r--   1 oprsafre safre         75328 Mar 09 11:19 i01755931118544083110127.tif
-rw-r--r--   1 oprsafre safre         69096 Mar 09 11:19 i01755931118544154110127.tif
-rw-r--r--   1 oprsafre safre        212804 Mar 09 11:19 i01755931118544175110127.tif
-rw-r--r--   1 oprsafre safre        156028 Mar 09 11:19 i01755944830544011110127.tif
-rw-r--r--   1 oprsafre safre        182448 Mar 09 11:19 i01755944830544022110127.tif
-rw-r--r--   1 oprsafre safre        161864 Mar 09 11:19 i01755944830544083110127.tif
-rw-r--r--   1 oprsafre safre        199084 Mar 09 11:19 i01755944830544154110127.tif
-rw-r--r--   1 oprsafre safre        234700 Mar 09 11:19 i01755944830544175110127.tif
-rw-r--r--   1 oprsafre safre        191468 Mar 09 11:19 i01755946934544011110127.tif
-rw-r--r--   1 oprsafre safre        127976 Mar 09 11:19 i01755946934544022110127.tif
-rw-r--r--   1 oprsafre safre        109956 Mar 09 11:19 i01755946934544083110127.tif
-rw-r--r--   1 oprsafre safre         77920 Mar 09 11:19 i01755946934544154110127.tif
-rw-r--r--   1 oprsafre safre        231276 Mar 09 11:19 i01755946934544175110127.tif
-rw-r--r--   1 oprsafre safre        124696 Mar 09 11:19 i01755950183544011110127.tif
-rw-r--r--   1 oprsafre safre        272132 Mar 09 11:19 i01755950183544022110127.tif
-rw-r--r--   1 oprsafre safre        163372 Mar 09 11:19 i01755950183544083110127.tif
-rw-r--r--   1 oprsafre safre         71352 Mar 09 11:19 i01755950183544154110127.tif
-rw-r--r--   1 oprsafre safre        158308 Mar 09 11:19 i01755950183544175110127.tif
-rw-r--r--   1 oprsafre safre        126332 Mar 09 11:19 i01765131436544011110127.tif
-rw-r--r--   1 oprsafre safre        182528 Mar 09 11:19 i01765131436544022110127.tif
-rw-r--r--   1 oprsafre safre         46688 Mar 09 11:19 i01765131436544083110127.tif
-rw-r--r--   1 oprsafre safre        217752 Mar 09 11:19 i01765131436544154110127.tif
-rw-r--r--   1 oprsafre safre         95760 Mar 09 11:19 i01765131436544165110127.tif
-rw-r--r--   1 oprsafre safre        169860 Mar 09 11:19 i01765150121544011110127.tif
-rw-r--r--   1 oprsafre safre        165440 Mar 09 11:19 i01765150121544022110127.tif
-rw-r--r--   1 oprsafre safre         56536 Mar 09 11:19 i01765150121544083110127.tif
-rw-r--r--   1 oprsafre safre        175780 Mar 09 11:19 i01765150121544154110127.tif
-rw-r--r--   1 oprsafre safre        182820 Mar 09 11:19 i01765150121544165110127.tif
-rw-r--r--   1 oprsafre safre        146104 Mar 09 11:19 i01765150493544011110127.tif
-rw-r--r--   1 oprsafre safre        103544 Mar 09 11:19 i01765150493544022110127.tif
-rw-r--r--   1 oprsafre safre         42904 Mar 09 11:19 i01765150493544083110127.tif
-rw-r--r--   1 oprsafre safre         94976 Mar 09 11:19 i01765150493544154110127.tif
-rw-r--r--   1 oprsafre safre        167116 Mar 09 11:19 i01765150493544165110127.tif
-rw-r--r--   1 oprsafre safre        118504 Mar 09 11:19 i01765426893544011110127.tif
-rw-r--r--   1 oprsafre safre        158352 Mar 09 11:19 i01765426893544022110127.tif
-rw-r--r--   1 oprsafre safre         54400 Mar 09 11:19 i01765426893544083110127.tif
-rw-r--r--   1 oprsafre safre         32820 Mar 09 11:19 i01765426893544154110127.tif
-rw-r--r--   1 oprsafre safre        149376 Mar 09 11:19 i01765426893544175110127.tif
-rwxr-xr-x   1 oprsafre safre        123520 Mar 09 11:19 i01765524986544011110127.tif
-rwxr-xr-x   1 oprsafre safre        269524 Mar 09 11:19 i01765524986544022110127.tif
-rwxr-xr-x   1 oprsafre safre         51212 Mar 09 11:19 i01765524986544083110127.tif
-rwxr-xr-x   1 oprsafre safre        294912 Mar 09 11:19 i01765524986544094110127.tif
-rwxr-xr-x   1 oprsafre safre        285308 Mar 09 11:19 i01765524986544185110127.tif
-rwxr-xr-x   1 oprsafre safre         64378 Mar 09 11:19 i01765543614544011110127.tif
-rwxr-xr-x   1 oprsafre safre         97618 Mar 09 11:19 i01765543614544022110127.tif
-rwxr-xr-x   1 oprsafre safre         18268 Mar 09 11:19 i01765543614544083110127.tif
-rwxr-xr-x   1 oprsafre safre         95798 Mar 09 11:19 i01765543614544094110127.tif

root@mxu40l0n:/gcc4.2.4.2#


i62805304425544011110309.tif


i82805304425544011110309.tif
i62805304425544011110127.tif

"
root@mxu40l5c:/envio# ls i*tif | wc -l
   49311
root@mxu40l5c:/envio# for i in i*tif ;do
> echo $i | awk '{printf " %s %s110127.tif\n",$1,substr($1,1,18)}' | xargs mv
> done
root@mxu40l5c:/envio# ls *110127.tif | wc -l
   49311



01 00 * * * (cd /home/I1003992/nmon; /usr/bin/nmon -x -W)


ivm
    errlog
    mkvt -id {partition}




    if  ; then
        <-IF PART->
    else
        <+ELSE PART+>
    fi


elif  ; then



    while  ; do
    done




/www/cgi-bin/ing/jars/ifxjdbc.jar:/www/cgi-bin/ing/jars/cos.jar:/www/cgi-bin/ing/jars/activation.jar:/www/cgi-bin/ing/jars/imap.jar:/www/cgi-bin/ing/jars/mail.jar:/www/cgi-bin/ing/jars/mailapi.jar:/www/cgi-bin/ing/jars/pop3.jar:/www/cgi-bin/ing/jars/smtp.jar:/www/cgi-bin/ing/jars/oqs_jUtilitiesBean.jar:/www/cgi-bin/ing/jars/itext.jar:/www/cgi-bin/ing/jars/utilerias/calendario/calendario.jar:/www/cgi-bin/ing/jars/reporte.jar:/www/cgi-bin/ing/jars/utilerias.jar:/www/cgi-bin/ing/jars/alearr.jar:/www/cgi-bin/ing/:/www/htdocs/Aplicaciones/IngMexico/:/www/cgi-bin/ing/jars/bcprov-jdk14-122.jar:/www/cgi-bin/ing/jars/Cryptography.jar:/www/htdocs/Aplicaciones/operaciones/Retiros.jar:/www/cgi-bin/ing/jars/ftp.jar:/www/htdocs/Aplicaciones/operaciones/commons-fileupload-1.0.jar:/www/cgi-bin/ing/jars/msbase.jar:/www/cgi-bin/ing/jars/mssqlserver.jar:/www/cgi-bin/ing/jars/msutil.jar:/www/cgi-bin/ing/jars/Oracle.jar:/www/cgi-bin/ing/jars/firmas.jar:/www/cgi-bin/ing/jars/ifx11Prop.jar:/www/cgi-bin/ing/jars/castor_0.9.9.1.jar:/www/cgi-bin/ing/jars/xml.jar:/www/cgi-bin/ing/jars/util.jar
   



while  ; do
done



find files by inode

find / -inum XXXX -xdev  #-xdev prevent search from other fiilesystems...

#Linux

tune2fs -j /dev/mapper/VolGroup01-lvol0

ls | cat #convierte la salida de multicolumna a una sola columna
 

/mondorescue

[root@MXINGVML43001 yum.repos.d]# cat mondorescue.repo
[mondorescue]
name=rhel 5 - mondorescue Vanilla Packages
baseurl=http://mondorescue.linjection.org/ftp/rhel/5
enabled=1
gpgcheck=0

    instalar cdrecord and mkisofs
    http://pkgs.org/download/centos-5-rhel-5/centos-rhel-x86_64/cdrecord-2.01-10.7.el5.x86_64.rpm.html


     mkgroup -'A' users='I1003992' smadmin

find /DocTramites -type f -newer /home/I1003992/domingo.txt | awk '{print $1}' | egrep -v "\....$" | awk '{printf "cp -p %s* /home/I1003992/Doctramites_faltantes/\n", $1}'| sh



audit

 /audit/trail | auditpr -v


/usr/sbin/auditselect -e "event == FILE_Owner" /audit/trail041811 | /usr/sbin/auditpr -hhelpPRtTc -v
/usr/sbin/auditselect -e "time >= 15:00:00" /audit/trail041811 | auditpr  -hhelpPRtTc -v |grep -pN DocTramites 
/usr/sbin/auditselect -e "date == 29/04/11 && time >= 10:03:00 && time <= 10:10:00 && login == S100605A" /audit/trail041811 | auditpr  -hhelpPRtTc -v


FILE_Owner FILE_Mode


lsps
chps -s'30' hd6



ssh-keygen -t rsa




# Opciones usadas con rsync !!!---IMPORTANTE---!!!
# -a, --archive               archive mode; equals -rlptgoD (no -H,-A,-X)
#    -r, --recursive             recurse into directories
#    -l, --links                 copy symlinks as symlinks
#    -p, --perms                 preserve permissions
#    -t, --times                 preserve modification times
#    -g, --group                 preserve group
#    -o, --owner                 preserve owner (super-user only)
#    -D                          same as --devices --specials
#        --devices               preserve device files (super-user only)
#        --specials              preserve special files
# -v, --verbose               increase verbosity
# -H, --hard-links            preserve hard links
# -z, --compress              compress file data during the transfer
#
# "ssh -i /home/S100564A/.ssh/id_rsa"
#   Ocupa la clave privada del usuario de servicio, de otro modo pensaria que es
#   root (por el sudo), eh iria a buscar /.ssh/id_rsa
#
# --rsync-path="sudo rsync"
#  Ejecuta sudo rsync en el cliente

    sudo rsync -avHz -e "ssh -i /home/S100564A/.ssh/id_rsa" --rsync-path="sudo rsync" $ARCHIVO S100564A@$SERVER_DRP:$ARCHIVO



#Show permision files in octal
stat -c "%a %n" stacktrace.log
