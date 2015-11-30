#!/bin/bash

# This script iterates over every folder in the targeted directory and examines the MP3s in each.  If the bit rate
# is at or below 128 kbps, both the file and the folder containing it are labeled with a color (yellow at the
# moment).

for d in /Users/Me/Desktop/MP3s/*/; do
    echo "$d"    # Reports the directory being worked on, so you know how it's progressing
    cd "$d"    # Change to the directory
    d2=$(echo $d | sed 's/[/]/:/g')    # Reformat the directory path so osascript will accept it
    for m in *.mp3; do
        br=$(afinfo "$m" | grep "bit rate" | sed 's/[^0-9]*//g')  # Isolate the bit rate info; will be in bits/sec
        if [ $br -le 128000 ]
        then
            mf=THISMAC$d2$m     # Construct the full path to the file
            osascript -e 'tell application "Finder" to set label index of alias "'"$mf"'" to 3'
            osascript -e 'tell application "Finder" to set label index of alias "'"THISMAC${d2%?}"'" to 3'
        fi
    done
done