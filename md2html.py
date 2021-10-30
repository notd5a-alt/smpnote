#!/usr/bin/python

import sys
import getopt
import markdown

# HTML file beginning
preq = """
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="style.css">
</head>
<body>

"""

# HTML file ending
subq = """


</body>
</html>
"""

# CSS for the html
style = """


"""

# Function to convert markdown to html using markdown 
def converter(infile, outfile):
    # flexible adding of markdown->html into an existing file
    with open(infile, 'r') as f:
        text = f.read()
        html = markdown.markdown(text)
    with open(outfile, 'w') as f:
        f.write(preq)
        f.write(html)
        f.write(subq)

def create_stylesheet(infile, outfile, stylefile):
    with open(stylefile, 'w') as f:
        f.write(style)

def main(argv):
    infile=""
    outfile=""
    stylefile=""
    try:
        opts, args = getopt.getopt(argv, "i:o:s:", [ "ifile=","ofile=","sfile="])
    except getopt.GetoptError:
        print("md2html.py -i <input> -o <output>")
        sys.exit(1)
    for opt, arg in opts:
        if opt in ("-i", "--ifile"):
            infile = arg
        elif opt in ("-o", "--ofile"):
            outfile = arg
        elif opt in ("-s", "--sfile"):
            stylefile = arg

    # Markdown to HTML conversion process
    create_stylesheet(infile, outfile, stylefile)
    converter(infile, outfile)

if __name__ == "__main__":
    main(sys.argv[1:])
