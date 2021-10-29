#!/bin/bash

# A Simple note taking script, uses VIM or any other default editor for 
# markdown that you set below, 
# Very useful in writing notes on a daily basis from just the command line
# Add this script to your $PATH if you want to use it everywhere.

# Passing input into the script below using flags,
# there are 2 flags to concentrate on:
# -t : title
# -d : directory (can be dynamic or a full path)
# if -d isnt specified then use the current dir

# e.g. smpnote -t 'New note' -d 'some/dir'
# or 
# e.g. smpnote -t 'New note'

term="vim"

while getopts t:d: flag
do
	case "${flag}" in
		t) title=&{OPTARG};;
		d) directory=&{OPTARG};;
	esac
done

# Variables can be accessed using $title and $directory
# Store the current dir into a variable

pwd=$(pwd)
directory="$pwd $directory"

echo "$directory"
echo "$vim"
