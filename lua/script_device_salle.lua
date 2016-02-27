------ Variables a editer ------
local hysteresis = 0.5 --Valeur seuil pour eviter que le relai ne cesse de commuter dans les 2 sens
local sonde = 'Salon' --Nom de la sonde de temperature
local thermostat = 't_d2_thermostat_rdc' --Nom de l'interrupteur virtuel du thermostat
local autothermostat = 'auto_thermostat_rdc'
local radiateur1 = 'radiateur_salle' --Nom du radiateur à allumer/eteindre
local radiateur2 = 'radiateur_salon' --Nom du radiateur à allumer/eteindre
local consigne = otherdevices_svalues['thermostat_salle']
local chf_force = 'chauffage_rdc_forcer'

function chauffage_off()
        tableChauf = {}
        tableChauf[radiateur1]='On'
        tableChauf[radiateur2]='On'
        return tableChauf
end

function chauffage_on()
        tableChauf = {}
        tableChauf[radiateur1]='Off'
        tableChauf[radiateur2]='Off'
        return tableChauf
end

tableChauffage = {}
commandArray = {}
--La sonde Oregon 'Salon' emet toutes les 40 secondes. Ce sera approximativement la frequence d'execution de ce script.
if (devicechanged[sonde]) then
    local temperature = devicechanged[string.format('%s_Temperature', sonde)] --Temperature relevee dans le salon
    print('Consigne : '..consigne.. 'C° , Salle : '..temperature..'C°')

    --On n'agit que si le "Thermostat" est actif
    if ((otherdevices[thermostat]=='On' and otherdevices[autothermostat]=='On') or (otherdevices[chf_force]=='On') ) then
        --print('-- Gestion du thermostat pour le salon --')
        if (temperature <= (consigne - hysteresis)) then
            --print('Allumage des chauffages dans salle, salon')
            commandArray = chauffage_on()
        elseif (temperature > (consigne + hysteresis)) then
            --print('Extinction des chauffages salle')
            commandArray = chauffage_off()
        end
        --print('fin')
    elseif (otherdevices[thermostat]=='Off' or otherdevices[autothermostat]=='Off') then
          --print('Thermostat Off')
          commandArray = chauffage_off()
    end
end
return commandArray


