#!/bin/bash

DIR_PREF="calculus-"
FILE_PREF="section_"
COMMIT_MESSAGE="default/progress"

if [ $# == 1 ]; then
	echo "commit message: $1"
	COMMIT_MESSAGE="$1"
fi

while true; do
	DIR_PREF+="I"
	if ! [ -d "$DIR_PREF" ]; then
		break;
	fi
	echo "cd $DIR_PREF"
	cd "$DIR_PREF"
	
	IDX=0
	while true; do
		IDX=$(( $IDX + 1 ))
		FILE="$FILE_PREF$IDX.tex"
		if ! [ -f "$FILE" ]; then
			break;
		fi
		echo "adding $FILE"
		git add "$FILE"
	done

	git add source.tex
	git add source.pdf

	echo "cd .."
	cd ..
done

git add assets
git add preamble.sty

echo "$COMMIT_MESSAGE"
git commit -m "$COMMIT_MESSAGE"

git push origin master
