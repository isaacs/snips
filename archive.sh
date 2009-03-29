#!/bin/bash
git stash
(
cat README.markdown
ls -F \
|egrep '[0-9]{4}(-[0-9]{2}){2}/$'\
|sort -r\
|sed 's|/$||'\
|while read DATE; do
	cd $DATE &>/dev/null
	echo ""
	echo "## $DATE"
	ls -trF | egrep /$ | while read POST; do
		cd $POST &>/dev/null
		pl=../$DATE/$POST
		e=${pl//\//\\/}
		e=${e//\$/\\\$}
		echo ""
		echo [$pl]: $pl
		cat README.markdown\
		| perl -pi -e 's/^#([^#].*)$/#$1 [∞]['$e']/'\
		| sed 's|^#|###|g'
	done
done
) > archive/README.markdown \
&& git add archive/README.markdown &&\
git commit -m "Generate archive"