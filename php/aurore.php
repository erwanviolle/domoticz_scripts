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
  'vert_100' => array("hue" => 21714,"sat" => 255, "bri" => 255, "on"=>true),
  'vert-lime_100' => array("hue" => 25783,"sat" => 255, "bri" => 255, "on"=>true),
);



while (true){
  $etat[0] = etatHue(curl_init(getUrl($tabHue['buffet'])));
  $etat[1] = etatHue(curl_init(getUrl($tabHue['salle'])));
  $etat[2] = etatHue(curl_init(getUrl($tabHue['colorsalon'])));
  $etat[3] = etatHue(curl_init(getUrl($tabHue['salon'])));
  
  aurore($light,$tabColor,$etat);
  
  sleep(getSleep());
}



function aurore($light,$tabColor,$etat){

  $debut = mt_rand(0,1);
  if($debut == 0){ //debut gauche
    $newTab = $light;
  }
  else if ($debut == 1){ //debut droite
    $newTab = array_reverse($light); 
  }
  else{//milieu
    $newTab = array( 0 => $light[2] , 1 => $light[3] , 2 => $light[1] , 3 => $light[0] );
  }

  //arrivé de l'onde
  for ($i=0;$i<=2;$i++){
    executeHue($newTab[$i], array("hue" => mt_rand(21714,25783),"sat" => 255, "bri" => mt_rand(75,150), "on"=>true));
    if(($debut != 2) || ($debut == 2 && $i == 0) ){
      sleep(1);
    }
  }

  // sleep(3);
  //deroulement

  //changement
//  $fin = deplacement($newTab,$tabColor, mt_rand(3,20), 3);
  //echo $fin;
  $fin = 1;
  //scintillement  
  $v = 0;  
  while ($v < 20 ) {
   for ($t = $fin; $t>$fin-3;$t--){
  // echo $t . '/';
    $o = $t < 0 ? $t + 4  : $t;
    echo $o . ' :';
    executeHue($newTab[$o],array("hue" => mt_rand(21714,25783),"sat" => 255, "bri" => mt_rand(75,150), "on"=>true));
    usleep(500000);
   }
   $v++;
  }



sleep(5);
echo 'cest la fin';
  //fin
  for ($i=0;$i<=3;$i++){
    executeHue($newTab[$i],$tabColor['off']);
    if(($debut != 2) || ($debut == 2 && $i == 0) ){
      sleep(1);
    }
  }
}


function deplacement($tab,$tabColor, $nbCase,$j){
  
  $i = 0;
$x = 3;
//print_r($tab);
//echo '*************************';
  while ($i != $nbCase){

    if($j > 0 && $j % 4 == 0 ){
      $j = 0; 
    }
    $off = $j - $x < 0 ?  ($j-$x) + 4  : $j - $x;

    echo $off. ' /';
    executeHue($tab[$off],$tabColor['off']);
    executeHue($tab[$j], array("hue" => mt_rand(21714,25783),"sat" => 255, "bri" => mt_rand(75,150), "on"=>true)); 
   
    sleep(mt_rand(1,5));
    $j++;
    $i++;
  }
  return $j-1;
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

