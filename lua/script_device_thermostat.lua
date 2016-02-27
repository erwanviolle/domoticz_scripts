local touche = 't_d1' 

commandArray = {}

if(devicechanged[touche]) then

  ----- Variables a editer ------
  local cuisine = 109
  local salle = 114
  local chambreP = 112
  local sdb = 113

  local thermostat = uservariables["chauffage"]
  local voix = uservariables["voix"]
  local tmpCrte = tonumber(otherdevices_svalues[thermostat])
  local newTmp = 0
  local idx = 0
  local volume = otherdevices_svalues['volume']
  if (otherdevices[touche] == 'On') then
    newTmp = tmpCrte + 0.5
  elseif (otherdevices[touche] == 'Off') then
    newTmp = tmpCrte - 0.5
  end

  if(thermostat == 'thermostat_cuisine' or thermostat =='thermostat_salle' ) then
   commandArray[1]={['OpenURL']='http://192.168.0.31:8080/json.htm?type=command&param=setsetpoint&idx='..cuisine..'&setpoint='..newTmp }
   commandArray[2]={['OpenURL']='http://192.168.0.31:8080/json.htm?type=command&param=setsetpoint&idx='..salle..'&setpoint='..newTmp }
   read = "/home/pi/domoticz/scripts/bash/speak.sh "..voix.." ret-de-chaussez...%20"..tostring(newTmp).." "..volume
  elseif(thermostat == 'thermostat_chambre_parents') then
   commandArray['OpenURL']='http://192.168.0.31:8080/json.htm?type=command&param=setsetpoint&idx='..chambreP..'&setpoint='..newTmp 
   read = "/home/pi/domoticz/scripts/bash/speak.sh "..voix.." chambre%20parents...%20"..tostring(newTmp).." "..volume
  elseif(thermostat == 'thermostat_salle_de_bain') then
   commandArray['OpenURL']='http://192.168.0.31:8080/json.htm?type=command&param=setsetpoint&idx='..sdb..'&setpoint='..newTmp 
   read = "/home/pi/domoticz/scripts/bash/speak.sh "..voix.." salle%20de%20bain...%20"..tostring(newTmp).." "..volume

  end
  os.execute(read)
end

return commandArray
