
commandArray = {}
if ( devicechanged['t_a2_salon_cinema'] == 'On') then

 local soir = uservariables['Salon_soir']
 if ( soir == 0 ) then -- tout allumer 
  commandArray['Scene:salon_soir_1'] = 'On'
  commandArray['Variable:Salon_soir'] = tostring(1)
 elseif ( soir == 1 ) then
  commandArray['Scene:salon_soir_2'] = 'On'
  commandArray['Variable:Salon_soir'] = tostring(2)
 elseif ( soir == 2 ) then
  commandArray['Scene:salon_soir_3'] = 'On'
  commandArray['Variable:Salon_soir'] = tostring(3)
 elseif ( soir == 3 ) then -- tout eteindre
  commandArray['Scene:salon_soir_4'] = 'On'
  commandArray['Variable:Salon_soir'] = tostring(4)
 elseif ( soir == 4 ) then -- tout eteindre
  commandArray['Scene:salon_soir_5'] = 'On'
  commandArray['Variable:Salon_soir'] = tostring(0)
 end

elseif ( devicechanged['t_a2_salon_cinema'] == 'Off') then
 commandArray['Scene:hue_salle_salon_off'] = 'On'
 commandArray['Variable:Salon_soir'] = tostring(0)
end

return commandArray


