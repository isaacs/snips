#!/bin/bash
mkdir `date '+%Y-%m-%d'`
read -p "Title? " t
cat >> "`date '+%Y-%m-%d'`/$t"