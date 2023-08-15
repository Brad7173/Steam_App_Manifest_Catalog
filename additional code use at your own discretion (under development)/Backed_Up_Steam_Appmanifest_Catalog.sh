#!/bin/bash
#==============================================================================#
#      Scripts created by Katie M. Nelson 3/24/2023 - 3/27/2023                #
#                                                                              #
#==============================================================================#
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
