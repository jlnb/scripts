#!/bin/bash

INPUTFOLDER="${1:-"."}"

if ! [ -d "$INPUTFOLDER" ]; then
    echo " "
    echo "####### WARNING #######"
    echo "The first input argument is not a folder. Using current folder instead as input folder."
    echo "###################### "
    echo " "
    INPUTFOLDER="."
fi

MODE="${2:-"0"}"

find "$INPUTFOLDER" -type f -regex '.*[\*\\@:\|<>?"].*' | while IFS= read -r file; do
    FILENAME=$(basename "$file")
    FOLDERNAME=$(dirname "$file")
    
    # Replace all not allowed characters in the file name
    FILENAME=$(echo "$FILENAME" | sed -r 's/[\*\\@:\|<>?"/]/_/g')
    
    if [[ ! -e "$FOLDERNAME/$FILENAME" ]]; then
	if [ "$MODE" = "C" ]; then
	    #echo "cp -p "\'$file\'" "\'$FOLDERNAME/$FILENAME\'""
	    cp -p "$file" "$FOLDERNAME/$FILENAME"
	elif [ "$MODE" = "M" ]; then
	    #echo "mv "\"$file\"" "\"$FOLDERNAME/$FILENAME\"""
	    mv "$file" "$FOLDERNAME/$FILENAME"
	else
	   echo "[mv|cp -p] "\'$file\'" "\'$FOLDERNAME/$FILENAME\'""
        fi
    else
        echo "---"
        echo "File $file not moved or copied to target folder."
        echo "File already exists:"
	echo "$FOLDERNAME/$FILENAME"
        echo "---"
    fi
done

