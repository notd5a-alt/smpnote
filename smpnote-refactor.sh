#!/bin/bash
# change to editor of choice
editor() { vim '+normal Go' "$1"; } # opens in insert mode as a new line at EOF

# Help context
helpp() { echo "Usage: $0 -h"; echo "Usage $0 -p "path/to/md/file" "; echo "Usage: $0 "Some Entry Title" "; exit; }

# variables needed beforehand
# set the 
SMPNOTE_INSTALL_PATH="$HOME/.smpnote/"
SMPNOTE_NOTE_PATH="$HOME/smpnote/"
parse="false"
title=""
file_path=""

# getopts for argument parsing
while getopts :hp opt; do
  case ${opt} in
    h) helpp;;
    p) parse="true";;
    :) echo "Missing Args -${OPTARG}"; helpp;;
    \?) echo "Unkown option -${OPTARG}"; helpp;;
  esac
done

shift "$((OPTIND-1))"

if [ "$parse" = "true" ]; then
  file_path="${1}"
  title="${2}"
else
  title="${1}"
fi

# variables for parsing
html_out_dir="${file_path%.*}/parsed/"
output_file="${html_out_dir}home.html"
style_file="${html_out_dir}style.css"

# variables for note taking
folder_path="$(date +"%Y/%m/")"
filename="$(date +"%d").md"
timestamp="$(date +"%r")"

# parser function
parser() {
  mkdir -p "$html_out_dir" || exit 2;
  cd "$html_out_dir" || exit 2;
  find -type f -name \*.png -exec install -D {} /"${html_out_dir}"{} \;
  python3 "${SMPNOTE_INSTALL_PATH}md2html.py" -i "$file_path" -o "$output_file" -s "$style_file";
}

createfile() {
  if [ ! -f "$filename" ];
  then
    touch "$SMPNOTE_NOTE_PATH$folder_path$filename"
    printf "[//]: <> (%s)\n" "$SMPNOTE_NOTE_PATH$folder_path$filename" | tee -a "$filename" > /dev/null
  fi
  printf "\n# %s\n" "$title" | tee -a "$filename" > /dev/null
  printf "> %s%s \n\n" "$timestamp" | tee -a "$filename" > /dev/null
  editor "$SMPNOTE_NOTE_PATH$folder_path$filename"
}

# main
if [ "$parse" = "false" ];
then
  # create directories needed if they doesnt exist using -p
  mkdir -p "$SMPNOTE_NOTE_PATH$folder_path" || exit 3
  cd "$SMPNOTE_NOTE_PATH$folder_path" || exit 3
  createfile
else
  parser
fi


  





































