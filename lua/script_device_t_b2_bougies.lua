------ Variables a editer ------
local t_b2 = 't_b2_bougies' --Nom du radiateur àllumer/éindre
commandArray = {}

if (devicechanged[t_b2]) then
    if (otherdevices[t_b2]=='On') then
		os.execute ("/etc/init.d/bougies_service start")
	elseif (otherdevices[t_b2]=='Off') then
		os.execute ("/etc/init.d/bougies_service stop")
    end
end
return commandArray

