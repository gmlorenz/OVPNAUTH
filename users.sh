#!/bin/bash
##
## Debian VPN User Count Script
## by JohnFordTV
##
## Copyright (c) Debian VPN 2019. All Rights Reserved
##


count=$(mysql -s -N -hDBhost -P3306 -uDBuser -pDBpass DBname -e "SELECT count(user_server) FROM users WHERE user_server='ServerPrefix'")
mysql -s -N -hDBhost -P3306 -uDBuser -pDBpass DBname -e "UPDATE servers SET server_users='$count' WHERE server_prefix='ServerPrefix'"