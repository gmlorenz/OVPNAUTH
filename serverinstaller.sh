#!/bin/bash
##
## Debian VPN Server Installer Script
## by JohnFordTV
##
## Copyright (c) Debian VPN 2019. All Rights Reserved
##


## Check if VPS have root access
if [[ "$EUID" -ne 0 ]]; then
	echo "Sorry, you need to run this as root"
	exit
fi

## Check if TUN Device is available
if [[ ! -e /dev/net/tun ]]; then
	echo "The TUN device is not available
You need to enable TUN before running this script"
	exit
fi

## Check if VPS have Debian OS
if [[ -e /etc/debian_version ]]; then
	OS=debian
	GROUPNAME=nogroup
	RCLOCAL='/etc/rc.local'
else
	echo "Looks like you aren't running this installer on Debian, Ubuntu or CentOS"
	exit
fi

## GET REAL IP
if [[ "$PUBLICIP" != "" ]]; then
	IP=$PUBLICIP
fi

## Updating System and Installing OpenVPN and other Application
apt-get update
apt-get install openvpn squid ufw mysql-client unzip -y

## Packet Forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
sed -i '/net.ipv4.ip_forward=1/s/^#//g' /etc/sysctl.conf
ufw allow ssh
ufw allow 443/tcp
ufw allow 8000/tcp
ufw allow 8080/tcp
sed -i 's/\(DEFAULT_FORWARD_POLICY=\).*/\1"ACCEPT"/' /etc/default/ufw
sed -i '11i# START OPENVPN RULES\n# NAT table rules\n*nat\n:POSTROUTING ACCEPT [0:0]\n# Allow traffic from OpenVPN client to eth0\n-A POSTROUTING -s 10.8.0.0/8 -o eth0 -j MASQUERADE\nCOMMIT\n# END OPENVPN RULES\n' /etc/ufw/before.rules
echo y | ufw enable

## Configure Squid Proxy
wget -O /etc/squid3/squid.conf https://raw.githubusercontent.com/johndesu090/OVPNAUTH/master/squid.conf
IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
sed -i "s/ipmokasito/$IP/g" /etc/squid3/squid.conf

## Download OpenVPN Files
cd /etc/openvpn/
rm *
wget https://raw.githubusercontent.com/johndesu090/OVPNAUTH/master/openvpn.zip
unzip openvpn.zip
rm openvpn.zip

## Download User Count Script
cd ~
wget https://raw.githubusercontent.com/johndesu090/OVPNAUTH/master/users.sh
crontab -l > mycron
echo "* * * * * ~/users.sh" >> mycron
crontab mycron
rm mycron

## Setting Permission
chmod +x ~/users.sh
chmod +x /etc/openvpn/login.sh

## Start Debian VPN
service openvpn restart
service squid3 restart
clear
ovpn=openvpn
proxy=squid3
if (( $(ps -ef | grep -v grep | grep $ovpn | wc -l) > 0 ))
	then
	echo "OpenVPN is Running"
	else
	echo "Error Starting OpenVPN. Please contact JohnFordTV"
fi
if (( $(ps -ef | grep -v grep | grep $proxy | wc -l) > 0 ))
	then
	echo "Squid Proxy is Running"
	else
	echo "Error Starting Squid Proxy. Please contact JohnFordTV"
fi