#!/bin/bash
# Creates a documentation in HTML
# Input file
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FILENAME="$DIR/README.md"

FILECONTENT="$(cat $FILENAME)"

# Outpup file
OUTPUTFILENAME="$DIR/help.html"

# Empty the output file
truncate -s 0 $OUTPUTFILENAME

# Write HTML from github API to the output file
curl https://api.github.com/markdown/raw -X "POST" -H "Content-Type: text/plain" -d "$FILECONTENT" >> $OUTPUTFILENAME

# Replace the internal links to make them work
sed -i -e 's/<a href="#/<a href="#user-content-/g' $OUTPUTFILENAME
