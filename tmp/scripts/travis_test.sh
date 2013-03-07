#!/usr/bin/env bash

sudo mkdir /var/log/sauce
sudo tee /etc/default/sauce-connect > /dev/null <<EOH
JAVA=/usr/bin/java
SAUCE_CONNECT=$TRAVIS_BUILD_DIR/tmp/tests/vendor/sauce/connect/lib/Sauce-Connect.jar
API_USER=$SAUCE_USERNAME
API_KEY=$SAUCE_ACCESS_KEY
USERNAME=
GROUP=
LOG_DIR=/var/log/sauce
EOH

(cd /etc/init.d && sudo curl -o sauce-connect https://raw.github.com/rtyler/puppet-sauceconnect/master/files/init.d_sauce-connect && sudo chmod 755 sauce-connect)
sudo /etc/init.d/sauce-connect start
sleep 60
cd $TRAVIS_BUILD_DIR/tmp/tests
vendor/bin/paratest -p 2 -f --phpunit=vendor/bin/phpunit WebDriverDemo.php
ps ax |grep java
sudo ls /var/log/sauce
sudo cat /var/log/sauce/sauce-connect.log
sudo /etc/init.d/sauce-connect stop
