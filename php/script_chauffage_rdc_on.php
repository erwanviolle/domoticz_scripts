#!/usr/bin/php

<?php
//shell_exec('/home/pi/domoticz/scripts/bash/speak.sh Michel chauffage%20ret-de-chaussez...%20allumez');

//sleep(2);
// Setup URL to Hue SmartBridge
$bridgeIP = "192.168.0.42";
$apiKey = "112c8e7c540880f130aa4544013787";
$lightNum = "1";
$url = "http://".$bridgeIP."/api/".$apiKey."/lights/".$lightNum;
$urlState = $url."/state";

// Send HTTP GET request
$ch1 = curl_init($url);
curl_setopt ($ch1, CURLOPT_RETURNTRANSFER, true);
curl_setopt ($ch1, CURLOPT_FRESH_CONNECT, true);
curl_setopt($ch1, CURLOPT_CUSTOMREQUEST, "GET");
$lightState = curl_exec ($ch1);

// Parse JSON response
$json = json_decode($lightState);
$hue = $json->state->hue;
$sat = $json->state->sat;
$bri = $json->state->bri;
$on = $json->state->on;

echo $hue . ' ; '.$sat. ' ; '.$bri. ' ; ' .$on; 

if($on == 1){
   $on = true;
}
else{
   $on = false;
}

//$ch3 = curl_init("http://192.168.0.31:8080/json.htm?type=command&param=updateuservariable&idx=15&vname=chauffage&vtype=2&vvalue=thermostat_salle");
//curl_exec($ch3);

$dataEtat = json_encode(array("hue" =>$hue,"sat" => $sat,"bri" =>$bri, "on"=>$on));
$dataOn = json_encode(array("hue" =>25967,"sat" => 255, "bri" => 255, "on"=>true));
$dataOff = json_encode(array("on"=>false));

$ch2 = curl_init($urlState);
curl_setopt($ch2, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch2, CURLOPT_POSTFIELDS, $dataOn);
curl_setopt($ch2, CURLOPT_CUSTOMREQUEST, "PUT");
curl_exec($ch2);
usleep(400000);
curl_setopt($ch2, CURLOPT_POSTFIELDS, $dataOff);
curl_setopt($ch2, CURLOPT_CUSTOMREQUEST, "PUT");
curl_exec($ch2);
usleep(400000);
curl_setopt($ch2, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch2, CURLOPT_POSTFIELDS, $dataOn);
curl_setopt($ch2, CURLOPT_CUSTOMREQUEST, "PUT");
curl_exec($ch2);
usleep(400000);
curl_setopt($ch2, CURLOPT_POSTFIELDS, $dataOff);
curl_setopt($ch2, CURLOPT_CUSTOMREQUEST, "PUT");
curl_exec($ch2);
usleep(400000);
curl_setopt($ch2, CURLOPT_POSTFIELDS, $dataEtat);
curl_setopt($ch2, CURLOPT_CUSTOMREQUEST, "PUT");
curl_exec($ch2);


?>

