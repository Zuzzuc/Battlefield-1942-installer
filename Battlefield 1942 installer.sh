#!/bin/bash
# License: The MIT License (MIT)
# Author Zuzzuc https://github.com/Zuzzuc
wd="/tmp/bf1942i"
mkdir $wd
function Get_E {
	ExitStatus=$?
	if [ "$ExitStatus" != "0" ]; then
		echo -e "\n"
		echo 'Something went wrong... Error code: $ExitStatus. Aborting installation.'
		exit $ExitStatus
	fi
}
if [ -d /Applications/Wine.app ]; then
    WI=true
else
    WI=false
fi
echo -e "\n\n"
if [ "$WI" == "true" ] ; then
	echo "WARNING"
	echo "This script will overwrite your current wine files! Quit this script (ctrl + c) and do a backup now if you have anything of importance there."
	echo "WARNING"
	sleep 5
else 
	echo 'Wine does not appear to be properly installed.'
	echo -e 'Would you like to download and install it now? Type:[y]es or [n]o\n'
	read InstallWine
	if [ "$InstallWine" == "y" ];then
		echo -e 'Installing Wine\n'
		curl -o $wd/Winefiles.zip -C - http://zuzzuc.com/files/Wine.app.zip
		unzip -o $wd/Winefiles.zip -d /Applications
		rm -rf $wd/Wine.zip
		rm -rf /Applications/__MACOSX
		echo -e '\nWine has been installed to /Applications/Wine.app\n\n\n'
	fi
fi
echo -e '\n\n'
echo -e 'This is a installer for battlefield 1942.\nThis installer will require 2.5GB of free disc space.\nChanges will be made to the following files: "/Applications/Battlefield\ Launcher.command", "~/Documents/Battlefield\ 1942.iso" and "~/Wine\ Files".'
sleep 5
echo -e "\n"
echo -e "Installing pre built wine files\n"
curl -o $wd/Winefiles.zip -C - http://www.zuzzuc.com/files/bf1942/WinefilesBF1942.zip
Get_E
echo -e "\n"
unzip -o $wd/Winefiles.zip -d ~/
rm -rf $wd/Winefiles.zip
rm -rf ~/__MACOSX
echo -e "\n"
echo -e "Installing battlefield slim iso\n"
curl -o ~/Documents/Battlefield\ 1942.iso -C - http://www.zuzzuc.com/files/bf1942/bf1942slim.iso
Get_E
echo -e "\n"
echo -e "Installing Battlefield launcher\n"
curl http://zuzzuc.com/files/bf1942/BattlefieldLauncher.sh > /Applications/Battlefield\ Launcher.command
Get_E
chmod u+x /Applications/Battlefield\ Launcher.command
rm -rf $wd
echo -e "\n\n\n"
echo 'Done! To launch Battlefield 1942 go to your applications and open "Battlefield launcher.command"'
echo -e "\n\n\n"