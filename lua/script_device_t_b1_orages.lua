------ Variables a editer ------
local t_b1 = 't_b1_orages' --Nom du radiateur àllumer/éindre
commandArray = {}

if (devicechanged[t_b1]) then
    if (otherdevices[t_b1]=='On') then
		os.execute ("/etc/init.d/orage_service start")
	elseif (otherdevices[t_b1]=='Off') then
		os.execute ("/etc/init.d/orage_service stop")
    end
end
return commandArray

