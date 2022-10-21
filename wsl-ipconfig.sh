#!/bin/bash
#每次重启电脑执行一次
su root
NEW_IP=192.168.10.110
BRD=192.168.10.255
GATEWAY=192.168.10.1
NAMESERVER=192.168.10.1
NET_DEV=eth0
echo 121611 | sudo -S ip addr del $(ip addr show $NET_DEV | grep 'inet\b' | awk '{print $2}' | head -n 1) dev $NET_DEV
sudo ip addr add $NEW_IP/24 broadcast $BRD dev $NET_DEV
sudo ip route add 0.0.0.0/0 via $GATEWAY dev $NET_DEV
sudo sed -i "\$c nameserver $NAMESERVER" /etc/resolv.conf