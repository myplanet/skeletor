#!/usr/bin/env bash

# In background process, loop every second until sauce connect tunnels.
while true; do
  sleep 1
  # Loop back until readyfile exists.
  if [ ! -e /tmp/sauce-connect-tunnel-ready ]; then continue; fi

  # Run tests and break from loop.
  cd $TRAVIS_BUILD_DIR/tmp/tests
  vendor/bin/paratest -p 2 -f --phpunit=vendor/bin/phpunit WebDriverDemo.php
  service sauceconnect stop
  break
done &

cat <<EOH | sudo tee /etc/init/sauceconnect.conf
description "SauceLabs SauceConnect Service"
author "Patrick Connolly"

start on runlevel [3]
stop on shutdown

expect fork

script
    cd $TRAVIS_BUILD_DIR/tmp/tests
    vendor/bin/sauce_connect --readyfile=/tmp/sauce-connect-tunnel-ready
    emit sauceconnect_running
end script
EOH


# Set up Sauce Connect tunnel
cd $TRAVIS_BUILD_DIR/tmp/tests
service sauceconnect start
