#!/bin/bash
! [ -d `date '+%Y-%m-%d'` ] && mkdir `date '+%Y-%m-%d'`
read -p "Title? " t
$EDITOR "`date '+%Y-%m-%d'`/$t.markdown"