#!/bin/bash
if ping -c 2 192.168.0.39
then
echo "allume"
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=home&long=true"
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=home&long=true"
sleep 5
else
echo "etain"
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=power"
sleep 20
fi

curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=vol_dec&long=true"
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=vol_dec&long=true"
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=vol_dec&long=true"
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=vol_dec&long=true"
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=vol_dec&long=true"
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=vol_dec&long=true"
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=vol_dec&long=true"
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=vol_dec&long=true"
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=vol_dec&long=true"
sleep 5

curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=right"
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=right"

curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=down"
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=down"

curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=ok"
sleep 5
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=down"
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=down"
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=down"
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=down"
sleep 2
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=right"
sleep 2
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=down"
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=down"
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=down"
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=down"
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=down"
sleep 2
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=right"
sleep 2
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=down"
sleep 2
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=ok"
sleep 1

curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=vol_inc&long=true"
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=vol_inc&long=true"
sleep 10
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=vol_inc"
