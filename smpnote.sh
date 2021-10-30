#!/bin/bash

# A Simple note taking script, uses VIM or any other default editor for 
# markdown that you set below, 
# Very useful in writing notes on a daily basis from just the command line
# Add this script to your $PATH if you want to use it everywhere.

# Passing input into the script below using flags,
# there are 2 flags to concentrate on:
# -t : title
# -d : directory (dynamic path (from current working directory)
# if -d isnt specified then use the current dir
 
# e.g. smpnote title some/directory/

# Change this to your editor of choice
editor() { vim $1; }


# editor="emacs"
# editor="typora"

# Simple usage function

# Initial Set up complete
title=${1}
folder_struct_y="$(date +'%Y/')" # this is a structure to save the files in a folder format of /YYYY/MM/D.md
folder_struct_m="$(date +'%m/')"
file_name="$(date +'%d').md"
timestamp="$(date +'%r')"
working_dir=$(pwd)

create_file() { 
	if [ ! -f "$file_name" ];
	       	then
	       		# create file
			cd "$dir$folder_struct_y$folder_struct_m"
			touch "$file_name"
	fi

	# append timestamp and title to file
	printf "# %s.\n" $title >> "$file_name"
	printf "## %s %s \n\n" $timestamp >> "$file_name"

	# Finally open with VIM
	editor "$dir$folder_struct_y$folder_struct_m$file_name"
}

if [ -z "${2+x}" ];
	then 
	# default directory
	dir="$HOME/smp-note/";
	# create folder in that directory
	# first check if it exists if not then create it 
	if [ ! -d "$dir" ]; then
		mkdir "$dir"
	       	mkdir "$dir$folder_struct_y"
		mkdir "$dir$folder_struct_y$folder_struct_m"
		cd "$dir$folder_struct_y$folder_struct_m" # ~/smp-note/YYYY/MM/
	       	
		# file creation
		create_file

		# now we write the title and timestamp into the file using
	else
		# does exist so check if child folders exist
		# if they dont exist then create them
		# if they do exist then just create a file in that dir
		if [ ! -d "$dir$folder_struct_y"]; 
		then 
			cd "$dir"
			mkdir "$folder_struct_y"
			cd "$folder_struct_y"
			if [ ! -d "$folder_struct_m" ]; 
				then
					# create dir
					mkdir "$folder_struct_m"
					cd "$folder_struct_m"
					create_file
				else
					# exists so no need to create just cd into it.
					cd "$folder_struct_m"
					# FILE CHECKING == If exists then append title and timestamp into it, otherwise create and do the same
					create_file
			fi
		else
			# exists so cd into it and check if folderstructm exists
			cd "$folder_struct_y"
			if [ ! -d "$folder_struct_m"]; 
				then
					# create dir
					mkdir "$folder_struct_m"
					cd "$folder_struct_m"
					
					# FILE
					create_file
				else
					# exists so cd into it
					cd "$folder_struct_m"
					
					# FILE CHECKING == if exists then append title and timestamp into it, otherwise create and do the same
					create_file
			fi
		fi
	fi	
	else # custom directory
		dir="$working_dir$2";
fi
