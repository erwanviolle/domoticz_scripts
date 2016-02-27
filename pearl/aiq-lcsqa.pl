#!/usr/bin/perl
use v5.14;
use LWP::Simple;                # From CPAN
use XML::Simple;                # From CPAN
use strict;                     # Good practice
use warnings;                   # Good practice
use utf8;    
use POSIX;
use feature     qw< unicode_strings >;
#Support: domoticz@e-nef.com ou forum Domoticz

#Pour ajouter les librairies nécessaires:
#sudo apt-get install libjson-perl libdatetime-perl libwww-perl libxml-simple-perl

#A adapter à votre configuration:
my $domo_ip="192.168.0.31";
my $domo_port="8080";
my $agglomeration="ARRAS";
my $dz_ind=104; #ID d'un device virtuel de type CO2 pour tous les suivants
my $dz_o3=101;
my $dz_no2=103;
my $dz_so2=102;
my $dz_pm10=100;
my $dz_com=105;

#Ne pas toucher en dessous
my $trendsurl = " http://www.lcsqa.org/surveillance/indices/prevus/jour/xml/";

my $json = get( $trendsurl );
die "Could not get $trendsurl!" unless defined $json;

my $xml = new XML::Simple;
# Decode the entire JSON
my $decoded = $xml->XMLin( $json );

# you'll get this (it'll print out); comment this when done.
#print Dumper $decoded;
foreach my $f ( @{$decoded->{node}} ) {
  if ($f->{"agglomeration"}eq $agglomeration) {
	print $f->{"valeurIndice"} . " " . $f->{"SousIndiceO3"} . " " . $f->{"SousIndiceNO2"} ." ". $f->{"SousIndiceSO2"} . " " .$f->{"SousIndicePM10"} . "\n";
	
	my $payload=$f->{"valeurIndice"};
	if (isdigit($payload)) {  }
	else { $payload = 0; }
	`curl -s "http://$domo_ip:$domo_port/json.htm?type=command&param=udevice&idx=$dz_ind&nvalue=$payload"`;
	
	$payload=$f->{"SousIndiceO3"};
	if (isdigit($payload)) {  }
	else { $payload = 0; }
	`curl -s "http://$domo_ip:$domo_port/json.htm?type=command&param=udevice&idx=$dz_o3&nvalue=$payload"`;
	
	$payload=$f->{"SousIndiceNO2"};
	if (isdigit($payload)) {  }
	else { $payload = 0; }
	`curl -s "http://$domo_ip:$domo_port/json.htm?type=command&param=udevice&idx=$dz_no2&nvalue=$payload"`;
	
	$payload=$f->{"SousIndiceSO2"};
	if (isdigit($payload)) {  }
	else { $payload = 0; }
	`curl -s "http://$domo_ip:$domo_port/json.htm?type=command&param=udevice&idx=$dz_so2&nvalue=$payload"`;
	
	$payload=$f->{"SousIndicePM10"};
	if (isdigit($payload)) {  }
	else { $payload = 0; }
	`curl -s "http://$domo_ip:$domo_port/json.htm?type=command&param=udevice&idx=$dz_pm10&nvalue=$payload"`;
	
        $payload=$f->{"Commentaire"};
print ($payload);   
 my $result = index($payload, 'HASH');
print $result;     
if ($result != -1) {
	`curl -s "http://$domo_ip:$domo_port/json.htm?type=command&param=udevice&idx=$dz_com&nvalue=0&svalue=pas%20de%20commentaire"`;
	}
	else{
	 $payload =~ s/'/ /g;
	 $payload =~ s/ /%20/g;
	`curl -s "http://$domo_ip:$domo_port/json.htm?type=command&param=udevice&idx=$dz_com&nvalue=0&svalue=$payload"`;

	}
 
  }
}

