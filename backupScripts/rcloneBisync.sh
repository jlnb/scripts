#!/bin/bash

MODE=${1:-"help"}

case $MODE in
    help)
	echo "MODE: Help"
	echo "So far you can only choose between 'help', 'resync', or 'bisync'"
	;;
    resync)
	echo "MODE: Resync"
	#rclone bisync remote1:path1 remote2:path2 --resilient --recover --create-empty-src-dirs --filter-from bisyncfilter.txt --max-lock 2m --config=/path/to/rclone.conf -MvP --resync 
	;;
    bisync)
	echo "MODE: Bisync"
	#rclone bisync remote1:path1 remote2:path2 --resilient --recover --create-empty-src-dirs --filter-from bisyncfilter.txt --max-lock 2m --config=/path/to/rclone.conf -MvP --backup-dir1 remote1:backup_path1 --backup-dir2 remote2:backup_path2 --check-access --check-filename RCLONE_CHECK_ACCESS.md --conflict-resolve newer --dry-run
	;;
    check)
	echo "MODE: Check"
	#rclone check  remote1:path1 remote2:path2 --config=/path/to/rclone.conf --size-only --missing-on-dst missing_on_dst.txt --missing-on-src missing_on_src.txt
	;;
    *)
	echo "MODE: Unknown - doing nothing"
	;;
esac


