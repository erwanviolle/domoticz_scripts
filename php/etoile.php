#!/usr/bin/php

<?php


$tabHue = array('buffet' => 6 , 'salle' => 7 , 'cuisine' => 3 , 'salon' => 2 , 'colorsalon' => 1 ); 

$light[0] = curl_init(getStateUrl($tabHue['buffet']));
$light[1] = curl_init(getStateUrl($tabHue['salle']));
$light[2] = curl_init(getStateUrl($tabHue['colorsalon']));
$light[3] = curl_init(getStateUrl($tabHue['salon']));


$tabColor = array(
  'off' => array("on"=>false),
  'blanc_100' => array("hue" =>15808,"sat" => 0, "bri" => 255, "on"=>true),
  'rouge_100' => array("hue" =>0,"sat" => 255, "bri" => 255, "on"=>true), 
  'bleu_100' => array("hue" => 46455,"sat" => 255, "bri" => 255, "on"=>true),
  'blanc_bleu_100' =>  array("hue" => 46455,"sat" => 128, "bri" => 255, "on"=>true),	
  'jaune_100' =>  array("hue" => 9763,"sat" => 255, "bri" => 255, "on"=>true),
);



while (true){
  $etat[0] = etatHue(curl_init(getUrl($tabHue['buffet'])));
  $etat[1] = etatHue(curl_init(getUrl($tabHue['salle'])));
  $etat[2] = etatHue(curl_init(getUrl($tabHue['colorsalon'])));
  $etat[3] = etatHue(curl_init(getUrl($tabHue['salon'])));

  $alea = mt_rand(0,3);
  if($alea == 0){
    comete($light,$tabColor,$etat);
  }
  else{
    etoileFilante($light,$tabColor,$etat);
  }
  sleep(getSleep());
}

function getUrl($idHue){
  // Setup URL to Hue SmartBridge
  $bridgeIP = "192.168.0.42";
  $apiKey = "112c8e7c540880f130aa4544013787";

  return  "http://".$bridgeIP."/api/".$apiKey."/lights/".$idHue;
}

function getStateUrl($idHue){
  // Setup URL to Hue SmartBridge
  $bridgeIP = "192.168.0.42";
  $apiKey = "112c8e7c540880f130aa4544013787";

  return  "http://".$bridgeIP."/api/".$apiKey."/lights/".$idHue."/state";
}

function etatHue($curlHue){
  curl_setopt ($curlHue, CURLOPT_RETURNTRANSFER, true);
  curl_setopt ($curlHue, CURLOPT_FRESH_CONNECT, true);
  curl_setopt ($curlHue, CURLOPT_CUSTOMREQUEST, "GET");
  $lightState = curl_exec ($curlHue);

  // Parse JSON response
  $json = json_decode($lightState);
  $hue = $json->state->hue;
  $sat = $json->state->sat;
  $bri = $json->state->bri;
  $on = $json->state->on;
  if($on == 1){
    $on = true;
  }
  else{
    $on = false;
  }
  return array("hue" => $hue,"sat" => $sat, "bri" => $bri, "on"=>$on);
}


function executeHue($curlHue,$data){
  curl_setopt($curlHue, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($curlHue, CURLOPT_POSTFIELDS,json_encode($data));
  curl_setopt($curlHue, CURLOPT_CUSTOMREQUEST, "PUT");
  curl_exec($curlHue);
}

function etoileFilante($light,$tabColor,$etat){
  $choice = mt_rand(0,1);
  if($choice == 1){
   $light = array_reverse($light);
   $etat = array_reverse($etat);
  }

  for($i=0;$i<=3;$i++){
    executeHue($light[$i],$tabColor['blanc_100']);
    if($i==3){
      sleep(1);
    }
    else{
      usleep(200000);
    }    
    executeHue($light[$i],$etat[$i]);
  }
}

function comete($light,$tabColor,$etat){
  $choice = mt_rand(0,1);
  if($choice == 1){
   $light = array_reverse($light);
   $etat = array_reverse($etat);
  }

  for($i=0;$i<=3;$i++){
    executeHue($light[$i],$tabColor['blanc_100']);
    if($i > 0){
      executeHue($light[$i-1],$tabColor['jaune_100']);
    }
    usleep(100000);
  }
  usleep(800000);
  executeHue($light[3],$tabColor['jaune_100']);
  usleep(500000);
  //fin
  for($i=0;$i<=3;$i++){
    executeHue($light[$i],$etat[$i]);
    usleep(500000);
  }
}

function getSleep(){
  $tabSleep = array (
    0 => 120,
    1 => 180,
    2 => 240,
    3 => 60,
  );
 
  return $tabSleep[mt_rand(0,3)];
}



?>

