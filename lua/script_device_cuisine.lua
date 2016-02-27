------ Variables a editer ------
local hysteresis = 0.5 --Valeur seuil pour éter que le relai ne cesse de commuter dans les 2 sens
local sonde = 'Cuisine' --Nom de la sonde de tempéture
local thermostat = 't_d2_thermostat_rdc' --Nom de l'interrupteur virtuel du thermostat
local autothermostat = 'auto_thermostat_rdc'
local radiateur1 = 'radiateur_cuisine' --Nom du radiateur àllumer/éindre
local consigne = otherdevices_svalues['thermostat_cuisine']
local chf_force = 'chauffage_rdc_forcer'

function chauffage_off()
        tableChauf = {}
        tableChauf[radiateur1]='On'
        return tableChauf
end

function chauffage_on()
        tableChauf = {}
        tableChauf[radiateur1]='Off'
        return tableChauf
end

tableChauffage = {}
commandArray = {}

--La sonde Oregon emet toutes les 40 secondes. Ce sera approximativement la fréence d'exétion de ce script.
if (devicechanged[sonde]) then
    local temperature = devicechanged[string.format('%s_Temperature', sonde)] --Temperature relevé
    print('Consigne : '..consigne.. 'C° , Cuisine: '..temperature..'C°')

    --On n'agit que si le "Thermostat" est actif
    if ( (otherdevices[thermostat]=='On' and otherdevices[autothermostat]=='On') or (otherdevices[chf_force]=='On') ) then
        --print('-- Gestion du thermostat pour la cuisine --')
        if (temperature <= (consigne - hysteresis)) then
            --print('Allumage du chauffage dans la cuisine')
            commandArray = chauffage_on()
        elseif (temperature > (consigne + hysteresis)) then
            --print('Extinction du chauffage cuisine')
            commandArray = chauffage_off()
        end
        --print('fin')
    elseif (otherdevices[thermostat]=='Off' or otherdevices[autothermostat]=='Off') then
          --print('Thermostat cuisine Off')
          commandArray = chauffage_off()
    end
end
return commandArray
