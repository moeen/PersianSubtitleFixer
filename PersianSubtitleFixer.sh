#!/bin/bash
IFS=$'\n'
clear
echo "Persian Subtitle Fixer"
echo
read -p "Enter a name for fixed subtitles directory in your home directory :  " subfolder
if [ ! -d "$HOME/$subfolder" ]
	then
		mkdir "$HOME/$subfolder"		
fi
echo
read -p "Enter your subtitles location :  " location
subs=`find "$location" -type f -name '*srt'`

for s in $subs;do
        type=`file -b $s`
		if [ "$type" == "Non-ISO extended-ASCII text, with CRLF line terminators" ]
			then
				subname=`echo $s | sed 's#.*/##'`
				iconv -f WINDOWS-1256 -t UTF-8 "$s" -o "$HOME/$subfolder/(fixed)$subname"
				echo "$subname fixed"
			else
				if [ "$type" == "Little-endian UTF-16 Unicode text, with CRLF line terminators" ]
					then
						subname=`echo $s | sed 's#.*/##'`
						iconv -f UTF-16 -t UTF-8 "$s" -o "$HOME/$subfolder/(fixed)$subname"
						echo "$subname fixed"
				fi
		fi
done
echo
echo "---------------------------"

numberofsubs=`ls -1 "$HOME/$subfolder" | wc -l`
echo "$numberofsubs subtitles fixed in $HOME/$subfolder"
