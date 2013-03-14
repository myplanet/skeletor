#!/usr/bin/env bash

# Build Drupal site
cd $TRAVIS_BUILD_DIR
cat build-*.make | sed "s/develop/$TRAVIS_COMMIT/g" | drush make --prepare-install php://stdin build

cd $TRAVIS_BUILD_DIR/tmp/tests

# Install testing dependencies
composer install

# Install beta SeInterpreter by downloading containing repo
INTERPRETER_DIR="/tmp/se-interpreter-$RANDOM"
REPO_ARCHIVE_URL="https://github.com/sebuilder/se-builder/archive/gh-pages.zip"
REPO_ARCHIVE_DOWNLOAD="se-builder-gh-pages.zip"
INTERPRETER_FILENAME="SeInterpreter*.zip"

mkdir -p $INTERPRETER_DIR
cd $INTERPRETER_DIR
curl --location $REPO_ARCHIVE_URL > $REPO_ARCHIVE_DOWNLOAD
unzip $REPO_ARCHIVE_DOWNLOAD
rm $REPO_ARCHIVE_DOWNLOAD
unzip se-builder-gh-pages/$INTERPRETER_FILENAME
