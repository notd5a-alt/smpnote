# Simple Note CLI (smpnote)
	A simple note taking bash script.

# About
Ever wanted a simple and easy way to make timestamped notes through the command line? Then just use smp-note.
smp-note is a simple bash script that automates my own personal markdown note taking on a day to day basis.

The script automatically creates a directory `/smp-note/` in your home directory and anytime you make a new note the script stores that note in the following file structure: `~/smp-note/YYYY/MM/DD.md`
Every day has its own file and every entry is automatically timestamped. The files of course are in markdown, but you can change the file format by editing the script just a bit. You can specify a custom directory if you want to store the markdown file somewhere else but i havent added a way to set a permanent custom directory for the script.

# Setup
You probably want to use the script globally so first thing you are probably going to want to do is add the script to your path
Now keep note of wherever you installed it just go into your `.bashrc` or `.zshrc` depending on which shell your using and add the following:
```sh
export PATH="$PATH:/installation/directory"

# Below you can make the script easier to use by aliasing it to whatever you want so you dont have to type `smpnote.sh` every time.
alias smpnote="smpnote.sh"
```

There are other methods to add to path and its not too hard to set up this script. You can even move the script to your: `/usr/local/bin` directory which is usually already added to path:
```sh
cp /some/dir/smpnote.sh /usr/local/bin
```

On line 17 you can also change the following to change which editor you want to use:
```sh
10 # Change this to your editor of choice
11 editor() { vim $1 }
```
I like VIM so i use it by default but you can use `nano` or `emacs` or even GUI applications that can launch through the terminal like Visual Studio `code`.

## Example usage
`smpnote <title>`
`smpnote <title> <custom-directory>`
`smpnote 'My first entry'`

## Planned upcoming features
Powershell version (for Windows)
Markdown to HTML parser. ( Might be made in rust. )


	Feel free to contribute or fork the repository to make your own changes to the script.
