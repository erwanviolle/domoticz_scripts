-- Meteo France vigilance from domogeek API 
-- domoticz/scripts/lua/script_time_vigilance.lua 
-- Information from Meteo France is updated everyday at 6AM and 4PM 
-- This script will check at 6.10AM and 4.10PM function 

function os.capture(cmd, raw)
 local f = assert(io.popen(cmd, 'r'))
 local s = assert(f:read('*a'))
 f:close()
 if raw then return s end
 s = string.gsub(s, '^%s+', '')
 s = string.gsub(s, '%s+$', '')
 s = string.gsub(s, '[\n\r]+', ' ')
 return s
end
commandArray = {}
time = os.date("*t") 
-- Trigger at 6:10 and 16:10 
if (time.min == 5 and ((time.hour == 7) or (time.hour == 16))) then
  -- Device ID (Type Alert on virtual hardware)
  local idx = '98'
  -- Department (France)
  local dept = '62'
  local cmd = "curl http://domogeek.entropialux.com/vigilance/" .. dept

  local color = os.capture(cmd .. '/color', true);
  local risk = os.capture(cmd .. '/risk', true);

  local sms = 'Vigilance: ' .. cmd .. ': ' .. color .. ' / ' .. risk

  local sValue = risk
  local nValue = 0
  if color == "vert" then 
    nValue = 1
  elseif color == "jaune" then 
    nValue = 2
    if risk ~= "RAS" then
      commandArray['SendNotification'] = sms   
    end
  elseif color == "orange" then 
    nValue = 3
    commandArray['SendNotification'] = sms 
  elseif color == "rouge" then 
    nValue = 4
    commandArray['SendNotification'] = sms 
  else 
    nValue = 0
    commandArray['SendNotification'] = sms 
  end
 
  -- Update device idx with nValue and sValue
  commandArray['UpdateDevice'] = idx .. '|' .. nValue .. '|' .. tostring(sValue)
end

return commandArray
