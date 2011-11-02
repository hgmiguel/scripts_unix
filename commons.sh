#!/bin/ksh
#===============================================================================
#
#          FILE:  commons.sh
# 
#         USAGE:  . /opt/scripts/commons.sh 
# 
#   DESCRIPTION:  Inicializa variables ocupadas en comun con otros scripts
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Miguel Angel Huerta Gonzalez (MH)
#       COMPANY:  ING
#       VERSION:  1.0
#       CREATED:  09/06/2008 06:28:47 p.m. Hora de verano central (México)
#      REVISION:  ---
#===============================================================================


CORREO_EQUIPO_UNIX=$(cat /opt/scripts/correoEquipoUnix.txt)


restar_un_dia() {
	date '+%m %d %Y' | 
	{ 
		read MONTH DAY YEAR
		DAY=$(("$DAY" - 1))
		case "$DAY" in 
			0) 
	           MONTH=$(("$MONTH" - 1))
    	            case "$MONTH" in 
        	                0) 
            	               MONTH=12 
                	           YEAR=$(("$YEAR" - 1)) 
                    	    ;; 
	                esac 
    	    	DAY=$(cal $MONTH $YEAR | grep . | fmt -1 | tail -1)
		esac
		printf "%4d%02d%02d" $YEAR $MONTH $DAY
	}
}


