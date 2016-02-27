commandArray = {}
local delta = 75 --en minute
time = os.date("*t")
minutes = time.min + time.hour * 60

function interupteur_off()
        table = {}
        table['crepuscule_hue_rdc']='Off'
        return table
end

if (otherdevices['presence']=='On') and( otherdevices['crepuscule_hue_rdc']=='On' ) and ( minutes >= (timeofday['SunsetInMinutes'] - delta ) ) then
  
    os.execute("curl 'http://192.168.0.31:8080/json.htm?type=command&param=setcolbrightnessvalue&idx=32&hue=60&brightness=100&iswhite=false' ") -- buffet
    os.execute("curl 'http://192.168.0.31:8080/json.htm?type=command&param=setcolbrightnessvalue&idx=18&hue=60&brightness=100&iswhite=false' ") -- color
    os.execute("curl 'http://192.168.0.31:8080/json.htm?type=command&param=setcolbrightnessvalue&idx=19&hue=60&brightness=100&iswhite=false' ") -- salon
    os.execute("curl 'http://192.168.0.31:8080/json.htm?type=command&param=setcolbrightnessvalue&idx=58&hue=60&brightness=100&iswhite=false' ") -- salle    
    commandArray = interupteur_off()
end

return commandArray
