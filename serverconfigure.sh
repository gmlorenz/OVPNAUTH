#!/bin/bash
##
## Debian VPN Server Configure Script
## by JohnFordTV
##
## Copyright (c) Debian VPN 2019. All Rights Reserved
##


clear
echo " Configurer PrivateconVPN"
echo "Debian9,10 Ubuntu16 - x64"
echo ""
echo "Please type the Server Prefix"
read -p "Prefix: " -e -i PRIV01 ServerPrefix
echo ""
echo "Please type the Database IP"
read -p "IP: " -e -i 194.59.164.1 DBhost
echo ""
echo "Please type the Database Username"
read -p "DB Username: " -e -i u301507557_root DBuser
echo ""
echo "Please type the Database Password"
read -p "DB Password: " -e -i Privatecon DBpass
echo ""
echo "Please type the Database Name"
read -p "DB Password: " -e -i u301507557_priv DBname
echo ""
echo "Okay, that's all I need. We are ready to setup your server now"
read -n1 -r -p "Press any key to continue..."

## Configure Website
sed -i "s/DBhost/$DBhost/g" /etc/openvpn/login.sh
sed -i "s/DBuser/$DBuser/g" /etc/openvpn/login.sh
sed -i "s/DBpass/$DBpass/g" /etc/openvpn/login.sh
sed -i "s/DBname/$DBname/g" /etc/openvpn/login.sh
sed -i "s/ServerPrefix/$ServerPrefix/g" /etc/openvpn/login.sh
