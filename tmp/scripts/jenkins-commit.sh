#!/bin/bash

# Prepare workspace to run commit stage tests on Jenkins.
cd $WORKSPACE
mkdir logs/

# Tests for Drupal coding standards via PHP_CodeSniffer.
cd $WORKSPACE/profile
bash tmp/scripts/test-drupalcs.sh
mv checkstyle.xml ../logs/
