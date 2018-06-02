#!/bin/bash
# Create a documentation  for PGXN, the link differ from GitHun to PGXN
# Input file
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FILENAME="$DIR/README.md"

# Export file
EXPORTFILENAME="$DIR/PGXNREADME.md"

# Always start with an empty file
truncate -s 0 $EXPORTFILENAME

while read -r line
do

	if [[ $line =~ "](#" ]]
	then
		POS1=`expr index "$line" [`
		POS2=`expr index "$line" ]`
		SUB=$POS2-$POS1-1
		TXT=${line:$POS1:$SUB}
		TXT=${TXT/ /-}

		POS1=$POS2+2
		TXT2=${line:$POS1:$SUB}

		line=${line/$TXT2/$TXT}
	fi

	echo "$line" >> "$EXPORTFILENAME"
done < "$FILENAME"
