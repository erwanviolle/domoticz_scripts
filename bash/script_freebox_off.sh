#!/bin/bash
if ping -c 1 192.168.0.39
then
curl -s "http://hd1.freebox.fr/pub/remote_control?code=64058863&key=power"
fi
