#!/usr/bin/php

<?php


$tabHue = array('buffet' => 6 , 'salle' => 7 , 'cuisine' => 3 , 'salon' => 2 , 'colorsalon' => 1 ); 

$light['buffet'] = curl_init(getStateUrl($tabHue['buffet']));
$light['salle'] = curl_init(getStateUrl($tabHue['salle']));
//$light['cuisine'] = curl_init(getStateUrl($tabHue['cuisine']));
$light['salon'] = curl_init(getStateUrl($tabHue['salon']));
$light['colorsalon'] = curl_init(getStateUrl($tabHue['colorsalon']));

$tabColor = array(
  'off' => array("on"=>false),
  'blanc_100' => array("hue" =>15808,"sat" => 0, "bri" => 255, "on"=>true),
  'rouge_100' => array("hue" =>0,"sat" => 255, "bri" => 255, "on"=>true), 
  'bleu_100' => array("hue" => 46455,"sat" => 255, "bri" => 255, "on"=>true),
  'blanc_bleu_100' =>  array("hue" => 46455,"sat" => 128, "bri" => 255, "on"=>true)	
);
$c = null;

executeHue($light['buffet'],$tabColor['off']);
executeHue($light['salle'],$tabColor['off']);
executeHue($light['salon'],$tabColor['off']);
executeHue($light['colorsalon'],$tabColor['off']);


//while (true){
do{
  $target = array_rand($light,1);
  //echo $target. ' : ';
  eclair($light[$target],$tabColor);

  $sleep = getSleep();
  //echo $sleep.'/ ';
  usleep($sleep);

//  $c = getContinue();
  //echo $c;
} while ($c != 'Off');


function getStateUrl($idHue){
  // Setup URL to Hue SmartBridge
  $bridgeIP = "192.168.0.42";
  $apiKey = "112c8e7c540880f130aa4544013787";

  return  "http://".$bridgeIP."/api/".$apiKey."/lights/".$idHue."/state";
}

function executeHue($curlHue,$data){
 curl_setopt($curlHue, CURLOPT_RETURNTRANSFER, true);
 curl_setopt($curlHue, CURLOPT_POSTFIELDS,json_encode($data));
 curl_setopt($curlHue, CURLOPT_CUSTOMREQUEST, "PUT");
 curl_exec($curlHue);
}

function eclair($hue,$tabColor){
  executeHue($hue,$tabColor['blanc_100']);
  executeHue($hue,$tabColor['bleu_100']);
  usleep(400000);
  executeHue($hue,$tabColor['blanc_100']);
  usleep(100000);
  executeHue($hue,$tabColor['off']);
}

function getSleep(){
  $tabSleep = array (
    0 => 500000,
    1 => 700000,
    2 => 900000,
    3 => 1100000,
    4 => 1300000,
    5 => 1500000,
    6 => 1700000,
    7 => 1900000,
    8 => 2000000
  );
 
  return $tabSleep[mt_rand(0,8)];
}

function getContinue(){

  $url = "http://192.168.0.31:8080/json.htm?type=devices&rid=69";
  // Send HTTP GET request
  $ch1 = curl_init($url);
  curl_setopt ($ch1, CURLOPT_RETURNTRANSFER, true);
  curl_setopt ($ch1, CURLOPT_FRESH_CONNECT, true);
  curl_setopt($ch1, CURLOPT_CUSTOMREQUEST, "GET");
  $state = curl_exec ($ch1);

  // Parse JSON response
  $json = json_decode($state);
  $status = $json->result[0]->Status;

  return $status;
}


?>

