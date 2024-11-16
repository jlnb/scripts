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

TARGETFOLDER="${2:-"."}"
MODE="${3:-"0"}"

if ! [ -d "$TARGETFOLDER" ]; then
    echo " "
    echo "####### WARNING #######"
    echo "The second input argument is not a folder. Using current folder instead as output folder."
    echo "###################### "
    echo " "
    TARGETFOLDER="."
fi

TARGETFOLDER=$(realpath "$TARGETFOLDER")

# Check if a not allowed character is used in the TARGETFOLDER
pattern='.*[\*\\@:\|<>?"].*'
if ! [[ $TARGETFOLDER =~ $pattern ]]; then

    find "$INPUTFOLDER" -type f -regex '.*[\*\\@:\|<>?"].*' | while IFS= read -r file; do
	FILENAME=$(echo "$(basename "$file")")
    
	# Replace all not allowed characters in the file name
	FILENAME=$(echo "$FILENAME" | sed -r 's/[\*\\@:\|<>?"/]/_/g')
    
	if [[ ! -e "$TARGETFOLDER/$FILENAME" ]]; then
	    if [ "$MODE" = "C" ]; then
		#echo "cp -p "\'$file\'" "\'$TARGETFOLDER/$FILENAME\'""
		cp -p "$file" "$TARGETFOLDER/$FILENAME"
	    elif [ "$MODE" = "M" ]; then
		#echo "mv "\"$file\"" "\"$TARGETFOLDER/$FILENAME\"""
		mv "$file" "$TARGETFOLDER/$FILENAME"
	    else
		echo "[mv|cp -p] "\'$file\'" "\'$TARGETFOLDER/$FILENAME\'""
	    fi
	else
	    echo "File $file not moved or copied to target folder."
	    echo "Renamed file already exists:"
	    echo "$TARGETFOLDER/$FILENAME"
	fi
    done

else
    echo " "
    echo "####### WARNING #######"
    echo "The path to the target folder contains unallowed characters!"
    echo "Unallowed characters: \\/:*?\"<>|"
    echo "Provided path for target folder:"
    echo "$TARGETFOLDER"
    echo "#######################"
fi
