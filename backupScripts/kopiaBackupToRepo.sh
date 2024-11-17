#!/bin/bash

MODE=${1:-"connect"}
REPOLOCATION="/path/to/kopia/repo"

# Locations to be backed up
SOURCES=("/path/to/first/location/to/be/backed/up" \
	"/path/to/second/location/to/be/backed/up" \
	"/path/to/third/location/to/be/backed/up" \
	)


if [ -d "$REPOLOCATION" ]; then
	case $MODE in
		connect)
			echo "MODE: Connect"
			kopia repository connect filesystem --path=$REPOLOCATION
			;;
		create)
			echo "MODE: Create"
			kopia repository create filesystem --path=$REPOLOCATION
			;;
		setcompression)
			echo "MODE: Set compression"
			kopia repository connect filesystem --path=$REPOLOCATION
			for SNAP in ${SOURCES[@]}; do
				echo "$SNAP"
				kopia policy set --compression=zstd "$SNAP"
			done
			kopia repository disconnect
			;;
		snapshot)
			echo "MODE: Snapshot"
			kopia repository connect filesystem --path=$REPOLOCATION
			for SNAP in ${SOURCES[@]}; do
				echo "$SNAP"
				kopia snapshot create "$SNAP"
			done
			kopia repository disconnect
			;;
		*)
			echo "MODE: Unknown - doing nothing"
			;;
	esac
else
	echo "Location for repository does not exist. Aborting..."
	echo " "

fi

