#!/bin/bash
#
# This is a project kickstarting script
# This script does the work of initializing rerun (you don't need to know what that is)
# And then building the site based on the make files found in the project

PATHTOHERE=`pwd`

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: kickstart ProjectName DocRoot"
    echo "Where ProjectName is the name used in your build script files. e.g. build-ProjectName.make"
    echo "Where DocRoot is where you project is built to. e.g. /var/www/projectName/docroot"
else
    git submodule update --init --recursive

    export PATH=${PATH}:$PATHTOHERE/tmp/scripts/rerun/core
    export RERUN_MODULES=$PATHTOHERE/tmp/scripts/rerun/custom_modules
    rerun 2ndlevel:build --project $1 --buildfile build-"$1".make --destination $2 --revision master

fi
