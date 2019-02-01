#!/usr/bin/env bash

set -e

mysql -e "CREATE DATABASE IF NOT EXISTS ${PROFILE};"

# Run the make script.
echo "::Running build"
COMPOSER_COMMAND="install";

# If this isn't a pull request, pass the production flag.
if [[ $TRAVIS_PULL_REQUEST == 'false' ]]; then
  echo "::Using production settings."
  COMPOSER_COMMAND="deploy";
fi

composer $COMPOSER_COMMAND

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
