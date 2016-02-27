local sonde = 'Chambre_parents' --Nom de la sonde de tempéture
local hysteresis = 0.5 --Valeur seuil pour éter que le relai ne cesse de commuter dans les 2 sens
local thermostat = 't_d4_thermostat_chambre_parents' --Nom de l'interrupteur virtuel du thermostat
local autothermostat =  'auto_thermostat_chambre_parents'
local radiateur1 = 'radiateur_chambre_parents' --Nom du radiateur àllumer/éindre
local consigne = otherdevices_svalues['thermostat_chambre_parents']
local chf_force = 'chauffage_chbr_parents_forcer'

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

--La sonde Oregon emet toutes les 40 secondes. Ce sera approximativement la frécence d'exétion de ce script.
if (devicechanged[sonde]) then
    
    local temperature = devicechanged[string.format('%s_Temperature', sonde)] -- Temperature relevé
    print('Consigne : '..consigne.. 'C° , chambre parents '..temperature..'C°')

    --On n'agit que si le "Thermostat" est actif
    if ( (otherdevices[thermostat]=='On' and otherdevices[autothermostat] =='On') or (otherdevices[chf_force]=='On') ) then
        --print('-- Gestion du thermostat--')
        if (temperature <= (consigne - hysteresis)) then
            --print('Allumage du chauffage dans la chambre parents')
            commandArray = chauffage_on()
        elseif (temperature > (consigne + hysteresis)) then
            --print('Extinction du chauffage dans la chambre parents')
            commandArray = chauffage_off()
        end
        --print('fin')
    elseif (otherdevices[thermostat]=='Off' or otherdevices[autothermostat]=='Off' ) then
          --print('Thermostat chambre parents Off')
          commandArray = chauffage_off()
    end
end
return commandArray

