------ Variables a editer ------
local t_b3 = 't_b3_etoile' --Nom du radiateur àllumer/éindre
commandArray = {}

if (devicechanged[t_b3]) then
    if (otherdevices[t_b3]=='On') then
		os.execute ("/etc/init.d/etoile_service start")
	elseif (otherdevices[t_b3]=='Off') then
		os.execute ("/etc/init.d/etoile_service stop")
    end
end
return commandArray

