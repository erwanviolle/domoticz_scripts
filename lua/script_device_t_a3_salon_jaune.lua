
commandArray = {}
if ( devicechanged['t_a3_salon_jaune'] == 'On') then
  local status = uservariables['t_a3_status']
  if ( status == 'jaune' ) then
    commandArray['Scene:Salon jour'] = 'On'
    commandArray['Variable:t_a3_status'] = 'blanc'
  else
    commandArray['Variable:t_a3_status'] = 'jaune'
    commandArray['Scene:Salon_jaune'] = 'On'
  end
  commandArray['Variable:Salon_soir'] = tostring(0)  
elseif(devicechanged['t_a3_salon_jaune'] == 'Off' ) then
  commandArray['Variable:Salon_soir'] = tostring(0)
  commandArray['Scene:hue_salle_salon_off'] = 'On'
end
return commandArray


