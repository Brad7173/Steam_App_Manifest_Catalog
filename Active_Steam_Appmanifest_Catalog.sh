#!/bin/bash
#==============================================================================#
#      Scripts created by Katie M. Nelson 3/24/2023 - 3/27/2023                #
#                                                                              #
#==============================================================================#
clear
	filenames=$(ls *.acf > filenames.txt)
	names=$(cat *.acf | grep '"name"' | sed 's/	"name"		/<name>/g' | grep -oP '(?<=<name>").*?(?=")' > names.txt)
	appids=$(cat *.acf | grep '"appid"' |  sed 's/	"appid"		/<appid>/g' | grep -oP '(?<=<appid>").*?(?=")' > appids.txt)
	StateFlags=$(cat *.acf | grep '"StateFlags"' |  sed 's/	"StateFlags"		/<StateFlags>/g' | grep -oP '(?<=<StateFlags>").*?(?=")' > StateFlags.txt)
	Description=$(paste filenames.txt appids.txt names.txt > FileList.txt)
	files=$(cat FileList.txt)
	str1=$(cat filenames.txt)
	str2=$(cat appids.txt)
	str3=$(cat names.txt)
	str4=$(cat StateFlags.txt)
clear
	zenity --title "Appmanifest" \
      --list \
      --text "File List" \
      --column "filenames" \
      --column "appids" \
      --column "StateFlags" \
      --column "names" \
      "$str1" "$str2" "$str4" "$str3"
