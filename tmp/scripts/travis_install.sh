#!/usr/bin/env bash

# Build Drupal site
cd $TRAVIS_BUILD_DIR
cat build-*.make | sed "s/develop/$TRAVIS_COMMIT/g" | drush make --prepare-install php://stdin build

cd $TRAVIS_BUILD_DIR/tmp/tests

# Install testing dependencies
composer install

# Installs npm to $HOME/node/bin/npm
curl https://gist.github.com/patcon/5164594/raw/16a178a57aac404e2a4ed3dacfbf4fa4d11143b3/install-nodejs.sh | bash

# Install se-interpreter node app.
sudo $HOME/node/bin/npm install -g se-interpreter
