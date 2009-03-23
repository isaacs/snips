#!/bin/bash
! [ -d `date '+%Y-%m-%d'` ] && mkdir `date '+%Y-%m-%d'`
read -p "Title? " t
echo $t | tr '[:upper:]' '[:lower:]' | perl -pi -e 's/[^a-z0-9-]+/-/g;s/-+/-/g;s/^-|-$//g' | read f
! [ -f "`date '+%Y-%m-%d'`/$f.markdown" ] && echo "# $t" > "`date '+%Y-%m-%d'`/$f.markdown"
$EDITOR "`date '+%Y-%m-%d'`/$f.markdown"