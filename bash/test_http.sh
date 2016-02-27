#!/bin/bash
################################################################
#
# This script will test the domoticz http web access
#
################################################################
# test connexion with max 5s
curl -s http://192.168.0.31:8080 -m 5 > /dev/null
CR=$?
if [ $CR != 0 ]
then
        echo "`date` Probleme RC=$CR"
        echo "Restarting Domoticz"
        /etc/init.d/domoticz.sh restart
else
        echo "`date`  RAS code retour $CR "
fi
