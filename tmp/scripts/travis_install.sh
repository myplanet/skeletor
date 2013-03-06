#!/usr/bin/env bash

# Build drupal site
cd $TRAVIS_BUILD_DIR
cat build-*.make | sed "s/develop/$TRAVIS_COMMIT/g" | drush make --prepare-install php://stdin build
