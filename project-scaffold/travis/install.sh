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

echo -e 'travis_fold:start:drush-site-install\\r'
if [[ -f "${TRAVIS_BUILD_DIR}/config/sync/system.site.yml"  ]]; then
  # Install site from existing config if present.
  echo  "::Installing from site config"
  drush site:install --yes --existing-config
else
  echo  "::Installing profile ${PROFILE}"
  drush site:install --yes ${PROFILE}
fi
echo -e 'travis_fold:end:drush-site-install\\r'
