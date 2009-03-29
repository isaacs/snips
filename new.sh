#!/bin/bash
d=$(date '+%Y-%m-%d')
! [ -d $d ] && mkdir $d
read -p "Title? " t && echo $t \
|tr '[:upper:]' '[:lower:]'\
|perl -pi -e 's/[^a-z0-9-]+/-/g;s/-+/-/g;s/^-|-$//g'\
|(cat; echo "")\
|while read f; do
	f="$d/$f"
	! [ -d "$f" ] && mkdir -p "$f"
	f="$f/README.markdown"
	! [ -f "$f" ] && echo "# $t" > "$f"
	$EDITOR "$f" && git add "$f" && git commit
done
./archive.sh
