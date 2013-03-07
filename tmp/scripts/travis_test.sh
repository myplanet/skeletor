#!/usr/bin/env bash

# Creating and starting SauceConnect service.
sudo mkdir /var/log/sauce

sudo tee /etc/default/sauce-connect > /dev/null <<EOH
JAVA=/usr/bin/java
SAUCE_CONNECT=$TRAVIS_BUILD_DIR/tmp/tests/vendor/sauce/connect/lib/Sauce-Connect.jar
API_USER=$SAUCE_USERNAME
API_KEY=$SAUCE_ACCESS_KEY
USERNAME=
GROUP=
READYFILE=/tmp/sauce-connect-tunnel-ready
LOG_DIR=/var/log/sauce
EOH

sudo cp $TRAVIS_BUILD_DIR/tmp/tests/sauce-connect.init /etc/init.d/sauce-connect
sudo chmod 755 /etc/init.d/sauce-connect
sudo /etc/init.d/sauce-connect start

while [ ! -e /tmp/sauce-connect-tunnel-ready ]; do
  echo "Waiting for SauceConnect tunnel..."
  sleep 2
done

# Running selenium tests.
cd $TRAVIS_BUILD_DIR/tmp/tests
vendor/bin/paratest -p 2 -f --phpunit=vendor/bin/phpunit WebDriverDemo.php

# Shutting down tunnel.
sudo /etc/init.d/sauce-connect stop
sleep 2

cat /var/log/sauce/sauce_connect.log
