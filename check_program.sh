#!/bin/bash - 
#===============================================================================
#
#          FILE:  check_was_servers.sh
# 
#         USAGE:  ./check_was_servers.sh "(server1|server2|serverx)"
# 
#   DESCRIPTION: monitorea procesos 
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Miguel Angel Huerta Gonzalez (MXI01003992A)
#       COMPANY: 
#       CREATED: 27/12/2010 09:48:18 a.m. Hora estándar central (México)
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

name=$1
n=$(ps -ef | egrep -i "[^(egrep)]((java).*($1))"|wc -l)
proc_cnt=$(($n + 0))
echo String='"'$name'"' Int32=$proc_cnt
exit 0

