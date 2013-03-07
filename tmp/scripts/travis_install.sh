#!/usr/bin/env bash

# Build Drupal site
cd $TRAVIS_BUILD_DIR
cat build-*.make | sed "s/develop/$TRAVIS_COMMIT/g" | drush make --prepare-install php://stdin build

# Install testing dependencies
composer install

# Prepare Sauce Labs configs
vendor/bin/sauce_config $SAUCE_USERNAME $SAUCE_ACCESS_KEY

# Start serving the site
php -S localhost:8000 -t $TRAVIS_BUILD_DIR/build &
