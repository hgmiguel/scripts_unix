#!/bin/bash -
#===============================================================================
#
#          FILE:  uuencodeMultiple.sh
#
#         USAGE:  ./uuencodeMultiple.sh  subject toMail file1 file2 ... filen
#
#   DESCRIPTION: envia multiples archivos
#
#       OPTIONS:  ---
#  REQUIREMENTS:  uuencode
#          BUGS:  ---
#         NOTES:  http://www.unix.com/shell-programming-scripting/17837-sending-multiple-files-through-email.html
#        AUTHOR: Miguel Angel Huerta (MXI1003992),
#       COMPANY:
#       CREATED: 21/12/2010 09:16:14 a.m. Hora estándar central (México)
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error


if [ ! -c /proc/$$/fd/0 ]
then
    MENSAJE=$(cat -)
else
    MENSAJE=""
fi

which uuencode >/dev/null 2>&1 

if [ $? -ne 0 ]; then
    echo "necesitas la aplicacion uuencode"
    exit 1
fi


SUBJECT=$1
shift
CORREO=$1
shift

cat <<EOF | (cat -; for i in $@; do uuencode $i $(basename $i);done ) | mailx -s "$SUBJECT" $CORREO
$MENSAJE
EOF


