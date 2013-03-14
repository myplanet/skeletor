#!/usr/bin/env bash

# Build Drupal site
cd $TRAVIS_BUILD_DIR
cat build-*.make | sed "s/develop/$TRAVIS_COMMIT/g" | drush make --prepare-install php://stdin build

cd $TRAVIS_BUILD_DIR/tmp/tests

# Install testing dependencies
composer install

# Install npm
curl https://raw.github.com/creationix/nvm/master/install.sh | sh
nvm install 0.8

# Install se-interpreter node app.
sudo npm install -g se-interpreter
