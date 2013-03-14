#!/usr/bin/env bash

# Build Drupal site
cd $TRAVIS_BUILD_DIR
cat build-*.make | sed "s/develop/$TRAVIS_COMMIT/g" | drush make --prepare-install php://stdin build

cd $TRAVIS_BUILD_DIR/tmp/tests

# Install testing dependencies
composer install

# Installs npm
# http://www.macaronicenglish.com/2012/10/install-nodejs-from-linux-binaries.html
VERSION=0.8.18
PLATFORM=linux
ARCH=x86

cd ~
wget http://nodejs.org/dist/v$VERSION/node-v$VERSION-linux-x86.tar.gz
tar xzvf node-v$VERSION-linux-x86.tar.gz
rm node-v$VERSION-linux-x86.tar.gz

sudo ln -s ~/node-v$VERSION-linux-x86/bin/n /bin/node
sudo ln -s ~/node-v$VERSION-linux-x86/bin/npm /bin/npm
sudo ln -s ~/node-v$VERSION-linux-x86/bin/node-waf /bin/node-waf

# Install se-interpreter node app.
sudo npm install -g se-interpreter
