#!/bin/bash

IFS=$'\n'
location=$1
sub_folder=$2

echo "Persian Subtitle Fixer"
echo "github.com/moeen/PersianSubtitleFixer"
echo

if [[ -z "$sub_folder" ]]; then
    read -p "Enter the export directory name in $HOME: " sub_folder
fi

if [[ ! -d "$HOME/$sub_folder" ]]; then
    mkdir "$HOME/$sub_folder"
fi

if [[ -z "$location" ]]; then
    read -p "Enter your subtitles directory address: " location
fi

subs=`find "$location" -type f -name '*.srt'`

number_of_subs=0

for s in ${subs}; do
    type=`file -b ${s}`
    sub_name=`echo ${s} | sed 's#.*/##'`
    if [[ "$type" == "Non-ISO extended-ASCII text, with CRLF line terminators" ]]; then
        number_of_subs=$((number_of_subs+1))
        iconv -f WINDOWS-1256 -t UTF-8 "$s" -o "$HOME/$sub_folder/FIXED_$sub_name"
        echo "FIXED: $sub_name"
    elif [[ "$type" == "Little-endian UTF-16 Unicode text, with CRLF, CR line terminators" ]]; then
        number_of_subs=$((number_of_subs+1))
        iconv -f UTF-16 -t UTF-8 "$s" -o "$HOME/$sub_folder/FIXED_$sub_name"
        echo "FIXED: $sub_name"
    fi
done

echo
echo "---------------------------"

echo "$number_of_subs subtitle(s) fixed in $HOME/$sub_folder"
