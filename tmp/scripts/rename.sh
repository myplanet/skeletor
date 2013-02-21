#!/bin/sh

### README
#
# This script will rename files and file contents from `skeletor` to a project
# machine name of your choosing.
#
# USAGE: `./rename.sh myproject`

PROJECT=$1
: ${PROJECT:?"Please supply a project machine name as an argument."}

for file in `grep -il "skeletor" *.*`
do
  sed "s/skeletor/downsview/g" $file
done

REGEX_FIND="\(.*\)skeletor\(.*\)"
REGEX_REPLACE="mv & \1$PROJECT\2"
find . -name "skeletor.*" | sed "s/$REGEX_FIND/$REGEX_REPLACE/"
