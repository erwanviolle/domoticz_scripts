
commandArray = {}
if ( devicechanged['t_a4_cuisine'] == 'On') then
  commandArray['Scene:Cuisine'] = 'On'
elseif ( devicechanged['t_a4_cuisine'] == 'Off') then
 commandArray['Scene:Cuisine'] = 'Off'
end

return commandArray


