----- Variables a editer ------
commandArray = {}

if(devicechanged['Voix']) then
  voix = uservariables['voix']
  text = '"'..uservariables['text']..'"'
  text = text:gsub("%_", "%%20")
  print(text)

  read = "/home/pi/domoticz/scripts/bash/speak.sh " ..voix.." "..text
  os.execute(read)
end

return commandArray

