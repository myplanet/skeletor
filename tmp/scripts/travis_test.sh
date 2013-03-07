#!/usr/bin/env bash

# In background process, wait for sauce connect tunnel to connect,
# then quit (for now).
while true; do
  if [ -e /tmp/sauce-connect-tunnel-ready ]; then
    vendor/bin/paratest -p 2 -f --phpunit=vendor/bin/phpunit tmp/tests/WebDriverDemo.php
  fi
  sleep 1
done &

# Set up Sauce Connect tunnel
vendor/bin/sauce_connect --readyfile=/tmp/sauce-connect-tunnel-ready
