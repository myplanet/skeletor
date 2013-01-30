#!/bin/bash
#
# This is an initialization script for the tools required to make everything work
# @TODO explain this better - but the code should speak for itself


PATHTOHERE=`pwd`

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: tools-init ProjectName DocRoot"
    echo "Where ProjectName is the name used in your build script files. e.g. build-ProjectName.make"
    echo "Where DocRoot is where you project is built to. e.g. /var/www/projectName/docroot"
else
    git submodule update --init --recursive

    export PATH=${PATH}:$PATHTOHERE/tmp/scripts/rerun/core
    export RERUN_MODULES=$PATHTOHERE/tmp/scripts/rerun/custom_modules
    rerun 2ndlevel:build --project $1 --buildfile build-"$1".make --destination $2 --revision master

fi
