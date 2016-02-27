--rdc
local btn_rdc = 't_d2_thermostat_rdc' 
local chf_rdc = 'chauffage_rdc_forcer'
local etat_rdc = 'Variable:etatrdc'
--sdb
local btn_sdb = 't_d3_thermostat_salle_de_bain' 
local chf_sdb = 'chauffage_salle_de_bain_forcer'
local etat_sdb = 'Variable:etatsdb'
--chambre parent
local btn_cp = 't_d4_thermostat_chambre_parents' 
local chf_cp = 'chauffage_chbr_parents_forcer'
local etat_cp = 'Variable:etatcp'
--variables
local var_thmt = 'Variable:chauffage'
local voix = uservariables["voix"]

commandArray = {}

if (devicechanged[btn_rdc] == 'On') then
  local volume = otherdevices_svalues['volume']
  --clignotement vert
  os.execute("/home/pi/domoticz/scripts/php/script_chauffage_rdc_on.php")

  commandArray[0]={[var_thmt] = 'thermostat_salle'}
  if ( otherdevices[chf_rdc] == 'Off' and uservariables['etatrdc'] == 'On' ) then
    read = "/home/pi/domoticz/scripts/bash/speak.sh "..voix.." chauffages%20du%20ret-de-chausser...%20ALLUMER. "..volume
    os.execute(read)
    commandArray[1]={[chf_rdc]='On'}
  else
    read = "/home/pi/domoticz/scripts/bash/speak.sh "..voix.." prise%20en%20compte%20du%20planing%20du%20ret-de-chausser. "..volume
    os.execute(read)
    commandArray[1]={[chf_rdc]='Off'}
  end
  commandArray[2]={[etat_rdc] = 'On'}


elseif (devicechanged[btn_rdc]=='Off') then
  local volume = otherdevices_svalues['volume']
  read = "/home/pi/domoticz/scripts/bash/speak.sh "..voix.." chauffages.%20ret-de-chausser...%20ETTEINT. "..volume
  os.execute(read)

  commandArray[0] = {[var_thmt] = 'thermostat_salle'}
  --on met le chauffage forcer a (eteint)
  commandArray[1]={[etat_rdc] = 'Off'}
  commandArray[2]={[chf_rdc]='Off'}

  --clignotement rouge
  os.execute("/home/pi/domoticz/scripts/php/script_chauffage_rdc_off.php")


elseif (devicechanged[btn_sdb] == 'On') then
  local volume = otherdevices_svalues['volume']
  --clignotement vert
  os.execute("/home/pi/domoticz/scripts/php/script_chauffage_salle_de_bain_on.php")

  commandArray[0]={[var_thmt] = 'thermostat_salle_de_bain'}
  if ( otherdevices[chf_sdb] == 'Off' and uservariables['etatsdb'] == 'On' ) then
    read = "/home/pi/domoticz/scripts/bash/speak.sh "..voix.." chauffage.%20salle-de-bain...%20ALLUMER. "..volume
    os.execute(read)

    commandArray[1]={[chf_sdb]='On'}
  else
    read = "/home/pi/domoticz/scripts/bash/speak.sh "..voix.." prise%20en%20compte%20du%20planing%20de%20la%20salle-de-bain. "..volume
    os.execute(read)
    
    commandArray[1]={[chf_sdb]='Off'}
  end
    commandArray[2]={[etat_sdb] = 'On'}


elseif (devicechanged[btn_sdb]=='Off') then
  local volume = otherdevices_svalues['volume']
  read = "/home/pi/domoticz/scripts/bash/speak.sh "..voix.." chauffage.%20salle-de-bain...%20ETTEINT. "..volume
  os.execute(read)

  commandArray[0]={[var_thmt] = 'thermostat_salle_de_bain'}
  --on met le chauffage forcer a (eteint)
  commandArray[1]={[chf_sdb]='Off'}
  commandArray[2]={[etat_sdb] = 'Off'}

  --clignotement rouge
  os.execute("/home/pi/domoticz/scripts/php/script_chauffage_salle_de_bain_off.php")


elseif (devicechanged[btn_cp] == 'On') then
  local volume = otherdevices_svalues['volume']
  --clignotement vert
  os.execute("/home/pi/domoticz/scripts/php/script_chauffage_chambre_parents_on.php")

  commandArray[0]={[var_thmt] = 'thermostat_chambre_parents'}
  if ( otherdevices[chf_cp] == 'Off' and uservariables['etatcp'] == 'On' ) then
    read = "/home/pi/domoticz/scripts/bash/speak.sh "..voix.." chauffage.%20chambre%20parents...%20ALLUMER. "..volume
    os.execute(read)

    commandArray[1]={[chf_cp]='On'}
  else
    read = "/home/pi/domoticz/scripts/bash/speak.sh "..voix.." prise%20en%20compte%20du%20planing%20de%20la%20chambre%20des%20parents. "..volume
    os.execute(read)

    commandArray[1]={[chf_cp]='Off'}
  end
  commandArray[2]={[etat_cp] = 'On'}

elseif (devicechanged[btn_cp]=='Off') then
  local volume = otherdevices_svalues['volume']
  read = "/home/pi/domoticz/scripts/bash/speak.sh "..voix.." chauffage.%20chambre%20parents...%20ETTEINT. "..volume
  os.execute(read)

  commandArray[0]={[var_thmt] = 'thermostat_chambre_parents'}
  --on met le chauffage forcer a (eteint)
  commandArray[1]={[chf_cp]='Off'}
  commandArray[2]={[etat_cp] = 'Off'}

  --clignotement rouge
  os.execute("/home/pi/domoticz/scripts/php/script_chauffage_chambre_parents_off.php")
end


return commandArray


