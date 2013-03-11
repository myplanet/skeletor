#!/bin/bash
#
# This is a project kickstarting script
# This script does the work of initializing rerun (you don't need to know what that is)
# And then building the site based on the make files found in the project
# It will always build the current branch you are sitting on.

PATHTOHERE=`pwd`
CURRENTBRANCH=`git rev-parse --abbrev-ref HEAD`

if [ -z "$1" ]; then
    echo "Usage: kickstart.sh DocRoot"
    echo "Where DocRoot is where you project is built to. e.g. /var/www/projectName/docroot"
else
    git submodule update --init --recursive

    export PATH=${PATH}:$PATHTOHERE/tmp/scripts/rerun/core
    export RERUN_MODULES=$PATHTOHERE/tmp/scripts/rerun/custom_modules
    PROJECT_NAME=`expr "$(ls *.profile 2>&1)" : '^\(.*\)\.profile$'`
    rerun 2ndlevel:build --project $PROJECT_NAME --buildfile build-${PROJECT_NAME}.make --destination $1 --revision $CURRENTBRANCH

fi
