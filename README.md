# Simple Note CLI (smpnote)
	A simple note taking bash script.

# About
Ever wanted a simple and easy way to make timestamped notes through the command line? Then just use smp-note.
smp-note is a simple bash script that automates my own personal markdown note taking on a day to day basis.

The script automatically creates a directory `/smp-note/` in your home directory and anytime you make a new note the script stores that note in the following file structure: `~/smp-note/YYYY/MM/DD.md`
Every day has its own file and every entry is automatically timestamped. The files of course are in markdown, but you can change the file format by editing the script just a bit. You can specify a custom directory if you want to store the markdown file somewhere else but i havent added a way to set a permanent custom directory for the script.

Feel free to add the script to your path so you can use it globally

## Example usage
`smpnote <title>`
`smpnote <title> <custom-directory>` 

## Planned upcoming features
Powershell version (for Windows)
Markdown to HTML parser. ( Might be made in rust. )


	Feel free to contribute or fork the repository to make your own changes to the script.
