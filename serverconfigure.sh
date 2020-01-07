#!/bin/bash
##
## Debian VPN Server Configure Script
## by JohnFordTV
##
## Copyright (c) Debian VPN 2019. All Rights Reserved
##


clear
echo "Welcome to JohnFordTV's Server Configure Script"
echo "for Debian VPN"
echo ""
echo "Please type the Server Prefix"
read -p "Prefix: " -e -i Prefix01 ServerPrefix
echo ""
echo "Please type the Database IP"
read -p "IP: " -e -i 127.0.0.1 DBhost
echo ""
echo "Please type the Database Username"
read -p "DB Username: " -e -i JohnFordTV DBuser
echo ""
echo "Please type the Database Password"
read -p "DB Password: " -e -i JohnFordTV DBpass
echo ""
echo "Please type the Database Name"
read -p "DB Password: " -e -i JohnFordTV DBname
echo ""
echo "Okay, that's all I need. We are ready to setup your Panel now"
read -n1 -r -p "Press any key to continue..."

## Configure Website
sed -i "s/DBhost/$DBhost/g" ~/users.sh
sed -i "s/DBuser/$DBuser/g" ~/users.sh
sed -i "s/DBpass/$DBpass/g" ~/users.sh
sed -i "s/DBname/$DBname/g" ~/users.sh
sed -i "s/ServerPrefix/$ServerPrefix/g" ~/users.sh

sed -i "s/DBhost/$DBhost/g" /etc/openvpn/login.sh
sed -i "s/DBuser/$DBuser/g" /etc/openvpn/login.sh
sed -i "s/DBpass/$DBpass/g" /etc/openvpn/login.sh
sed -i "s/DBname/$DBname/g" /etc/openvpn/login.sh
sed -i "s/ServerPrefix/$ServerPrefix/g" /etc/openvpn/login.sh