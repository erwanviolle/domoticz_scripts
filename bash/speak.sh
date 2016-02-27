#!/bin/bash

phrase=$2
voice=$1
fichier="${phrase//%20/_}"
fichier="/home/pi/domoticz/scripts/voice/${voice}_${fichier}.mp3"
echo $fichier
if [ -f $fichier ]
then
    echo "Le fichier de configuration existe !"
else
    echo "Le fichier de pas configuration existe pas!"
    curl -L http://www.voxygen.fr/sites/all/modules/voxygen_voices/assets/proxy/index.php?method=redirect\&voice=$1\&text=$2 > $fichier 2>&1
fi
#mpg321 -a bluetooth -g 10 /media/Angry-Erwan/test.mp3
#mpg321 -a bluetooth -g 50 $fichier
mpg321 -g 700 $fichier
#mplayer $fichier

