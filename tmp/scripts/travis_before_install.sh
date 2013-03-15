#!/usr/bin/env bash

# Create MySQL Database
mysql -e "CREATE DATABASE drupal;"

# Install Drush (Drupal CLI tool)
pear channel-discover pear.drush.org
pear install drush/drush-$DRUSH_VERSION
phpenv rehash

# Install Composer (PHP package manager)
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Install httpie
sudo add-apt-repository ppa:afcowie/network --yes
sudo apt-get update \
  --option Dir::Etc::sourcelist="sources.list.d/afcowie-network-precise.list" \
  --option Dir::Etc::sourceparts="-" \
  --option APT::Get::LVist-Cleanup="0"
apt-get install httpie
