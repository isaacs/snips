#!/bin/bash
didstash=0
git stash && didstash=1
(
	cat header.markdown 2>/dev/null
	ls -F \
	|egrep '[0-9]{4}(-[0-9]{2}){2}/$'\
	|sort -r\
	|sed 's|/$||'\
	|while read DATE; do
		cd $DATE &>/dev/null
		diddate=0
		ls -trF | egrep /$ | while read POST; do
			[ $diddate == 0 ] && echo "" && echo "## $DATE" && let 'diddate ++'
			cd $POST &>/dev/null
			pl=$DATE/$POST
			e=${pl//\//\\/}
			e=${e//\$/\\\$}
			echo ""
			echo [$pl]: $pl
			cat README.markdown\
			| perl -pi -e 's/^#([^#].*)$/#$1 [∞]['$e']/'\
			| sed 's|^#|###|g'
		done
	done
) > README.markdown \
&& git add README.markdown\
&& git commit -m "Generate archive"
[ $didstash -eq 1 ] && git stash pop