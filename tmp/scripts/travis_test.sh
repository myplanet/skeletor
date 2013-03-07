#!/usr/bin/env bash

# In background process, wait for sauce connect tunnel to connect,
# then quit (for now).
while true; do
  if [ -e /tmp/sauce-connect-tunnel-ready ]; then
    cd $TRAVIS_BUILD_DIR/tmp/tests
    vendor/bin/paratest -p 2 -f --phpunit=vendor/bin/phpunit WebDriverDemo.php
  fi
  sleep 1
done &

# Set up Sauce Connect tunnel
cd $TRAVIS_BUILD_DIR/tmp/tests
vendor/bin/sauce_connect --readyfile=/tmp/sauce-connect-tunnel-ready
