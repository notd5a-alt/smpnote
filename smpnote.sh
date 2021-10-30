#!/bin/bash

# A Simple note taking script, uses VIM or any other default editor for 
# markdown that you set below, 
# Very useful in writing notes on a daily basis from just the command line
# Add this script to your $PATH if you want to use it everywhere.
 
# e.g. smpnote 'New entry'

# Simple install markdown for python if not already installed
pip3 install markdown

# Change this to your editor of choice
editor() { vim $1; }
# editor() { emacs $1; }
# editor() { nano $1; }
# editor() { typora $1; }
# editor() { code $1; }

# A simple helper function for -h flag
helpp() { echo "Usage: $0 <-h optional> <-p optional> <title>"; }

# using getopts to get flags for help or parse i.e. -h -p
parse=false
title=""
file_path=""

while getopts :hp opt; do
	case ${opt} in
		h) helpp; exit 0;;
		p) parse=true;; # set parse to true and get file_path
		:) echo "Missing argument -${OPTARG}"; exit 1;;
		\?) echo "Unknown option -${OPTARG}"; exit 1;;
	esac
done

#remove parsed options from positional params
shift $(( OPTIND - 1 ))

# now $2==title if specified, if not then title="" by default
# Initial setup complete

file_path="${1}"
output_file="${1%.*}.html"
title="${2}"
folder_struct_y="$(date +'%Y/')" # this is a structure to save the files in a folder format of /YYYY/MM/D.md
folder_struct_m="$(date +'%m/')"
file_name="$(date +'%d').md"
timestamp="$(date +'%r')"
full_path="$folder_struct_y$folder_struct_m"

parser() { python md2html.py -i "$file_path" -o "$output_file" }

create_file() { 
	if [ ! -f "$file_name" ];
	       	then
	       		# create file
			cd "$dir$full_path"
			touch "$file_name"
	fi

	# append timestamp and title to file
	printf "# %s.\n" "$title" >> "$file_name"
	printf "## %s %s \n\n" "$timestamp" >> "$file_name"

	# Finally open with VIM
	editor "$dir$full_path$file_name"
}

if [ "$parse"="false" ];
	then 
	# default directory
	dir="$HOME/smp-note/";
	# create folder in that directory
	# first check if it exists if not then create it 
	if [ ! -d "$dir" ]; then
		mkdir "$dir"
	    mkdir "$dir$folder_struct_y"
		mkdir "$dir$full_path"
		cd "$dir$full_path" # ~/smp-note/YYYY/MM/
	       	
		# file creation
		create_file

		# now we write the title and timestamp into the file using
	else
		# does exist so check if child folders exist
		# if they dont exist then create them
		# if they do exist then just create a file in that dir
		cd "$dir"
		if [ ! -d "$folder_struct_y" ]; 
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
			cd "$dir"
			cd "$folder_struct_y"
			if [ ! -d "$folder_struct_m" ]; 
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
	else # parsing a file given the file path, parser leads to a python script in the same location (md2html.py) that converts the file to html
		parser "$file_path"
fi
