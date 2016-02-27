commandArray={}

time = os.date("*t")


--import des fontions pour lire le JSON
json = (loadfile "/home/pi/domoticz/scripts/lua/JSON.lua")()
--variables � modifier----------------
--idx du capteur
idx = '107'
--coordonn�es de d�part
arrivey=uservariables['maison_y']
arrivex=uservariables['maison_x']
--coordonn�es de d�part
position = uservariables['position_erwan']
departy, departx = position:match("([^,]+),([^,]+)")

-----------------------------------------
----------------------------------------------------------------
--R�cup�ration du trajet et de sa dur�e en temps r�el via WAZE--
----------------------------------------------------------------
local waze=assert(io.popen('curl "https://www.waze.com/row-RoutingManager/routingRequest?from=x%3A'..departx..'+y%3A'..departy..'&to=x%3A'..arrivex..'+y%3A'..arrivey..'&returnJSON=true&timeout=6000&nPaths=1&options=AVOID_TRAILS%3At%2CALLOW_UTURNS"'))

local trajet = waze:read('*all')
waze:close()

local jsonTrajet = json:decode(trajet)
--Noms des principales routes emprunt�es
routeName = jsonTrajet['response']['routeName']
--Liste des routes emprunt�es
route = jsonTrajet['response']['results']
--Temps de trajet en secondes
routeTotalTimeSec = 0
--calcul du temps de trajet
for response,results in pairs(route) do
   routeTotalTimeSec = routeTotalTimeSec + results['crossTime']
end

--Temps de trajet en minutes
routeTotalTimeMin = routeTotalTimeSec/60-((routeTotalTimeSec%60)/60)

--mise en forme de la r�ponse
if (routeTotalTimeSec%60<10)then
   routeTotalTime =  routeTotalTimeMin ..':0'..routeTotalTimeSec%60
else
   routeTotalTime =  routeTotalTimeMin ..':'..routeTotalTimeSec%60
end

commandArray[1]={['UpdateDevice'] =idx..'|0|' .. tostring(routeTotalTime).." par "..routeName}
return commandArray
