#!/bin/bash

GW=`netstat -nr | grep default | head -1 |  awk '{while ( match($0,/([0-9]+\.){3}[0-9]+/) ) { print substr($0,RSTART,RLENGTH); $0=substr($0,RSTART+RLENGTH) } }'`

cat bootstrap.template | sed "s/##GW##/$GW/g" > bootstrap.sh
vagrant up
FIRST3=`echo $GW | cut -f1,2,3 -d'.'`

VIP=`vagrant ssh -c ifconfig | grep $FIRST3 | awk '{while ( match($0,/([0-9]+\.){3}[0-9]+/) ) { print substr($0,RSTART,RLENGTH); $0=substr($0,RSTART+RLENGTH) } }' | head -1`
vagrant ssh
vagrant ssh -c "sudo sed -i 's/DROP/ACCEPT/g' /etc/default/ufw"
vagrant ssh -c "sudo sed -i 's/\*filter/*nat\n:POSTROUTING ACCEPT [0:0]\n-A POSTROUTING -s 192.168.1.0\/24 -o eth2 -j MASQUERADE\nCOMMIT\n*filter/g' /etc/ufw/before.rules"
vagrant ssh -c "sudo ufw disable"
vagrant ssh -c "sudo ufw --force enable"
sudo route add -net 172.16.42.0 -netmask 255.255.255.0 $VIP