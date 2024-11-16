#!/bin/bash

# echo "Number of arguments: $#"

FOLDER=${1:-"."}
# echo "$FOLDER*"

if [ -d "FOLDER" ]; then
    echo "YES, I AM A FOLDER"
fi

for file in "$FOLDER"/*
do
    export NEWNAME=$(echo "$file" | sed -r 's/[<>?\\:]/_____/g')
    #echo "$NEWNAME"
    #mv "$file" "$NEWNAME"

    if [ -d "./$file" ]; then
	echo "$file is a directory"
    fi

    if [ -f "./$file" ]; then
	echo "$file is a file"

	if [ "$file" = "$NEWNAME" ]; then
	    echo "No renaming necessary for file: $file"
	else
	    echo "Renaming from:"
	    echo "$file"
	    echo "to $NEWNAME"
	fi
    fi
done
