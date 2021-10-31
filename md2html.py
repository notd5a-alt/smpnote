#!/usr/bin/python

import sys
import getopt

# HTML file beginning
preq = """
<!DOCTYPE html>
<html>
<head>
    <title>Rendered HTML</title>
    <link rel="stylesheet" href="style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/prism/1.5.0/themes/prism.min.css"/>
</head>
<body>

"""

# HTML file ending
subq = """

<script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.5.0/prism.min.js"></script>
</body>
</html>
"""

# CSS for the html
style = """
html {
    background-color: #252A34;
}

img {
    display: block;
    margin-left: auto;
    margin-right: auto;
    width: 90%;
}

a {
    font-weight: 800;
    color: #08D9D6;
}

blockquote {
    background: #2C394B;
    border-left: 10px solid #ccc;
    margin: 1.5em 10px;
    padding: 0.5em 10px;
    quotes: "\201C""\201D""\2018""\2019";
}

body {
    color: #EAEAEA;
    margin: 5% 10% 5% 10%;
    font-family: 'Sora', sans-serif;
    font-size: 15px;
    font-weight: 400;

    overflow-wrap: break-word;
    word-wrap: break-word;

    -ms-word-break: break-all;
    /* This is the dangerous one in WebKit, as it breaks things wherever */
    word-break: break-all;
    /* Instead use this non-standard one: */
    word-break: break-word;

    /* Adds a hyphen where the word breaks, if supported (No Blink) */
    -ms-hyphens: auto;
    -moz-hyphens: auto;
    -webkit-hyphens: auto;
    hyphens: auto;
}

h1 {
    color: #08D9D6;
    font-size: 40px;
    font-weight: 800;
}
"""

import mistletoe

# Function to convert markdown to html using markdown 
def converter(infile, outfile):
    # flexible adding of markdown->html into an existing file
    try:
        with open(infile, 'r') as f:
            rendered = mistletoe.markdown(f)
    except FileNotFoundError:
        print("Please use absolute or full paths when parsing notes")
        print("We couldnt find the input file you wanted to use!")
    try:
        with open(outfile, 'w') as f:
            f.write(preq)
            f.write(rendered)
            f.write(subq)
    except FileNotFoundError:
        print("Please use absolute or full paths when parsing notes")
        print("We couldnt find the output file you wanted to use!")

def create_stylesheet(infile, outfile, stylefile):
    try:
        with open(stylefile, 'w') as f:
            f.write(style)
    except FileNotFoundError:
        print("Please use absolute or full paths when parsing notes")
        print("We couldnt create the stylesheet!")

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
