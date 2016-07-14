#!/bin/bash
# Author Zuzzuc https://github.com/Zuzzuc
function Error_Catcher {
ExitStatus=$?
if [ "$ExitStatus" != "0" ]; then
echo -e "\n"
echo 'Something went wrong... Error code: $ExitStatus. Aborting installation.'
exit 1
fi
}
if [ -d /Applications/Wine.app ]; then
    WI=true
    else
    WI=false
fi
echo -e "\n\n"
if [ "$WI" = true ] ; then
	echo "WARNING"
	echo "This script will overwrite your current wine files! Quit this script (ctrl + c) and do a backup now if you have anything of importance there."
	echo "WARNING"
	sleep 5
else 
	echo 'Wine does not appear to be properly installed.'
	echo -e 'Would you like to download and install it now? Type:[y]es or [n]o\n'
	read Install
	if [ $Install = "y" ];then
		echo -e '\n'
		curl -L http://www.dropbox.com/s/t92i7ow2l950u9i/Wine.app.zip?dl=l > /tmp/Wine.zip
		Error_Catcher
		unzip -o /tmp/Wine.zip -d /Applications
		rm -rf /tmp/Wine.zip
		rm -rf /Applications/__MACOSX
		echo -e '\nWine has been installed to /Applications/Wine.app\n\n\n'
	fi
fi
echo -e '\n\n'
echo -e 'This is a installer for battlefield 1942.\nThis installer will require 3GB of free disc space.\nChanges will be made to the following files: "/Applications/Battlefield\ Launcher.command", "~/Documents/Battlefield\ 1942.iso" and "~/Wine\ Files".'
sleep 10
echo -e "\n"
curl -L  http://www.dropbox.com/s/lkftx5yxc4c7wqf/Wine%20Files.zip?dl=1 > /tmp/Winefiles.zip
Error_Catcher
echo -e "\n"
unzip -o /tmp/Winefiles.zip -d ~/
rm -rf /tmp/Winefiles.zip
rm -rf ~/__MACOSX
echo -e "\n"
curl -L http://www.dropbox.com/s/fe2hotilqb4tugs/Battlefield%201942%20CD1.iso?dl=l > ~/Documents/Battlefield\ 1942.iso
Error_Catcher
echo -e "\n"
curl http://orb.net23.net/BattlefieldLauncher.sh > /Applications/Battlefield\ Launcher.command
Error_Catcher
chmod u+x /Applications/Battlefield\ Launcher.command
echo -e "\n\n\n"
echo 'Done! To launch Battlefield 1942 go to your applications and open "Battlefield launcher.command"'
echo -e "\n\n\n"
