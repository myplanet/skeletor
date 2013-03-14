#!/usr/bin/env bash

# Build Drupal site
cd $TRAVIS_BUILD_DIR
cat build-*.make | sed "s/develop/$TRAVIS_COMMIT/g" | drush make --prepare-install php://stdin build

cd $TRAVIS_BUILD_DIR/tmp/tests

# Install testing dependencies
composer install

# Install non-fresh npm from repo.
sudo apt-get update -qq
sudo apt-get install npm -q

# Install se-interpreter node app.
sudo npm install -g se-interpreter
