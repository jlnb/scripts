#!/bin/bash

echo "First, test copy-functionality"
./renameFiles.sh inputfolder 0
./renameFiles.sh inputfolder C

echo "Files and folders after copy-function:"
tree

./resetTestEnvironment.sh

echo "Second, test move-functionality"
./renameFiles.sh inputfolder 0
./renameFiles.sh inputfolder M

echo "Files and folders after move-function:"
tree



