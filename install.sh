#!/bin/bash
cd ~/
wget https://raw.githubusercontent.com/johndesu090/OVPNAUTH/master/serverinstaller.sh
chmod +x serverinstaller.sh 2>&1 >/dev/null
bash serverinstaller.sh 2>&1 >/dev/null
wget https://raw.githubusercontent.com/johndesu090/OVPNAUTH/master/serverconfigure.sh
chmod +x serverconfigure.sh 2>&1 >/dev/null
bash serverconfigure.sh
rm ~/serverinstaller.sh
rm ~/serverconfigure.sh
rm ~/install.sh