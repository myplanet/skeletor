#!/usr/bin/env bash

# Build Drupal site
cd $TRAVIS_BUILD_DIR
cat build-*.make | sed "s/develop/$TRAVIS_COMMIT/g" | drush make --prepare-install php://stdin build

cd $TRAVIS_BUILD_DIR/tmp/tests

# Install testing dependencies
composer install

# Sources uninitialized nvm and installs correct node/npm.
source ~/.nvm/nvm.sh
# Lots of output while building npm, so silencing
echo "Installing npm v0.8.18. This may take several minutes..."
nvm install v0.8.18 > /dev/null
nvm use v0.8.18

# Install se-interpreter node app.
sudo npm install -g se-interpreter
