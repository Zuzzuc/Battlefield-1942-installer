#!/bin/bash
# License: The MIT License (MIT)
# Author Zuzzuc https://github.com/Zuzzuc
wd="/tmp/bf1942i"
if [ -d "$wd" ];then
	echo -e "\n\n\nFound incomplete download(s), continuing"
else
	mkdir $wd
fi
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
		curl -o $wd/Wine.zip -C - https://zuzzuc.com/files/Wine.app.zip
		Get_E
		unzip -o $wd/Wine.zip -d /Applications
		rm -rf /Applications/__MACOSX
		echo -e '\nWine has been installed to /Applications/Wine.app\n\n\n'
	fi
fi
echo -e '\n\n'
echo -e 'This is an installer for Battlefield 1942.\nThis installer will require 3GB of free disc space.\nChanges will be made to the following files: "/Applications/Battlefield\ Launcher.command", "~/Documents/Battlefield\ 1942.iso" and "~/Wine\ Files".'
sleep 5
echo -e "\n"
echo -e "Installing pre built wine files\n"
if [ ! -f $wd/WFD ];then
	curl -o $wd/Winefiles.zip -C - https://www.zuzzuc.com/files/bf1942/WinefilesBF1942.zip
	Get_E
	touch $wd/WFD
	echo -e "\n"
	unzip -o $wd/Winefiles.zip -d ~/
	rm -rf ~/__MACOSX
else
	echo "Pre built wine files already downloaded, skipping"
fi
echo -e "\n"
echo -e "Installing battlefield iso\n"
if [ ! -f $wd/DD ];then
	curl -o ~/Documents/Battlefield\ 1942.iso -C - https://www.zuzzuc.com/files/bf1942/bf1942.iso
	Get_E
	touch $wd/DD
else
	echo "Battlefield iso already downloaded, skipping"
fi
echo -e "\n"
echo -e "Installing Battlefield launcher\n"
curl https://zuzzuc.com/files/bf1942/BattlefieldLauncher.sh > /Applications/Battlefield\ Launcher.command
Get_E
chmod u+x /Applications/Battlefield\ Launcher.command
rm -rf "$wd"
echo -e "\n\n\n"
echo 'Done! To launch Battlefield 1942 go to your applications and open "Battlefield launcher.command"'
echo -e "\n\n\n"