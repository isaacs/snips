#!/bin/bash
! [ -d `date '+%Y-%m-%d'` ] && mkdir `date '+%Y-%m-%d'`
read -p "Title? " t
<<< $t tr '[:upper:]' '[:lower:]' | perl -pi -e 's/[^a-z0-9-]+/-/g;s/-+/-/g;s/^-|-$//g' | read f
! [ -d "`date '+%Y-%m-%d'`/$f" ] && mkdir -p "`date '+%Y-%m-%d'`/$f"
! [ -f "`date '+%Y-%m-%d'`/$f/README.markdown" ] && echo "# $t" > "`date '+%Y-%m-%d'`/$f/README.markdown"
$EDITOR "`date '+%Y-%m-%d'`/$f/README.markdown"