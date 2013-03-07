#!/usr/bin/env bash

# In background process, loop every second until sauce connect tunnels.
while true; do
  sleep 1
  # Loop back until readyfile exists.
  if [ ! -e /tmp/sauce-connect-tunnel-ready ]; then continue; fi

  # Run tests and break from loop.
  cd $TRAVIS_BUILD_DIR/tmp/tests
  vendor/bin/paratest -p 2 -f --phpunit=vendor/bin/phpunit WebDriverDemo.php
  break
done &

# Set up Sauce Connect tunnel
cd $TRAVIS_BUILD_DIR/tmp/tests
vendor/bin/sauce_connect --readyfile=/tmp/sauce-connect-tunnel-ready
