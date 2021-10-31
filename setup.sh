#!/bin/bash
# Simple set up script for the user and me in the future

INSTALL_DIR="$HOME/.smpnote"
DEFAULT_SAVE_DIR="$HOME/smpnote/" # default save directory
NOTE_SAVE_DIR=""
# take input from user
echo "Where would you like your notes to be automatically saved to?"
echo "Ensure that this is a full path i.e. /home/user/some/directory <- in this format."
echo "Leave empty for Default: ($DEFAULT_SAVE_DIR)"
read -p "Custom Directory: " NOTE_SAVE_DIR

if [ "$NOTE_SAVE_DIR" = "" ]; then
  NOTE_SAVE_DIR="$DEFAULT_SAVE_DIR"
fi

# init
echo "Creating Installation directory"
mkdir -p "$INSTALL_DIR" || exit 1
mkdir -p "$NOTE_SAVE_DIR" || exit 1
mkdir -p "$INSTALL_DIR/vars"
touch "$INSTALL_DIR/vars/USERSAVEDIR"
touch "$INSTALL_DIR/vars/INSTALLDIR"

# save vars for smpnote.sh
echo "$NOTE_SAVE_DIR" > "$INSTALL_DIR/vars/USERSAVEDIR"
echo "$INSTALL_DIR" > "$INSTALL_DIR/vars/INSTALLDIR"

echo "Copying files over to Installation directory"
cp smpnote.sh "$INSTALL_DIR/"
cp md2html.py "$INSTALL_DIR/"

# checking if python is installed
pyversion=$(python -V 2>&1 | grep -Po '(?<=Python )(.+)')
if [[ -z "$pyversion" ]]; then
  echo "Python is not Installed! please install it";
  exit 1;
fi

# check if pip is installed
pipversion=$(command -v pip)

if [[ -z "$pipversion" ]]; then
  echo "Pip is not installed, would you like me to install it for you?"
  read -p "(y/n): " tmpvar
  if [ "$tmpvar" = "y" ]; then
    python -m ensurepip --upgrade
  else
    echo "Please install pip before running this setup script again"
    exit 0
  fi
fi

# check if mistletoe is installed and install it
if python -c 'import pkgutil; exit(not pkgutil.find_loader("mistletoe"))'; then
    echo 'mistletoe found'
else
    echo 'mistletoe not found'
    pip install --user mistletoe
fi

echo "DONE"



