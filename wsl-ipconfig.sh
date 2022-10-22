#!/bin/bash
#每次重启电脑执行一次

#这里控制你的ip地址
NEW_IP=192.168.10.110

#广播地址，假如子网掩码是24位，则最后是255，其他相同
BRD=192.168.10.255

#网关地址，填路由器地址
GATEWAY=192.168.10.1

#域名服务器地址，填路由器地址
NAMESERVER=192.168.10.1

#网络设备，默认eth0
NET_DEV=eth0

#下面将密码发送给sudo，删除旧ip配置，设置新ip、网关、域名服务器
sudo -S ip addr del $(ip addr show $NET_DEV | grep 'inet\b' | awk '{print $2}' | head -n 1) dev $NET_DEV
sudo ip addr add $NEW_IP/24 broadcast $BRD dev $NET_DEV
sudo ip route add 0.0.0.0/0 via $GATEWAY dev $NET_DEV
sudo sed -i "\$c nameserver $NAMESERVER" /etc/resolv.conf