commandArray = {}

function timedifference (s)
 year = string.sub(s, 1, 4)
 month = string.sub(s, 6, 7)
 day = string.sub(s, 9, 10)
 hour = string.sub(s, 12, 13)
 minutes = string.sub(s, 15, 16)
 seconds = string.sub(s, 18, 19)
 t1 = os.time()
 t2 = os.time{year=year, month=month, day=day, hour=hour, min=minutes, sec=seconds}
 difference = os.difftime (t1, t2)
 
 return difference
end

if (otherdevices['presence']=='Off' or (otherdevices['presence']=='On' and timedifference(otherdevices_lastupdate['presence']) > 600)) then
 ping_success_tel1=os.execute('ping -c1 192.168.0.50')
 ping_success_tel2=os.execute('ping -c1 192.168.0.36')
 ping_success_homecine=os.execute('ping -c1 192.168.0.39')

 if ping_success_tel1 or ping_success_tel2 or ping_success_homecine then
  commandArray['presence']='On'
 else
  if otherdevices['presence']=='On' then
   commandArray['presence']='Off'
  end
 end
end
return commandArray
