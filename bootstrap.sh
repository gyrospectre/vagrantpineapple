#!/bin/bash

curl https://www.wifipineapple.com/wp6.sh -o /root/wp6.sh
chmod +x /root/wp6.sh
sudo route del -net 0.0.0.0
sudo route add -net 0.0.0.0 gw 192.168.1.1

echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.forwarding=1" >> /etc/sysctl.conf
sudo sysctl -p

#apt update
#apt upgrade -y
#apt install usbutils -y
