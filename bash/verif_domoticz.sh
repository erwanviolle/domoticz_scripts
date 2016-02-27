#!/bin/bash
# Script qui v�rifie l'�tat de domoticz et qui relance si off

now=$(date) #r�cup�ration de la date et heure pour les logs

#R�cup�ration du retour de la commande de status
domoticz=$(sudo service domoticz.sh status)

if [ "$domoticz" == "domoticz is not running ... failed!" ] # Si le service n'est pas lanc�
then
 relance=$(sudo service domoticz.sh start) #On le lance
 echo "$now &gt;&gt; relance : $relance" #On log la lancement
else
 echo "$now &gt;&gt; Domoticz lanc�" #On log l'�tat normal
fi
exit 0
