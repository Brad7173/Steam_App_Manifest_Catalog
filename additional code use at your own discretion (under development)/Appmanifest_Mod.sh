#!/bin/bash
#==============================================================================#
#      Scripts created by Katie M. Nelson 3/24/2023 - 3/27/2023                #
#                                                                              #
#==============================================================================#
clear
	zenity --question \
	--ok-label="Yes" \
	--cancel-label="No" \
	--title "Info Message" \
	--width 500 \
	--height 100 \
	--text "This will backup you Steam appmanifest files and modify the originals so that you can play your games offline without errors.
	
	If you are connected to the internet via wifi or ethernet and launch Steam; it scans for any steam file system updates and game updates.
	
	It then modifies the appmanifest flags. Those flags tell Steam there is an update and prevent you from launching the game without updating.
	
	You can bypass this by modifying those flags. You could use a text editor such as kate and open all of them and do a search and replace
	but if you reconnect they will all be modified again.
	
	Would you like to continue?"

if [ $? = 0 ] ; then
	mkdir -p $pth/appmanifest_backup
	mkdir -p ~/SteamBackup
	mkdir -p ~/SteamBackup/.ScriptData
	mkdir -p ~/SteamBackup/AppManifest
	mkdir -p ~/SteamBackup/AppManifest/Original
	mkdir -p ~/SteamBackup/AppManifest/Bak
	mkdir -p ~/SteamBackup/AppManifest/Modified
	pth=$(zenity --title "Please select the directory containing your appmanifest files." --file-selection --directory)/
	cp $pth*.acf  $pth/appmanifest_backup
clear
	cp $pth*.acf  ~/SteamBackup/AppManifest/Original
clear
	cp $pth*.acf  ~/SteamBackup/AppManifest/Bak
clear
for file in ~/SteamBackup/AppManifest/Bak/*.acf; do
mv -- "$file" "${file%.acf}.bak"
done
clear
	zip -r ~/SteamBackup/AppManifest/appmanifest_bak.zip ~/SteamBackup/AppManifest/Bak
clear
	zenity --info \
	--title "Info Message" \
	--width 500 \
	--height 100 \
	--text "Your Files have been backed up."
clear

	cp $pth*.acf ~/SteamBackup/AppManifest/Modified
cd ~/SteamBackup/AppManifest/Modified
	sed -i -- 's/"AllowOtherDownloadsWhileRunning"		"1"/"AllowOtherDownloadsWhileRunning"		"2"/g' *.acf
	sed -i -- 's/"AutoUpdateBehavior"		"0"/"AutoUpdateBehavior"		"1"/g' *.acf
	sed -i -- 's/	"StateFlags"		"2"/	"StateFlags"		"4"/g' *.acf
	sed -i -- 's/	"StateFlags"		"5"/	"StateFlags"		"4"/g' *.acf
	sed -i -- 's/	"StateFlags"		"6"/	"StateFlags"		"4"/g' *.acf
	sed -i -- 's/	"StateFlags"		"36"/	"StateFlags"		"4"/g' *.acf
	sed -i -- 's/	"StateFlags"		"512"/	"StateFlags"		"4"/g' *.acf
	sed -i -- 's/	"StateFlags"		"513"/	"StateFlags"		"4"/g' *.acf
	sed -i -- 's/	"StateFlags"		"514"/	"StateFlags"		"4"/g' *.acf
	sed -i -- 's/	"StateFlags"		"515"/	"StateFlags"		"4"/g' *.acf
	sed -i -- 's/	"StateFlags"		"516"/	"StateFlags"		"4"/g' *.acf
	cp ~/SteamBackup/AppManifest/Modified/*.acf $pth

clear
	zenity --info \
	--title "Info Message" \
	--width 500 \
	--height 100 \
	--text "Your Files have been modified. Enjoy!"
clear
cd ~/SteamBackup/AppManifest/Original
	filenames=$(ls *.acf > ~/SteamBackup/.ScriptData/filenames.txt)
	names=$(cat *.acf | grep '"name"' | sed 's/	"name"		/<name>/g' | grep -oP '(?<=<name>").*?(?=")' > ~/SteamBackup/.ScriptData/names.txt)
	appids=$(cat *.acf | grep '"appid"' |  sed 's/	"appid"		/<appid>/g' | grep -oP '(?<=<appid>").*?(?=")' > ~/SteamBackup/.ScriptData/appids.txt)
	Description=$(paste filenames.txt appids.txt names.txt > ~/SteamBackup/.ScriptData/FileList.txt)
	files=$(cat ~/SteamBackup/.ScriptData/FileList.txt)
	str1=$(cat ~/SteamBackup/.ScriptData/filenames.txt)
	str2=$(cat ~/SteamBackup/.ScriptData/appids.txt)
	str3=$(cat ~/SteamBackup/.ScriptData/names.txt)
clear
cd ~/SteamBackup/AppManifest/Original
	filenames=$(ls *.acf > ~/SteamBackup/.ScriptData/filenames.txt)
	names=$(cat *.acf | grep '"name"' | sed 's/	"name"		/<name>/g' | grep -oP '(?<=<name>").*?(?=")' > ~/SteamBackup/.ScriptData/names.txt)
	appids=$(cat *.acf | grep '"appid"' |  sed 's/	"appid"		/<appid>/g' | grep -oP '(?<=<appid>").*?(?=")' > ~/SteamBackup/.ScriptData/appids.txt)
	StateFlags=$(cat *.acf | grep '"StateFlags"' |  sed 's/	"StateFlags"		/<StateFlags>/g' | grep -oP '(?<=<StateFlags>").*?(?=")' > ~/SteamBackup/.ScriptData/StateFlags.txt)
	Description=$(paste filenames.txt appids.txt names.txt > ~/SteamBackup/.ScriptData/FileList.txt)
	files=$(cat ~/SteamBackup/.ScriptData/FileList.txt)
	str1=$(cat ~/SteamBackup/.ScriptData/filenames.txt)
	str2=$(cat ~/SteamBackup/.ScriptData/appids.txt)
	str3=$(cat ~/SteamBackup/.ScriptData/names.txt)
	str4=$(cat ~/SteamBackup/.ScriptData/StateFlags.txt)
clear
	zenity --title "Appmanifest" \
	--list \
	--text "File List" \
	--column "filenames" \
	--column "appids" \
	--column "StateFlags" \
	--column "names" \
	"$str1" "$str2" "$str4" "$str3"

else
exit
fi
