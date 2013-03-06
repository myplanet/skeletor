#!/usr/bin/env bash

# Create MySQL Database
mysql -e "CREATE DATABASE drupal;"

# Install Drush
pear channel-discover pear.drush.org
pear install drush/drush-$DRUSH_VERSION
phpenv rehash
