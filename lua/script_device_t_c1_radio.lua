------ Variables a editer ------
local t_c1 = 't_c1_radio_france_info' --Nom du radiateur àllumer/éindre
commandArray = {}

if (devicechanged[t_c1]) then
    if (otherdevices[t_c1]=='On') then
		--print('freebox on 1')
		os.execute ("sh //home/pi/domoticz/scripts/bash/script_tv_radio_france_info.sh")
        --print('freebox on 2')
	elseif (otherdevices[t_c1]=='Off') then
        --print('freebox off 1')
		os.execute ("sh //home/pi/domoticz/scripts/bash/script_freebox_off.sh")
		--print('freebox off 2') 
    end
end
return commandArray

