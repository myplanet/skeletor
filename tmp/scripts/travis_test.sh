#!/usr/bin/env bash

# Start serving the site
php \
  --server 127.0.0.1:8080 \
  --docroot $TRAVIS_BUILD_DIR/build &

# Running selenium tests.
cd $TRAVIS_BUILD_DIR/tmp/tests
vendor/bin/paratest WebDriverDemo.php \
  --processes 2 \
  --functional \
  --phpunit vendor/bin/phpunit
