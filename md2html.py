#!/usr/bin/python

import sys
import getopt
import markdown

# Function to convert markdown to html using markdown 
def converter(infile, outfile):
    with open(infile, 'r') as f:
        text = f.read()
        html = markdown.markdown(text)

    with open(outfile, 'w') as f:
        f.write(html)

def main(argv) {
    infile=''
    outfile=''
    try:
        opts, args = getopt.getopt(argv, "i:o:", [ "ifile=","ofile=" ])
    except getopt.GetoptError:
        print 'md2html.py -i <input> -o <output>'
        sys.exit(1)
    for opt, arg in opts:
        if opt in ("-i", "--ifile"):
            infile = arg
        elif opt in ("-o", "--ofile"):
            outfile = arg

    # Markdown to HTML conversion process
    converter(infile, outfile)
}


if __name__ == "__main__":
    main(sys.argv[1:])
