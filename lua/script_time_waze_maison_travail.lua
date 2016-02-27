---------------------------------
-- Script de calcul de temps pour un trajet entre 2 coordonnées
-- Auteur : Neutrino
-- Date : 7 septembre 2015
-- Nécessite un capteur virtuel de type Text
-- source :
-- http://www.domo-blog.fr/info-trajet-waze-eedomus-version-raspberry/
---------------------------------


commandArray={}


time = os.date("*t")
if ( (time.hour == 6) or (time.hour == 7) or (time.hour == 8) or (time.hour == 9) ) then


--import des fontions pour lire le JSON
json = (loadfile "/home/pi/domoticz/scripts/lua/JSON.lua")()
--variables à modifier----------------
--idx du capteur
idx = '99'
--coordonnées de départ
departy= uservariables['maison_y']
departx= uservariables['maison_x']

--coordonnées d'arrivée
arrivey= uservariables['travail_y']
arrivex= uservariables['travail_x']

-----------------------------------------
----------------------------------------------------------------
--Récupération du trajet et de sa durée en temps réel via WAZE--
----------------------------------------------------------------
local waze=assert(io.popen('curl "https://www.waze.com/row-RoutingManager/routingRequest?from=x%3A'..departx..'+y%3A'..departy..'&to=x%3A'..arrivex..'+y%3A'..arrivey..'&returnJSON=true&timeout=6000&nPaths=1&options=AVOID_TRAILS%3At%2CALLOW_UTURNS"'))
local trajet = waze:read('*all')
waze:close()

local jsonTrajet = json:decode(trajet)
--Noms des principales routes empruntées
routeName = jsonTrajet['response']['routeName']
--Liste des routes empruntées
route = jsonTrajet['response']['results']
--Temps de trajet en secondes
routeTotalTimeSec = 0
--calcul du temps de trajet
for response,results in pairs(route) do
   routeTotalTimeSec = routeTotalTimeSec + results['crossTime']
end

--Temps de trajet en minutes
routeTotalTimeMin = routeTotalTimeSec/60-((routeTotalTimeSec%60)/60)

--mise en forme de la réponse
if (routeTotalTimeSec%60<10)then
   routeTotalTime =  routeTotalTimeMin ..':0'..routeTotalTimeSec%60
else
   routeTotalTime =  routeTotalTimeMin ..':'..routeTotalTimeSec%60
end

commandArray[1]={['UpdateDevice'] =idx..'|0|' .. tostring(routeTotalTime).." par "..routeName}

end

return commandArray
