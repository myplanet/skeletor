#!/usr/bin/env bash

set -e

mysql -e "CREATE DATABASE IF NOT EXISTS ${PROFILE};"

echo -e 'travis_fold:start:composer-install\\r'
echo  "::Installing composer dependencies"
composer install --no-suggest
echo -e 'travis_fold:end:composer-install\\r'

if [[ -d "${TRAVIS_BUILD_DIR}/web" ]]; then
  WEBROOT=web
elif [[ -d "${TRAVIS_BUILD_DIR}/docroot" ]]; then
  WEBROOT=docroot
else
  echo "ERROR: Unable to find webroot directory"
  exit 1
fi

# Copy local settings file for Travis env to the site folder.
echo  "::Copying local settings file to the site folder"
cp ${TRAVIS_BUILD_DIR}/scripts/travis/assets/settings.local.php ${TRAVIS_BUILD_DIR}/${WEBROOT}/sites/default/settings.local.php

cd ${TRAVIS_BUILD_DIR}/${WEBROOT}

# Install profile to dev DB.
echo  "::Installing profile ${PROFILE}"
drush si $PROFILE -y

export DIR=../config/sync
if [[ -e ${DIR}/*.yml ]]; then
  echo  "::Importing configuration"
  drush -y config-import
fi
drush cache-rebuild
