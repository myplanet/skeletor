#!/usr/bin/env bash

# Start serving the site
php -S 127.0.0.1:8080 -t $TRAVIS_BUILD_DIR/build &

# Running selenium tests.
cd $TRAVIS_BUILD_DIR/tmp/tests
vendor/bin/paratest -p 2 -f --phpunit=vendor/bin/phpunit WebDriverDemo.php
